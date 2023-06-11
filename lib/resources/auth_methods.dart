import 'dart:typed_data';

import 'package:clone_instagram/resources/storage_methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:clone_instagram/models/user.dart' as model;
import 'package:flutter/services.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance; // registration
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentUser.uid).get();

    return model.User.fromSnap(snap);
  }

  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Some error occured";
    try {
      // register user
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty ||
          file != null) {
        // steps for registering user in authentication with email and password
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        print(cred.user!.uid);

        String photoUrl = await StorageMethods()
            .uploadImagetostorage('profilepics', file, false);

        // steps to  add user to our database

        model.User _user = model.User(
          email: email,
          uid: cred.user!.uid,
          photoUrl: photoUrl,
          username: username,
          bio: bio,
          following: [],
          followers: [],
        );

        await _firestore
            .collection("users")
            .doc(cred.user!.uid)
            .set(_user.toJson());

        res = "success";
      }
    }
    // on FirebaseAuthException catch (err) {
    //   if (err.code == 'invalid-email') {
    //     res = 'The email is badly formatted';
    //   } else if (err.code == 'weak-password') {
    //     res = 'Password should be atleast 6 characters.';
    //   }
    // }
    catch (err) {
      res = err.toString();
    }
    return res;
  }

  // logging in user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error occured";

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
   Future<void> signOut() async {
    await _auth.signOut();
  }
}
