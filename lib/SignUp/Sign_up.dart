import 'package:eco_bin_original/Authentication/AuthMethod.dart';
import 'package:eco_bin_original/Location_add_page.dart';
import 'package:eco_bin_original/Login/Login.dart';
import 'package:eco_bin_original/MyButtons.dart';
import 'package:eco_bin_original/SignUp/TextFieldInput.dart';

import 'package:eco_bin_original/SignUp/snackbar.dart';

import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
  }

  void signupUser() async {
    // set is loading to true.
    setState(() {
      isLoading = true;
    });
    // signup user using our authmethod
    String res = await AuthMethod().signupUser(
        email: emailController.text,
        password: passwordController.text,
        name: nameController.text);
    // if string return is success, user has been creaded and navigate to next screen other witse show error.
    if (res == "success") {
      setState(() {
        isLoading = false;
      });
      //navigate to the next screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const LocationAddPage(),
        ),
      );
    } else {
      setState(() {
        isLoading = false;
      });
      // show error
      showSnackBar(context, res);
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "Welcome to ",
                  style: TextStyle(
                    color: Color.fromARGB(255, 77, 89, 99),
                    fontSize: 28,
                    fontFamily: 'RobotoSlab-Bold',
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "ECOBIN",
                  style: TextStyle(
                    color: Color.fromARGB(255, 50, 199, 55),
                    fontSize: 55,
                    fontFamily: 'Jaro',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextFieldInput(
                  icon: Icons.person,
                  textEditingController: nameController,
                  hintText: 'Enter Your Name',
                  textInputType: TextInputType.text),
              TextFieldInput(
                  icon: Icons.email,
                  textEditingController: emailController,
                  hintText: 'Enter Your Email',
                  textInputType: TextInputType.text),
              TextFieldInput(
                icon: Icons.lock,
                textEditingController: passwordController,
                hintText: 'Enter Your Password',
                textInputType: TextInputType.text,
                isPass: true,
              ),
              MyButtons(onTap: signupUser, text: "Sign Up"),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account? ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'RobotoSlab-Bold',
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      " Login",
                      style: TextStyle(
                        color: Color.fromARGB(255, 50, 199, 55),
                        fontSize: 20,
                        fontFamily: 'RobotoSlab-Bold',
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  )
                ],
              ),
              // Add some space between text and image
              Image.asset(
                'assets/bro.jpg',
                width: 400.0,
                height: 330.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
