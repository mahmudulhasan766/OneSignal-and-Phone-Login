import 'package:blocauth/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  var otpController = TextEditingController();
  var numController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  String verificationId = "";

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    try {
      final authCredential = await auth.signInWithCredential(phoneAuthCredential);

      if (authCredential.user != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const HomeScreen()));
      }
    } on FirebaseAuthException catch (e) {
      print("catch");
    }
  }

  Future<void> verify() async {
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: otpController.text);
    signInWithPhoneAuthCredential(phoneAuthCredential);
  }

  Future<void> fetchotp() async {
    await auth.verifyPhoneNumber(
      phoneNumber: '+8801611387555',
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);
      },

      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
        }
      },
      codeSent: (String verificationId, int? resendToken) async {
        this.verificationId = verificationId;

      },
      codeAutoRetrievalTimeout: (String verificationId) {
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Phone Number',
                    hintText: 'Enter valid number'
                ),
                controller: numController,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                obscureText: true,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Otp Control',
                    hintText: 'Enter valid password'
                ),
                controller: otpController,
              ),
            ),

            TextButton(onPressed: () {
              fetchotp();
            }, child: const Text("Fetch OTP"),),
            TextButton(onPressed: () {
              verify();
            }, child: const Text("Send"))
          ],
        ),
      ),
    );
  }



}
