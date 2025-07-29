import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class ChatServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  /// Uploads any file (image/audio) and returns the download URL
  Future<String> uploadFile(File file, String folderName) async {
    final fileId = const Uuid().v4();
    final ref = _storage.ref().child('$folderName/$fileId');
    await ref.putFile(file);
    return await ref.getDownloadURL();
  }

  /// Sends a chat message with optional text, image, or audio
  Future<void> sendMessage({
    required String senderId,
    required String receiverId,
    String? text,
    String? imageUrl,
    String? audioUrl,
  }) async {
    await _firestore.collection('chats').add({
      'sender_id': senderId,
      'receiver_id': receiverId,
      'timestamp': FieldValue.serverTimestamp(),
      'text': text ?? '',
      'image_url': imageUrl ?? '',
      'audio_url': audioUrl ?? '',
    });
  }
}
