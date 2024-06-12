import 'package:eco_bin_original/NotificationPage.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

void main() {
  runApp(const GarbageshowingMap());
}

class GarbageshowingMap extends StatefulWidget {
  const GarbageshowingMap({Key? key}) : super(key: key);

  @override
  _GarbageshowingMapState createState() => _GarbageshowingMapState();
}

class _GarbageshowingMapState extends State<GarbageshowingMap> {
  static const LatLng _pGooglePlex =
      LatLng(7.1280940356164715, 79.88128287742241);
  static const LatLng _GarbageLocation1 =
      LatLng(7.131708950802051, 79.88039606539519);
  static const LatLng _GarbageLocation2 =
      LatLng(7.131945323570431, 79.87612478326228);
  static const LatLng _GarbageLocation3 =
      LatLng(7.1284534794369705, 79.87694017478212);
  static const LatLng _UrbanCouncilLocation =
      LatLng(7.131298444988958, 79.88100392751002);

  List<LatLng> polylineCoordinates = [];
  late PolylinePoints polylinePoints;
  GoogleMapController? mapController;

  final Map<String, Map<String, double>> garbageLevels = {
    'Garbage Location 1': {
      'Paper': 0.95,
      'Glass': 0.50,
      'Organic': 0.98,
      'Plastic': 0.10,
    },
    'Garbage Location 2': {
      'Paper': 0.85,
      'Glass': 0.60,
      'Organic': 0.95,
      'Plastic': 0.95,
    },
    'Garbage Location 3': {
      'Paper': 0.70,
      'Glass': 0.40,
      'Organic': 0.95,
      'Plastic': 0.95,
    },
  };

  int notificationCount = 0;

  @override
  void initState() {
    super.initState();

    _updateNotificationCount();
  }

  _updateNotificationCount() {
    List<String> messages = _checkGarbageLevels();
    setState(() {
      notificationCount = messages.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Map',
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
          actions: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: IconButton(
                    icon: const Icon(Icons.notifications),
                    iconSize: 40,
                    color: Colors.black,
                    onPressed: () {
                      List<String> messages = _checkGarbageLevels();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              NotificationPage(messages: messages),
                        ),
                      );
                    },
                  ),
                ),
                if (notificationCount > 0)
                  Positioned(
                    right: 11,
                    top: 5,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 17, 0),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      constraints: BoxConstraints(
                        minWidth: 20,
                        minHeight: 20,
                      ),
                      child: Text(
                        '$notificationCount',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontFamily: 'Roboto-Bold',
                          fontWeight: FontWeight.w900,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
        body: GoogleMap(
          initialCameraPosition: CameraPosition(target: _pGooglePlex, zoom: 13),
          markers: _createMarkers(context),
          onMapCreated: (GoogleMapController controller) {
            mapController = controller;
          },
        ),
      ),
    );
  }

  Set<Marker> _createMarkers(BuildContext context) {
    return {
      Marker(
        markerId: MarkerId("_UrbanCouncilLocation"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        position: _UrbanCouncilLocation,
        infoWindow: const InfoWindow(title: "Urban Council Location"),
        onTap: () {
          _showGarbageBinsInfo(context, 'Urban Council Location');
        },
      ),
      Marker(
        markerId: MarkerId("_garbageLocation1"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        position: _GarbageLocation1,
        infoWindow: const InfoWindow(title: "Garbage Location 1"),
        onTap: () {
          _showGarbageBinsInfo(context, 'Garbage Location 1');
        },
      ),
      Marker(
        markerId: MarkerId("_garbageLocation2"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        position: _GarbageLocation2,
        infoWindow: const InfoWindow(title: "Garbage Location 2"),
        onTap: () {
          _showGarbageBinsInfo(context, 'Garbage Location 2');
        },
      ),
      Marker(
        markerId: MarkerId("_garbageLocation3"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        position: _GarbageLocation3,
        infoWindow: const InfoWindow(title: "Garbage Location 3"),
        onTap: () {
          _showGarbageBinsInfo(context, 'Garbage Location 3');
        },
      ),
    };
  }

  void _showGarbageBinsInfo(BuildContext context, String locationName) {
    final bins = garbageLevels[locationName];
    if (bins != null) {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.all(16),
            color: Color.fromARGB(255, 207, 230, 207),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  locationName,
                  style: const TextStyle(
                    fontSize: 28,
                    fontFamily: 'Jaro',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                _buildGarbageBinInfo('Paper', bins['Paper'] ?? 0.0, Colors.red),
                _buildGarbageBinInfo(
                    'Glass', bins['Glass'] ?? 0.0, Colors.blue),
                _buildGarbageBinInfo(
                    'Organic', bins['Organic'] ?? 0.0, Colors.green),
                _buildGarbageBinInfo('Plastic', bins['Plastic'] ?? 0.0,
                    Color.fromARGB(255, 255, 15, 7)),
              ],
            ),
          );
        },
      );
    }
  }

  Widget _buildGarbageBinInfo(String binName, double level, Color color) {
    return ListTile(
      leading: Icon(
        Icons.delete,
        color: color,
        size: 35,
      ),
      title: Text(
        binName,
        style: const TextStyle(
          fontSize: 20,
          fontFamily: 'Roboto-Bold',
          fontWeight: FontWeight.w900,
        ),
      ),
      subtitle: Row(
        children: [
          Expanded(
            child: LinearProgressIndicator(
              value: level,
              backgroundColor: Color.fromARGB(255, 169, 172, 169),
              color: color,
            ),
          ),
          const SizedBox(width: 10),
          Container(
            width: 50,
            height: 30,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border:
                  Border.all(color: Color.fromARGB(255, 0, 255, 17), width: 2),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              '${(level * 100).toInt()}%',
              style: const TextStyle(
                fontSize: 20,
                fontFamily: 'Roboto-Bold',
                color: Colors.black,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<String> _checkGarbageLevels() {
    List<String> messages = [];

    garbageLevels.forEach((location, bins) {
      bins.forEach((bin, level) {
        if (level >= 0.9) {
          messages.add("Don't put any $bin garbage in the bin at $location");
        } else if (level < 0.5) {
          messages.add("You can add $bin garbage at $location");
        }
      });
    });

    if (messages.isEmpty) {
      messages.add("All bins are available for use");
    }

    return messages;
  }
}
