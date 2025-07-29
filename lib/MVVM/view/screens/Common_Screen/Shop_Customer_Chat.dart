import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/utils/color.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class ShopCustomerChat extends StatefulWidget {
  final String senderId;
  final String receiverId;

  const ShopCustomerChat({
    super.key,
    required this.senderId,
    required this.receiverId,
  });

  @override
  State<ShopCustomerChat> createState() => _ShopCustomerChatState();
}

class _ShopCustomerChatState extends State<ShopCustomerChat> {
  final TextEditingController _messageController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  FlutterSoundRecorder? _audioRecorder;
  bool _isRecording = false;
  String? _recordedFilePath;

  @override
  void initState() {
    super.initState();
    _audioRecorder = FlutterSoundRecorder();
    _initRecorder();
  }

  Future<void> _initRecorder() async {
    await _audioRecorder!.openRecorder();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _audioRecorder?.closeRecorder();
    super.dispose();
  }

  Future<void> _sendMessage({
    String? text,
    String? imageUrl,
    String? audioUrl,
  }) async {
    if ((text == null || text.trim().isEmpty) &&
        imageUrl == null &&
        audioUrl == null) return;

    await _firestore.collection('messages').add({
      'text': text ?? '',
      'image_url': imageUrl ?? '',
      'audio_url': audioUrl ?? '',
      'senderId': widget.senderId,
      'receiverId': widget.receiverId,
      'timestamp': Timestamp.now(),
    });

    _messageController.clear();
  }

  Future<void> _pickImage() async {
    final picked =
        await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 75);
    if (picked != null) {
      final ref = FirebaseStorage.instance
          .ref()
          .child('chat_images')
          .child('${const Uuid().v4()}.jpg');
      await ref.putFile(File(picked.path));
      final imageUrl = await ref.getDownloadURL();
      _sendMessage(imageUrl: imageUrl);
    }
  }

  Future<void> _startRecording() async {
    final dir = await getTemporaryDirectory();
    _recordedFilePath = '${dir.path}/${const Uuid().v4()}.aac';
    await _audioRecorder!.startRecorder(toFile: _recordedFilePath);
    setState(() => _isRecording = true);
  }

  Future<void> _stopRecording() async {
    await _audioRecorder!.stopRecorder();
    setState(() => _isRecording = false);
    if (_recordedFilePath != null) {
      final ref = FirebaseStorage.instance
          .ref()
          .child('chat_audio')
          .child('${const Uuid().v4()}.aac');
      await ref.putFile(File(_recordedFilePath!));
      final audioUrl = await ref.getDownloadURL();
      _sendMessage(audioUrl: audioUrl);
    }
  }

  Widget _buildMessage(DocumentSnapshot doc) {
    final msg = doc.data() as Map<String, dynamic>;
    final isMe = msg['senderId'] == widget.senderId;

    return GestureDetector(
      onLongPress: () {
        if (isMe) {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text("Delete Message"),
              content: const Text("Are you sure you want to delete this message?"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () async {
                    await _firestore.collection('messages').doc(doc.id).delete();
                    Navigator.pop(context);
                  },
                  child: const Text("Delete", style: TextStyle(color: Colors.red)),
                )
              ],
            ),
          );
        }
      },
      child: Align(
        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isMe ? toggle2color : Colors.grey[200],
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(12),
              topRight: const Radius.circular(12),
              bottomLeft: Radius.circular(isMe ? 12 : 0),
              bottomRight: Radius.circular(isMe ? 0 : 12),
            ),
          ),
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              if (msg['text'] != null && msg['text'].toString().isNotEmpty)
                Text(
                  msg['text'],
                  style: TextStyle(color: isMe ? Colors.white : Colors.black),
                ),
              if (msg['image_url'] != null &&
                  msg['image_url'].toString().isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      msg['image_url'],
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              if (msg['audio_url'] != null &&
                  msg['audio_url'].toString().isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: IconButton(
                    icon: Icon(Icons.play_arrow,
                        color: isMe ? Colors.white : Colors.black),
                    onPressed: () async {
                      final player = FlutterSoundPlayer();
                      await player.openPlayer();
                      await player.startPlayer(
                        fromURI: msg['audio_url'],
                        whenFinished: () => player.closePlayer(),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: toggle2color,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: _firestore
                  .collection('messages')
                  .orderBy('timestamp')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
                final docs = snapshot.data!.docs.where((doc) {
                  final data = doc.data() as Map<String, dynamic>;
                  return (data['senderId'] == widget.senderId &&
                          data['receiverId'] == widget.receiverId) ||
                      (data['senderId'] == widget.receiverId &&
                          data['receiverId'] == widget.senderId);
                }).toList();
                return ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: docs.length,
                  itemBuilder: (_, i) => _buildMessage(docs[i]),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            color: Colors.white,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.image),
                  onPressed: _pickImage,
                ),
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Type a message',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(_isRecording ? Icons.stop : Icons.mic),
                  onPressed: _isRecording ? _stopRecording : _startRecording,
                  color: _isRecording ? Colors.red : Colors.black,
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () => _sendMessage(text: _messageController.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
