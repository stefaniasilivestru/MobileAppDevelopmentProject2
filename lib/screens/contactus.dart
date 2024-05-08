import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:project2_flutter/screens/profile.dart';

class ContactusPage extends StatefulWidget {
  const ContactusPage({super.key});

  @override
  _ContactusPageState createState() => _ContactusPageState();
}

class _ContactusPageState extends State<ContactusPage> {

  final TextEditingController _commentController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  int _rating = 0;

  @override
  Widget build(BuildContext context) {

    User? user = _auth.currentUser;
    Logger().d('User: $user');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1c2143),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 24.0,
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text('Feedback'),
      ),
      body:Padding (
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children:<Widget> [
            TextFormField(
              controller: _commentController,
              decoration: const InputDecoration(
                labelText: 'Comment',
                hintText: 'Type your feedback here',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(16.0),

              ),
            ),
            const SizedBox(height: 16.0),
            const Text('Rating',
              style: TextStyle(fontSize: 18.0, color: Color(0xFF1c2143), fontWeight: FontWeight.bold
              ),
            ),
            Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(_rating >= 1 ? Icons.star : Icons.star_border),
                  onPressed: () {
                    setState(() {
                      _rating = 1;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(_rating >= 2 ? Icons.star : Icons.star_border),
                  onPressed: () {
                    setState(() {
                      _rating = 2;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(_rating >= 3 ? Icons.star : Icons.star_border),
                  onPressed: () {
                    setState(() {
                      _rating = 3;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(_rating >= 4 ? Icons.star : Icons.star_border),
                  onPressed: () {
                    setState(() {
                      _rating = 4;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(_rating >= 5 ? Icons.star : Icons.star_border),
                  onPressed: () {
                    setState(() {
                      _rating = 5;
                    });
                  },
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                // send feedback
                _submitFeedback(context, user);
                Logger().d('Feedback submitted: $_rating stars, comment: ${_commentController.text}, User: $user');

              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF1c2143)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
              ),
              child: const Text(
                'Send',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            // Perform read operation of feedbacks
            StreamBuilder(
                stream: FirebaseDatabase.instance.reference().child('feedback').onValue,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return const Text('Error loading feedbacks');
                  } else {
                    List<Widget> feedbacks = [];
                    Map<dynamic, dynamic> feedbacksMap = snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
                    if (feedbacksMap != null) {
                      feedbacksMap.forEach((key, value) {
                        feedbacks.add(
                          ListTile(
                            title: Text(
                                value['comment'],
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                               color: Color(0xFF1c2143),
                              )
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Rating: ${value['rating']}',
                                  style: const TextStyle(
                                    color: Color(0xFF2a9d8f),
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Date: ${DateFormat('dd-MM-yyyy').format(DateTime.fromMillisecondsSinceEpoch(value['timestamp']))}',
                                  style: const TextStyle(
                                    color: Color(0xFF2a9d8f),
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {
                                    _showUpdateFeedback(context, key, value['comment'], value['rating']);
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    // Add your logic for deleting feedback here
                                    _deleteFeedback(key);
                                  },
                                ),
                              ],
                            ),
                          )
                        );
                      });
                    }
                    return Column(
                      children: feedbacks,
                    );
                  }
                }
            )

          ],
        )
      )
    );
  }


  void _submitFeedback(BuildContext context, User? user) {
    // if user is not logged in, show a dialog to ask user to login
    if (user == null) {
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Login Required'),
            content: const SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('You need to login to submit feedback.'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Login'),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()),
                  );
                },
              ),
            ],
          );
        },
      );
      return;
    }

    String comment = _commentController.text;
    if (comment.isEmpty || _rating == 0) {
      Fluttertoast.showToast(
        msg: "Please fill all fields.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      return;
    }
    DatabaseReference feedbackRef = FirebaseDatabase.instance.reference().child('feedback');
    Logger().d('Feedback reference: $feedbackRef');
    feedbackRef.push().set({
      'uid': user!.uid,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'comment': comment,
      'rating': _rating,
    }).then((value) {
      Fluttertoast.showToast(
        msg: "Feedback submitted successfully.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }).catchError((error) {

      Logger().e("Failed to submit feedback: $error");
      Fluttertoast.showToast(
        msg: "Failed to submit feedback.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
      );
    });
  }

  // Update alertDialog
  void _showUpdateFeedback(BuildContext context, String key, String currentComment, int currentRating) {
    TextEditingController commentController = TextEditingController(text: currentComment);
    int rating = currentRating;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Update Feedback"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: commentController,
                decoration: const InputDecoration(labelText: "Comment"),
              ),
              const SizedBox(height: 16.0),
              const Text('Rating:'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                    icon: Icon(rating >= 1 ? Icons.star : Icons.star_border),
                    onPressed: () {
                      setState(() {
                        rating = 1;
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(rating >= 2 ? Icons.star : Icons.star_border),
                    onPressed: () {
                      setState(() {
                        rating = 2;
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(rating >= 3 ? Icons.star : Icons.star_border),
                    onPressed: () {
                      setState(() {
                        rating = 3;
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(rating >= 4 ? Icons.star : Icons.star_border),
                    onPressed: () {
                      setState(() {
                        rating = 4;
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(rating >= 5 ? Icons.star : Icons.star_border),
                    onPressed: () {
                      setState(() {
                        rating = 5;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Update feedback in database
                DatabaseReference feedbackRef = FirebaseDatabase.instance.reference().child('feedback').child(key);
                feedbackRef.update({
                  'comment': commentController.text,
                  'rating': rating,
                }).then((_) {
                  Fluttertoast.showToast(
                    msg: "Feedback updated successfully.",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: const Color(0xFF2a9d8f)
                  );
                  Navigator.of(context).pop();
                }).catchError((error) {
                  print("Failed to update feedback: $error");
                  Fluttertoast.showToast(
                    msg: "Failed to update feedback.",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.red
                  );
                });
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }

  void _deleteFeedback(String key) {

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Delete Feedback"),
            content: const Text("Are you sure you want to delete this feedback?"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  // Delete feedback from database
                  DatabaseReference feedbackRef = FirebaseDatabase.instance.reference().child('feedback').child(key);
                  feedbackRef.remove().then((_) {
                    Fluttertoast.showToast(
                        msg: "Feedback deleted successfully.",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: const Color(0xFF2a9d8f)
                    );
                  }).catchError((error) {
                    print("Failed to delete feedback: $error");
                    Fluttertoast.showToast(
                        msg: "Failed to delete feedback.",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.red
                    );
                  });
                  Navigator.of(context).pop();
                },
                child: const Text('Delete'),
              ),
            ],
          );
        }
    );
  }


}