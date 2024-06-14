import 'package:flutter/material.dart';
import 'package:eco_bin_original/Garbage_showing_Map.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(LocationAddPage());
}

class LocationAddPage extends StatefulWidget {
  const LocationAddPage({Key? key}) : super(key: key);

  @override
  _LocationAddPageState createState() => _LocationAddPageState();
}

class _LocationAddPageState extends State<LocationAddPage> {
  final TextEditingController _addressController = TextEditingController();

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
              const SizedBox(height: 5),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Waste Drop off",
                  style: TextStyle(
                    color: Color.fromARGB(255, 50, 199, 55),
                    fontSize: 28,
                    fontFamily: 'RobotoSlab-Bold',
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Here’s the part where you have to transport the waste to the dumpsite closest to you.",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: _addressController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Your Address',
                    hintText: 'Enter Your Address here',
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
                    prefixIcon: const Icon(Icons.location_city),
                    prefixIconColor: Colors.green,
                    labelStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color.fromARGB(255, 3, 80, 5),
                    ),
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
                      LatLng? location;
                      String? locationName;
                      double zoomLevel;

                      String enteredAddress =
                          _addressController.text.trim().toLowerCase();

                      if (enteredAddress == "seeduwa") {
                        location = LatLng(7.124156811064787, 79.87597862382015);
                        locationName = "Seeduwa";
                        zoomLevel = 15;
                      } else if (enteredAddress == "kotugoda") {
                        location = LatLng(7.122999315287511, 79.92372488591329);
                        locationName = "Kotugoda";
                        zoomLevel = 15;
                      } else if (enteredAddress == "mukalagamuwa") {
                        // Replace with actual coordinates for Mukalagamuwa
                        location = LatLng(7.131708950802051, 79.88039606539519);
                        locationName = "Mukalagamuwa";
                        zoomLevel = 17;
                      } else if (enteredAddress == "garbage location 1") {
                        location = LatLng(7.131708950802051, 79.88039606539519);
                        locationName = "Garbage Location 1";
                        zoomLevel = 17;
                      } else {
                        // Default to Kotugoda if no specific address matched
                        location = LatLng(7.122999315287511, 79.92372488591329);
                        locationName = "Kotugoda";
                        zoomLevel = 15;
                      }

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GarbageshowingMap(
                            newLocation: location,
                            newLocationName: locationName,
                            zoomLevel: zoomLevel,
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      "Proceed",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10, left: 10),
                child: Image.asset(
                  'assets/cuate.jpg',
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
