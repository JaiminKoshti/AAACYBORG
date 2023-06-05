import 'package:aaacyborg/screens/auth/login/provider.dart';
import 'package:aaacyborg/screens/splash/splash_screen.dart';
import 'package:aaacyborg/widgets/dark_mode_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  //await EasyLocalization.ensureInitialized();


  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.blue,
  ));

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<DarkModeProvider>(
          create: (context) => DarkModeProvider(),
        ),
        ChangeNotifierProvider<UserProvider>(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider<GoogleAccountProvider>(
          create: (context) => GoogleAccountProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(

      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: context.watch<DarkModeProvider>().isDarkMode
          ? ThemeData.dark()
          : ThemeData.light(),
      home: const SplashScreen(),
    );
  } 
}
