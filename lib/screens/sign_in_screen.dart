import 'package:blocauth/cubits/auth_cubit/auth_cubit.dart';
import 'package:blocauth/cubits/auth_cubit/auth_state.dart';
import 'package:blocauth/screens/verify_phone_number.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInScreen extends StatelessWidget {

  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Sign In with Phone"),
      ),
      body: SafeArea(
        child: ListView(
          children: [

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  TextField(
                    controller: phoneController,
                    maxLength: 11,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Phone Number",
                      counterText: ""
                    ),
                  ),

                  SizedBox(height: 10,),

                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      
                      if(state is AuthCodeSentState) {
                        Navigator.push(context, CupertinoPageRoute(
                          builder: (context) => VerifyPhoneNumberScreen()
                        ));
                      }

                    },
                    builder: (context, state) {

                      if(state is AuthLoadingState) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: CupertinoButton(
                          onPressed: () {
                            String phoneNumber = "+88" + phoneController.text;
                            BlocProvider.of<AuthCubit>(context).sendOTP(phoneNumber);
                          },
                          color: Colors.blue,
                          child: Text("Sign In"),
                        ),
                      );

                    },
                  ),

                  InkWell(
                    onTap: (){
                      signInWithGoogle();
                    },
                    child: Container(
                      height: 30,
                      width: 100,
                      child: Text("Google Login"),
                    ),
                  )

                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    print(googleAuth?.idToken);
    print(googleUser?.displayName);

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}