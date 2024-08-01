import 'package:eco_bin_original/SignUp/snackbar.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailController = TextEditingController();
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: Align(
        alignment: Alignment.centerRight,
        child: InkWell(
          onTap: () {
            myDialogBox(context);
          },
          child: const Text(
            "Forgot Password?",
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'RobotoSlab-Bold',
              fontWeight: FontWeight.w900,
              color: Color.fromARGB(255, 6, 111, 10),
            ),
          ),
        ),
      ),
    );
  }

  void myDialogBox(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(),
                      const Text(
                        "Forgot Your Password",
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 20,
                          fontFamily: 'RobotoSlab-Bold',
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Enter Your Email",
                      labelStyle: TextStyle(
                        color: Color.fromARGB(
                            255, 50, 199, 55), // Set the label text color
                        fontSize: 20, // Set the label text size

                        fontFamily: 'RobotoSlab-Bold',
                        fontWeight:
                            FontWeight.w900, // Set the label text weight
                      ),
                      hintText: "Ex: abc@gmail.com",
                      hintStyle: TextStyle(
                        fontSize: 20, // Set the label text size

                        fontFamily: 'RobotoSlab-Bold',
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    onPressed: () async {
                      await auth
                          .sendPasswordResetEmail(email: emailController.text)
                          .then((value) {
                        // if success then show this message
                        showSnackBar(context,
                            "We have send you the reset password link to your email id, Please check it");
                      }).onError((error, stackTrace) {
                        // if unsuccess then show error message
                        showSnackBar(context, error.toString());
                      });
                      // terminate the dialog after send the forgot password link
                      Navigator.pop(context);
                      // clear the text field
                      emailController.clear();
                    },

                    // if we remember the password then we can easily login
                    // if we forget the password then we apply this method
                    child: const Text(
                      "Send",
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'RobotoSlab-Bold',
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
