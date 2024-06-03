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

  List<LatLng> polylineCoordinates = [];
  late PolylinePoints polylinePoints;
  late GoogleMapController mapController;

  @override
  void initState() {
    super.initState();
    polylinePoints = PolylinePoints();
    _getPolyline();
  }

  _getPolyline() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyC2acu1DRffpyrie614kUIGFCQ-Gpo-u9Q',
      PointLatLng(_GarbageLocation1.latitude, _GarbageLocation1.longitude),
      PointLatLng(_GarbageLocation2.latitude, _GarbageLocation2.longitude),
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Map',
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Padding(
            padding: EdgeInsets.only(left: 70),
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
        body: GoogleMap(
          initialCameraPosition: CameraPosition(target: _pGooglePlex, zoom: 13),
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
    return {
      Marker(
        markerId: MarkerId("_garbageLocation1"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        position: _GarbageLocation1,
        infoWindow: const InfoWindow(title: "Garbage Location 1"),
        onTap: () {
          _showGarbageBinsInfo(
            context,
            'Garbage Location 1',
            'Paper',
            0.95,
            Colors.red,
            'Glass',
            0.50,
            Colors.blue,
            'Organic',
            0.25,
            Colors.green,
            'Plastic',
            0.10,
            Color.fromARGB(255, 255, 15, 7),
          );
        },
      ),
      Marker(
        markerId: MarkerId("_garbageLocation2"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        position: _GarbageLocation2,
        infoWindow: const InfoWindow(title: "Garbage Location 2"),
        onTap: () {
          _showGarbageBinsInfo(
            context,
            'Garbage Location 2',
            'Paper',
            0.85,
            Colors.red,
            'Glass',
            0.60,
            Colors.blue,
            'Organic',
            0.30,
            Colors.green,
            'Plastic',
            0.15,
            Color.fromARGB(255, 255, 230, 7),
          );
        },
      ),
      Marker(
        markerId: MarkerId("_garbageLocation3"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        position: _GarbageLocation3,
        infoWindow: const InfoWindow(title: "Garbage Location 3"),
        onTap: () {
          _showGarbageBinsInfo(
            context,
            'Garbage Location 3',
            'Paper',
            0.70,
            Colors.red,
            'Glass',
            0.40,
            Colors.blue,
            'Organic',
            0.20,
            Colors.green,
            'Plastic',
            0.05,
            Color.fromARGB(255, 255, 230, 7),
          );
        },
      ),
    };
  }

  void _showGarbageBinsInfo(
      BuildContext context,
      String locationName,
      String bin1Name,
      double bin1Level,
      Color bin1Color,
      String bin2Name,
      double bin2Level,
      Color bin2Color,
      String bin3Name,
      double bin3Level,
      Color bin3Color,
      String bin4Name,
      double bin4Level,
      Color bin4Color) {
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
              _buildGarbageBinInfo(bin1Name, bin1Level, bin1Color),
              _buildGarbageBinInfo(bin2Name, bin2Level, bin2Color),
              _buildGarbageBinInfo(bin3Name, bin3Level, bin3Color),
              _buildGarbageBinInfo(bin4Name, bin4Level, bin4Color),
            ],
          ),
        );
      },
    );
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
}
