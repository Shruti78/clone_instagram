import 'package:clone_instagram/providers/user_providers.dart';
import 'package:clone_instagram/responsive/mobile_screen_layout.dart';
import 'package:clone_instagram/responsive/responsivemobilescreen.dart';
import 'package:clone_instagram/responsive/web_screen_layout.dart';
import 'package:clone_instagram/screens/login_screen.dart';
import 'package:clone_instagram/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_)=> UserProvider(),),],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'INSTA',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: mobileBackgroundColor,
        ),
        home: StreamBuilder(
            stream: FirebaseAuth.instance
                .authStateChanges(), // whenever user signed in/out
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  return ResponsiveLayout(
                    webScreenLayout: WebScreenLayout(),
                    mobileScreenLayout: MobileScreenLayout(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('${snapshot.error}'),
                  );
                }
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(color: primaryColor),
                );
              }
              return  LoginScreen();
            }),
      ),
    );
  }
}
