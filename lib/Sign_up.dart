import 'package:eco_bin_original/OTP.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'UserName',
                        hintText: 'Enter Your UserName',
                        labelStyle: TextStyle(
                          fontSize: 20,
                          fontFamily: 'RobotoSlab-Bold',
                          fontWeight: FontWeight.w900,
                          color: Color.fromARGB(255, 3, 80, 5),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Colors.green,
                            width: 2,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Colors.green,
                            width: 2,
                          ),
                        ),
                        prefixIcon: Icon(Icons.person),
                        prefixIconColor: Colors.green,
                      ),
                      maxLength: 10,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        hintText: 'Enter Your Email',
                        labelStyle: TextStyle(
                          fontSize: 20,
                          fontFamily: 'RobotoSlab-Bold',
                          fontWeight: FontWeight.w900,
                          color: Color.fromARGB(255, 3, 80, 5),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Colors.green,
                            width: 2,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Colors.green,
                            width: 2,
                          ),
                        ),
                        prefixIcon: Icon(Icons.message_sharp),
                        prefixIconColor: Colors.green,
                      ),
                      maxLength: 20,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Contact No',
                        hintText: 'Enter Your Contact Number',
                        labelStyle: TextStyle(
                          fontSize: 20,
                          fontFamily: 'RobotoSlab-Bold',
                          fontWeight: FontWeight.w900,
                          color: Color.fromARGB(255, 3, 80, 5),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Colors.green,
                            width: 2,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Colors.green,
                            width: 2,
                          ),
                        ),
                        prefixIcon: Icon(Icons.phone),
                        prefixIconColor: Colors.green,
                      ),
                      maxLength: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 5, top: 20),
                      child: Container(
                        height: 54,
                        width: 370,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 14, 219, 21),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        const OTP(),
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  const begin = Offset(1.0, 0.0);
                                  const end = Offset.zero;
                                  const curve = Curves.ease;

                                  var tween = Tween(begin: begin, end: end)
                                      .chain(CurveTween(curve: curve));

                                  return SlideTransition(
                                    position: animation.drive(tween),
                                    child: child,
                                  );
                                },
                              ),
                            );
                          },
                          child: const Text(
                            "SIGN UP",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontFamily: 'RobotoSlab-Bold',
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Image.asset(
                'assets/bro.jpg',
                width: 400.0,
                height: 330.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
