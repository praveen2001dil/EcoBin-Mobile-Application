import 'package:eco_bin_original/Features/NotificationPage.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(const GarbageshowingMap());
}

class GarbageshowingMap extends StatefulWidget {
  final LatLng? newLocation;
  final String? newLocationName;
  final double zoomLevel;

  const GarbageshowingMap(
      {Key? key, this.newLocation, this.newLocationName, this.zoomLevel = 13})
      : super(key: key);

  @override
  _GarbageshowingMapState createState() => _GarbageshowingMapState();
}

class _GarbageshowingMapState extends State<GarbageshowingMap> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // late Stream<QuerySnapshot> _stream;

  static const LatLng _pGooglePlex =
      LatLng(7.1280940356164715, 79.88128287742241);
  // static const LatLng _GarbageLocation1 =
  //     LatLng(7.131708950802051, 79.88039606539519);
  // static const LatLng _GarbageLocation2 =
  //     LatLng(7.131945323570431, 79.87612478326228);
  // static const LatLng _GarbageLocation3 =
  //     LatLng(7.1284534794369705, 79.87694017478212);
  // static const LatLng _UrbanCouncilLocation =
  //     LatLng(7.131298444988958, 79.88100392751002);
  // static const LatLng _Seeduwa = LatLng(7.124156811064787, 79.87597862382015);
  // static const LatLng _Kotugoda = LatLng(7.122999315287511, 79.92372488591329);
  // static const LatLng _Mukalangamuwa =
  //     LatLng(7.137730155840432, 79.88328531035395);

  List<LatLng> polylineCoordinates = [];
  late PolylinePoints polylinePoints;
  GoogleMapController? mapController;

<<<<<<< HEAD
  List<_GarbageLocation> garbageLocations = [];

  final Map<String, Map<String, double>> garbageLevels = {};
=======
  final Map<String, Map<String, double>> garbageLevels = {
    'Garbage Location 1': {
      'Paper': 0.95,
      'Glass': 0.92,
      'Organic': 0.98,
      'Plastic': 0.95,
    },
    'Garbage Location 2': {
      'Paper': 0.68,
      'Glass': 0.98,
      'Organic': 0.65,
      'Plastic': 0.95,
    },
    'Garbage Location 3': {
      'Paper': 0.93,
      'Glass': 0.90,
      'Organic': 0.95,
      'Plastic': 0.95,
    },
  };
