import 'package:clone_instagram/resources/auth_methods.dart';
import 'package:clone_instagram/responsive/mobile_screen_layout.dart';
import 'package:clone_instagram/responsive/responsivemobilescreen.dart';
import 'package:clone_instagram/responsive/web_screen_layout.dart';
import 'package:clone_instagram/screens/signup_screen.dart';
import 'package:clone_instagram/utils/colors.dart';
import 'package:clone_instagram/utils/utils.dart';
import 'package:clone_instagram/widgets/text_field_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailcontroller = TextEditingController();

  final TextEditingController _passwordcontroller = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
        email: _emailcontroller.text, password: _passwordcontroller.text);

    if (res == "success") {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) =>const ResponsiveLayout(
                  webScreenLayout: WebScreenLayout(),
                  mobileScreenLayout: MobileScreenLayout(),
                ),
      ));
    } else {
      showSnackBar(res, context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void navigateToSignup() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) =>   SignUpScreen()));
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
              onTap: loginUser,
              child: Container(
                width: double.infinity,
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      )
                    : const Text('LOGIN'),
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
                  child: const Text("dont have any account??"),
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                  ),
                ),
                GestureDetector(
                  onTap: navigateToSignup,
                  child: Container(
                    child: const Text(
                      "Sign up",
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
