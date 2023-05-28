import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String description;
  final String uid;
  final String postID;
  final String username;
  final DateTime datePublished;
  final String postUrl;
  final String profImage;
  final likes;

  const Post({
    required this.description,
    required this.postID,
    required this.datePublished,
    required this.postUrl,
    required this.profImage,
    required this.likes,
    required this.uid,
    required this.username,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "description": description,
        "postID": postID,
        "profImage": profImage,
        "postUrl": postUrl,
        "datePublished": datePublished,
        "likes": likes,
      };

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Post(
      uid: snapshot['uid'],
      username: snapshot['username'],
      datePublished: snapshot['datePublished'],
      postID: snapshot['postID'],
      postUrl: snapshot['postUrl'],
      description: snapshot['description'],
      profImage: snapshot['profImage'],
      likes: snapshot["likes"],
    );
  }
}
