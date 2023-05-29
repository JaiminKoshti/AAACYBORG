import 'package:aaacyborg/auth/google_signin.dart';
import 'package:aaacyborg/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late GoogleSignIn _googleSignIn;
  late GoogleSignInAccount _currentUser;

  @override
  void initState() {
    super.initState();
    _googleSignIn = GoogleSignIn(scopes: ['email']);
    _googleSignIn.onCurrentUserChanged.listen((account) {
      /*setState(() {
        _currentUser = account!;
      });*/
    });
    _googleSignIn.signInSilently();
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      if (kDebugMode) {
        print('Sign-in account : $error');
      }
    }
  }

  Future<void> _handleSignOut() async {
    try {
      await _googleSignIn.signOut();
      setState(() {
        _currentUser = null as GoogleSignInAccount;
      });
    } catch (error) {
      if (kDebugMode) {
        print('Sign-out error: $error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData) {
                return const HomeScreen();
              } else if (snapshot.hasError) {
                return const Center(child: Text("Error"));
              } else {
                return Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: SizedBox(
                      width: 190,
                      height: 60,
                      child: InkWell(
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 4,
                          shadowColor: Colors.black,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Image(
                                    image: AssetImage("assets/download.png"),
                                    width: 23),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 6.0),
                                child: Text(
                                  "Sign in with Google",
                                  style: TextStyle(fontSize: 15),
                                ),
                              )
                            ],
                          ),
                        ),
                        onTap: () {
                          final provider = Provider.of<GoogleSignInProvider>(
                              context,
                              listen: false);
                          provider.googleLogin();
                        },
                      ),
                    ));
              }
            }),
      ),
    );
  }
}
