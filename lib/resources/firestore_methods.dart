import 'package:clone_instagram/resources/storage_methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import '../models/post.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //upload task

  Future<String> uploadPost(
    String description,
    Uint8List file,
    String uid,
    String username,
    String profImage,
  ) async {
    String res = "some error occurred";
    try {
      String photoUrl =
          await StorageMethods().uploadImagetostorage('posts', file, true);

      String postId = const Uuid().v1();
      Post post = Post(
         likes: [],
        datePublished: DateTime.now(),
        postID: postId,
        description: description,
        profImage: profImage,
        postUrl: photoUrl,
        uid: uid,
        username: username,
      );

      _firestore.collection('posts').doc('postId').set(
            post.toJson(),
          );
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
