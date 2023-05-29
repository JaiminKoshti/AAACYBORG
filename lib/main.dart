import 'package:aaacyborg/auth/google_signin.dart';
import 'package:aaacyborg/screens/splash/splash_screen.dart';
import 'package:aaacyborg/widgets/dark_mode_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.blue,
  ));

  runApp(ChangeNotifierProvider(
    create: (context) => DarkModeProvider(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: context.watch<DarkModeProvider>().isDarkMode
              ? ThemeData.dark()
              : ThemeData.light(),
          home: const SplashScreen(),
        ),
      );
}
