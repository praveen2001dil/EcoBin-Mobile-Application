import 'package:eco_bin_original/NotificationAdmin.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

void main() {
  runApp(const GarbageshowingMapAdmin());
}

class GarbageshowingMapAdmin extends StatefulWidget {
  final LatLng? newLocation;
  final String? newLocationName;
  final double zoomLevel;

  const GarbageshowingMapAdmin(
      {Key? key, this.newLocation, this.newLocationName, this.zoomLevel = 13})
      : super(key: key);

  @override
  _GarbageshowingMapAdminState createState() => _GarbageshowingMapAdminState();
}

class _GarbageshowingMapAdminState extends State<GarbageshowingMapAdmin> {
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
  static const LatLng _Seeduwa = LatLng(7.124156811064787, 79.87597862382015);
  static const LatLng _Kotugoda = LatLng(7.122999315287511, 79.92372488591329);
  static const LatLng _Mukalangamuwa =
      LatLng(7.137730155840432, 79.88328531035395);

  List<LatLng> polylineCoordinates = [];
  late PolylinePoints polylinePoints;
  GoogleMapController? mapController;

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
      'Paper': 0.60,
      'Glass': 0.90,
      'Organic': 0.95,
      'Plastic': 0.95,
    },
  };

  int notificationCount = 0;
  @override
  void initState() {
    super.initState();
    polylinePoints = PolylinePoints();
    _updatePolyline();
    _updateNotificationCount();
  }

  Future<void> _updatePolyline() async {
    polylineCoordinates.clear();

    // Iterate through each garbage location
    for (var entry in garbageLevels.entries) {
      final locationName = entry.key;
      final levels = entry.value;

      // Check if all bin levels are over 90%
      if (levels['Paper']! >= 0.9 &&
          levels['Glass']! >= 0.9 &&
          levels['Organic']! >= 0.9 &&
          levels['Plastic']! >= 0.9) {
        // Determine the coordinates of the garbage location
        LatLng garbageLocation;
        switch (locationName) {
          case 'Garbage Location 1':
            garbageLocation = _GarbageLocation1;
            break;
          case 'Garbage Location 2':
            garbageLocation = _GarbageLocation2;
            break;
          case 'Garbage Location 3':
            garbageLocation = _GarbageLocation3;
            break;
          default:
            continue;
        }

        // Fetch the polyline coordinates
        PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
          'AIzaSyBDlOfF8apqSfWypgNFfNEW_QXAqH5zkuM',
          PointLatLng(
              _UrbanCouncilLocation.latitude, _UrbanCouncilLocation.longitude),
          PointLatLng(garbageLocation.latitude, garbageLocation.longitude),
        );

        // Add polyline coordinates if route is found
        if (result.points.isNotEmpty) {
          result.points.forEach((PointLatLng point) {
            polylineCoordinates.add(LatLng(point.latitude, point.longitude));
          });
        }
      }
    }

    setState(() {});
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
                              NotificationAdmin(messages: messages),
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
          polylines: {
            Polyline(
              polylineId: PolylineId('polyline'),
              visible: true,
              points: polylineCoordinates,
              color: Colors.black,
              width: 5,
            ),
          },
          onMapCreated: (GoogleMapController controller) {
            mapController = controller;
          },
        ),
      ),
    );
  }

  Set<Marker> _createMarkers(BuildContext context) {
    Set<Marker> markers = {
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
    final bins = garbageLevels[locationName];
    if (bins != null) {
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
                _buildGarbageBinInfo('Paper', bins['Paper'] ?? 0.0, Colors.red),
                _buildGarbageBinInfo(
                    'Glass', bins['Glass'] ?? 0.0, Colors.blue),
                _buildGarbageBinInfo(
                    'Organic', bins['Organic'] ?? 0.0, Colors.green),
                _buildGarbageBinInfo('Plastic', bins['Plastic'] ?? 0.0,
                    const Color.fromARGB(255, 255, 15, 7)),
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

    garbageLevels.forEach((location, bins) {
      bins.forEach((bin, level) {
        if (level >= 0.9) {
          messages.add("Please collect $bin garbage in the bin at $location");
        }
      });
    });

    if (messages.isEmpty) {
      messages.add("All bins are available for use");
    }

    return messages;
  }
}
