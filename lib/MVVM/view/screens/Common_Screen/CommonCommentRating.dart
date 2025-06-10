import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/utils/color.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/utils/custome/customebutton.dart';

class CommonCommentRating extends StatefulWidget {
  String name;
   CommonCommentRating({super.key,required this .name});

  @override
  State<CommonCommentRating> createState() => _CommonCommentRatingState();
}

class _CommonCommentRatingState extends State<CommonCommentRating> {
  final _comments = TextEditingController();
  double _rating = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.keyboard_backspace,
              size: 40,
            )),
        title: const Text("Feedback",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: toggle2color,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Comment",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  )
                ],
              ),
              child: TextFormField(
                maxLines: 5,
                controller: _comments,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(16),
                  hintText: "Write your feedback here...",
                  border: InputBorder.none,
                ),
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              "Rating",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // Rating bar
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  )
                ],
              ),
              child: Center(
                child: RatingBar.builder(
                  initialRating: 0,
                  minRating: 0,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  glowColor: greenbutton,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: toggle3color,
                  ),
                  onRatingUpdate: (rating) {
                    setState(() {
                      _rating = rating;
                    });
                  },
                ),
              ),
            ),

            const SizedBox(height: 50),

            Align(
              alignment: Alignment.center,
              child: Customebutton(
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                width: 160,
                hight: 50,
                textsize: 20,
                textcolor: Colors.white,
                onPressed: () async {
                  final user = FirebaseAuth.instance.currentUser;

                  if (user == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content:
                              Text("You must be logged in to send feedback.")),
                    );
                    return;
                  }

                  if (_comments.text.trim().isEmpty && _rating == 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text("Please provide a comment or rating.")),
                    );
                    return;
                  }

                  await FirebaseFirestore.instance
                      .collection('CommentReatings')
                      .add({
                    "user_id": user.uid,
                    "message": _comments.text.trim(),
                    "rating": _rating,
                    "timestamp": FieldValue.serverTimestamp(),
                    'name':widget.name
                  });

                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("Your feedback has been submitted.")),
                  );
                },
                text: "Send",
                color: WidgetStatePropertyAll(toggle3color),
              ),
            )
          ],
        ),
      ),
    );
  }
}
