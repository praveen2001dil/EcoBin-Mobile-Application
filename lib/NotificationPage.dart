import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  final List<String> messages;

  const NotificationPage({Key? key, required this.messages}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Notification",
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 183, 228, 197),
          title: const Padding(
            padding: EdgeInsets.only(left: 60, bottom: 15),
            child: Text(
              "ECOBIN",
              style: TextStyle(
                fontSize: 55,
                fontFamily: 'Jaro',
                fontWeight: FontWeight.w700,
                color: Color.fromARGB(255, 9, 94, 2),
              ),
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView.builder(
            itemCount: messages.length,
            itemBuilder: (context, index) {
              bool isHighLevel =
                  messages[index].startsWith("Don't put any garbage in the");

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  color: isHighLevel ? Colors.red : Colors.transparent,
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    messages[index],
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'Roboto-Bold',
                      color: isHighLevel ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w900,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
