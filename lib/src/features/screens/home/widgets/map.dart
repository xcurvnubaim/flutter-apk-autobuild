import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:welangflood/src/constants/color.dart';

class ViewMap extends StatefulWidget {
  const ViewMap({Key? key}) : super(key: key);

  @override
  _ViewMapState createState() => _ViewMapState();
}

class _ViewMapState extends State<ViewMap> {
  late GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  BitmapDescriptor _getMarkerIcon(double height) {
    if (height < 10) {
      return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
    } else if (height >= 10 && height < 20) {
      return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow);
    } else if (height >= 20 && height < 30) {
      return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange);
    } else if (height >= 30 && height < 50) {
      return BitmapDescriptor.defaultMarkerWithHue(25);
    } else {
      return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
    }
  }

  List<Map<String, dynamic>> _generateDummyData(int count) {
    final Random random = Random();
    List<Map<String, dynamic>> data = [];
    List<String> petugasNames = ['John', 'Alice', 'Bob', 'Emma', 'Daniel', 'Sophia', 'Michael', 'Olivia'];
    for (int i = 0; i < count; i++) {
      double height = random.nextDouble() * 100;
      String petugas = petugasNames[random.nextInt(petugasNames.length)];
      LatLng position = LatLng(
        -7.741785 + (random.nextDouble() - 0.5) / 10,
        112.797416 + (random.nextDouble() - 0.5) / 10,
      );
      data.add({'height': height, 'petugas': petugas, 'position': position});
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    CameraPosition initialPosition = const CameraPosition(
      target: LatLng(-7.741785, 112.797416), // Welang Lama, Pasuruan, Indonesia
      zoom: 14.0,
    );

    List<Map<String, dynamic>> dummyData = _generateDummyData(5);

    Set<Marker> markers = dummyData.map((data) {
      double height = data['height'];
      LatLng position = data['position'];
      String petugas = data['petugas'];
      return Marker(
        markerId: MarkerId(position.toString()),
        position: position,
        icon: _getMarkerIcon(height),
        infoWindow: InfoWindow(
          title: 'Tinggi: ${height.toStringAsFixed(2)} cm',
          snippet: 'Petugas: $petugas',
        ),
      );
    }).toSet();

    return Container(
      constraints: BoxConstraints(
        maxWidth: screenWidth > 375.0 ? 375.0 : screenWidth,
        maxHeight: screenHeight > 450.0 ? 450.0 : screenHeight,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: tPrimaryColor),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: initialPosition,
              mapType: MapType.normal,
              myLocationButtonEnabled: true,
              zoomControlsEnabled: false,
              onMapCreated: _onMapCreated,
              markers: markers,
            ),
            Positioned(
              top: 16.0,
              right: 16.0,
              child: Column(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: tPrimaryColor,
                    ),
                    child: IconButton(
                      onPressed: () {
                        mapController.animateCamera(CameraUpdate.zoomIn());
                      },
                      icon: const Icon(Icons.add, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: tPrimaryColor,
                    ),
                    child: IconButton(
                      onPressed: () {
                        mapController.animateCamera(CameraUpdate.zoomOut());
                      },
                      icon: const Icon(Icons.remove, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