>>>>>>> 0893b7fd3b445b30058778dcd8d745fda771d71b

  int notificationCount = 0;

  String? locationName = null;

  @override
  void initState() {
    super.initState();
    _updateNotificationCount();
    _fetchRealTimeData();
  }

  void _updateNotificationCount() {
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
                    right: 8,
                    top: 8,
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 20,
                        minHeight: 20,
                      ),
                      child: Text(
                        '$notificationCount',
                        style: const TextStyle(
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
          initialCameraPosition: CameraPosition(
            target: widget.newLocation ?? _pGooglePlex,
            zoom: widget.zoomLevel,
          ),
          markers: _createMarkers(context),
          onMapCreated: (GoogleMapController controller) {
            mapController = controller;
          },
        ),
      ),
    );
  }

  Set<Marker> _createMarkers(BuildContext context) {
    Set<Marker> markers = {};

    garbageLocations.forEach((garbageLocation) {
      var location = garbageLocation.location;
      markers.add(Marker(
        markerId: MarkerId(garbageLocation.location_id),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        position: LatLng(garbageLocation.lat, garbageLocation.lan),
        infoWindow: InfoWindow(title: location),
        onTap: () {
          _showGarbageBinsInfo(context, location);
        },
      ));
    });

    if (widget.newLocation != null && widget.newLocationName != null) {
      markers.add(
        Marker(
          markerId: MarkerId(widget.newLocationName!),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          position: widget.newLocation!,
          infoWindow: InfoWindow(title: widget.newLocationName),
          onTap: () {
            _showGarbageBinsInfo(context, widget.newLocationName!);
          },
        ),
      );
    }

    return markers;
  }

  void _showGarbageBinsInfo(BuildContext context, String locationName) {
    // final bins = garbageLevels[locationName];
    this.locationName = locationName;

    List<_GarbageLocation> filteredLocations = garbageLocations
        .where((garbageLocation) => garbageLocation.location == locationName)
        .toList();

    if (filteredLocations.isNotEmpty) {
      _GarbageLocation garbageLocation = filteredLocations.first;

      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.all(16),
            color: const Color.fromARGB(255, 207, 230, 207),
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
                _buildGarbageBinInfo(
                    'Paper', garbageLocation.paper ?? 0.0, Colors.red),
                _buildGarbageBinInfo(
                    'Glass', garbageLocation.glass ?? 0.0, Colors.blue),
                _buildGarbageBinInfo(
                    'Organic', garbageLocation.organic ?? 0.0, Colors.green),
                _buildGarbageBinInfo('Plastic', garbageLocation.plastic ?? 0.0,
                    Color.fromARGB(255, 206, 212, 33)),
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
              backgroundColor: const Color.fromARGB(255, 169, 172, 169),
              color: color,
            ),
          ),
          const SizedBox(width: 10),
          Container(
            width: 50,
            height: 30,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(
                  color: const Color.fromARGB(255, 0, 255, 17), width: 2),
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

    for (var location in garbageLocations) {
      if (location.glass >= 0.9) {
        messages.add(
            "Don't put any glass garbage in the bin at ${location.location}");
      } else if (location.glass < 0.5) {
        messages.add("You can add glass garbage at ${location.location}");
      }

      if (location.organic >= 0.9) {
        messages.add(
            "Don't put any organic garbage in the bin at ${location.location}");
      } else if (location.organic < 0.5) {
        messages.add("You can add organic garbage at ${location.location}");
      }

      if (location.paper >= 0.9) {
        messages.add(
            "Don't put any paper garbage in the bin at ${location.location}");
      } else if (location.paper < 0.5) {
        messages.add("You can add paper garbage at ${location.location}");
      }

      if (location.plastic >= 0.9) {
        messages.add(
            "Don't put any plastic garbage in the bin at ${location.location}");
      } else if (location.plastic < 0.5) {
        messages.add("You can add plastic garbage at ${location.location}");
      }
    }

    if (messages.isEmpty) {
      messages.add("All bins are in optimal condition.");
    }

    return messages;
  }

  // Separate method for fetching real-time data
  void _fetchRealTimeData() {
    _firestore.collection('garbage_locations').snapshots().listen((snapshot) {
      List<_GarbageLocation> updatedList = [];

      snapshot.docs.forEach((doc) {
        var garbageLocation =
            _GarbageLocation.fromJson(doc.data() as Map<String, dynamic>);
        updatedList.add(garbageLocation);
      });

      if (mounted) {
        setState(() {
          garbageLocations = updatedList;
          _updateNotificationCount(); // Update notifications after fetching new data
        });

        if (locationName != null) {
          Navigator.pop(context);
          _showGarbageBinsInfo(context, locationName!);
        }
      }
    });
  }
}

class _GarbageLocation {
  late String location_id;
  late String location;
  late double glass;
  late double organic;
  late double paper;
  late double plastic;
  late double lat;
  late double lan;

  _GarbageLocation({
    required this.location_id,
    required this.location,
    required this.glass,
    required this.organic,
    required this.paper,
    required this.plastic,
    required this.lat,
    required this.lan,
  });

  // Factory constructor to create an instance from a JSON map
  factory _GarbageLocation.fromJson(Map<String, dynamic> json) {
    return _GarbageLocation(
      location_id:
          json['location_id'] ?? 'unknown', // Provide a default or empty string
      location: json['location'] ??
          'Unknown Location', // Provide a default or empty string
      glass: (json['glass'] ?? 0.0)
          .toDouble(), // Use default value and ensure it is double
      organic: (json['organic'] ?? 0.0)
          .toDouble(), // Use default value and ensure it is double
      paper: (json['paper'] ?? 0.0)
          .toDouble(), // Use default value and ensure it is double
      plastic: (json['plastic'] ?? 0.0)
          .toDouble(), // Use default value and ensure it is double
      lat: (json['lat'] ?? 0.0)
          .toDouble(), // Use default value and ensure it is double
      lan: (json['lan'] ?? 0.0)
          .toDouble(), // Use default value and ensure it is double
    );
  }

  // Method to convert an instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'location_id': location_id,
      'location': location,
      'glass': glass,
      'organic': organic,
      'paper': paper,
      'plastic': plastic,
      'lat': lat,
      'lan': lan,
    };
  }
}
