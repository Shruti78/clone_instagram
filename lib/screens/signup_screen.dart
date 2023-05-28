import 'dart:typed_data';

import 'package:clone_instagram/resources/auth_methods.dart';
import 'package:clone_instagram/screens/login_screen.dart';
import 'package:clone_instagram/utils/colors.dart';
import 'package:clone_instagram/utils/utils.dart';
import 'package:clone_instagram/widgets/text_field_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsivemobilescreen.dart';
import '../responsive/web_screen_layout.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _biocontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _usernamecontroller = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    _biocontroller.dispose();
    _usernamecontroller.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
        email: _emailcontroller.text,
        password: _passwordcontroller.text,
        username: _usernamecontroller.text,
        bio: _biocontroller.text,
        file: _image!);

    setState(() {
      _isLoading = true;
    });

    if (res != 'success') {
      showSnackBar(res, context);
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const ResponsiveLayout(
          webScreenLayout: WebScreenLayout(),
          mobileScreenLayout: MobileScreenLayout(),
        ),
      ));
    }
  }

  void navigateToLogin() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /* image
            photo widget
            username
          email
          password
          login button
          forgot passwword
          */
            Flexible(
              child: Container(),
              flex: 2,
            ),
            SvgPicture.asset(
              'assets/Instagram-Logo.wine.svg',
              height: 100,
            ),
            const SizedBox(
              height: 24,
            ),
            Stack(
              children: [
                _image != null
                    ? CircleAvatar(
                        radius: 70,
                        backgroundImage: MemoryImage(_image!),
                      )
                    : CircleAvatar(
                        radius: 70,
                        backgroundImage: NetworkImage(
                            'https://images.unsplash.com/photo-1679948205100-b4a9270b23ec?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80'),
                      ),
                Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      icon: Icon(Icons.add_a_photo),
                      onPressed: selectImage,
                    ))
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            TextFieldInput(
              hintText: 'USERNAME',
              textInputType: TextInputType.text,
              textEditingController: _usernamecontroller,
            ),
            const SizedBox(
              height: 24,
            ),
            TextFieldInput(
              hintText: 'Enter your bio.....',
              textInputType: TextInputType.text,
              textEditingController: _biocontroller,
            ),
            const SizedBox(
              height: 24,
            ),
            TextFieldInput(
              hintText: 'Email',
              textInputType: TextInputType.emailAddress,
              textEditingController: _emailcontroller,
            ),
            const SizedBox(
              height: 24,
            ),
            TextFieldInput(
              hintText: 'Password',
              textInputType: TextInputType.text,
              textEditingController: _passwordcontroller,
            ),
            const SizedBox(
              height: 24,
            ),
            InkWell(
              onTap: signUpUser,
              child: Container(
                width: double.infinity,
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      )
                    : const Text('Sign Up'),
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 12),
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    ),
                  ),
                  color: blueColor,
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Flexible(
              child: Container(),
              flex: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: const Text("Already have a account??"),
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                  ),
                ),
                GestureDetector(
                  onTap: navigateToLogin,
                  child: Container(
                    child: const Text(
                      " LOGIN",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
