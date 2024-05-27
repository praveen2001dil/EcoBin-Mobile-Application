import 'package:eco_bin_original/OTP_time_gone.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Importing Services Library for FilteringTextInputFormatter

void main() {
  runApp(OTP());
}

class OTP extends StatefulWidget {
  const OTP({Key? key}) : super(key: key);

  @override
  _OTPState createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "OTP Verification",
                  style: TextStyle(
                    color: Color.fromARGB(255, 50, 199, 55),
                    fontSize: 28,
                    fontFamily: 'RobotoSlab-Bold',
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "A 6 digit code has been sent to \nokematilanray@gmail.com",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontFamily: 'RobotoSlab-Bold',
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  keyboardType:
                      TextInputType.number, // Setting keyboardType to number
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly // Accept only digits
                  ],
                  decoration: InputDecoration(
                    labelText: 'OTP',
                    hintText: 'Enter Your OTP here',
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
                    prefixIcon: const Icon(Icons.lock),
                    prefixIconColor: Colors.green,
                    labelStyle: const TextStyle(
                      fontSize: 20,
                      fontFamily: 'RobotoSlab-Bold',
                      fontWeight: FontWeight.w900,
                      color: Color.fromARGB(255, 3, 80, 5),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Haven’t gotten code yet?  30:00 sec",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontFamily: 'RobotoSlab-Bold',
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 30),
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
                                  const OTPTimeGone(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
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
                      "Proceed",
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
              Padding(
                padding: const EdgeInsets.only(bottom: 10, left: 10),
                child: Image.asset(
                  'assets/bro.jpg',
                  width: 400.0,
                  height: 330.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
