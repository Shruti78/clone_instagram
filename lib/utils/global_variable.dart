import 'package:clone_instagram/screens/add_post_screens.dart';
import 'package:clone_instagram/screens/profile_screen.dart';
import 'package:clone_instagram/screens/search_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../screens/feed_screen.dart';

const webScreenSize = 600;

List<Widget> homeScreenItems = [
  const FeedScreen(),
  const SearchScreen(),
  const AddPostScreen(),
  const Text('notifications'),
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
];
