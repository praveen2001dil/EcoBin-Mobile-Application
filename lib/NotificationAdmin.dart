import 'package:flutter/material.dart';

class NotificationAdmin extends StatelessWidget {
  final List<String> messages;

  const NotificationAdmin({Key? key, required this.messages}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Notification",
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 183, 228, 197),
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
          child: ListView(
            children: _buildLocationContainers(),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildLocationContainers() {
    // Group messages by location
    final Map<String, List<String>> groupedMessages = {
      'Garbage Location 1': [],
      'Garbage Location 2': [],
      'Garbage Location 3': [],
    };

    for (final message in messages) {
      if (message.contains('Garbage Location 1')) {
        groupedMessages['Garbage Location 1']!.add(message);
      } else if (message.contains('Garbage Location 2')) {
        groupedMessages['Garbage Location 2']!.add(message);
      } else if (message.contains('Garbage Location 3')) {
        groupedMessages['Garbage Location 3']!.add(message);
      }
    }

    // Create containers for each location
    final List<Widget> locationContainers = [];

    groupedMessages.forEach((location, messages) {
      if (messages.isNotEmpty) {
        locationContainers.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 4),
                    blurRadius: 10,
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    location,
                    style: TextStyle(
                      fontSize: 28,
                      fontFamily: 'Roboto-Bold',
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ...messages.map((message) {
                    if (message.contains("Don't put") &&
                        _extractBinLevel(message) > 0.9) {}

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '\u2022 ', // Unicode for bullet
                            style: TextStyle(
                              fontSize: 24,
                              fontFamily: 'Roboto-Bold',
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              message,
                              style: TextStyle(
                                fontSize: 23,
                                fontFamily: 'Roboto-Bold',
                                color: const Color.fromARGB(255, 248, 17, 0),
                                fontWeight: FontWeight.w900,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
        );
      }
    });

    return locationContainers;
  }

  int _extractBinLevel(String message) {
    // Assuming the bin level is included in the message as a percentage
    final RegExp regex = RegExp(r'\b(\d+)%\b');
    final match = regex.firstMatch(message);
    if (match != null) {
      return int.parse(match.group(1)!);
    }
    return 0; // Default value if no percentage is found
  }
}
