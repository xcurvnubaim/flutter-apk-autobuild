import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:welangflood/src/constants/color.dart';
import 'package:geocoding/geocoding.dart';

class MapPickerScreen extends StatefulWidget {
  final LatLng initialLocation;

  const MapPickerScreen({Key? key, required this.initialLocation}) : super(key: key);

  @override
  _MapPickerScreenState createState() => _MapPickerScreenState();
}

class _MapPickerScreenState extends State<MapPickerScreen> {
  late GoogleMapController _mapController;
  late LatLng _selectedLocation;
  final Set<Marker> _markers = {};
  String _selectedAddress = '';

  @override
  void initState() {
    super.initState();
    _selectedLocation = widget.initialLocation;
    _markers.add(
      Marker(
        markerId: const MarkerId('selected-location'),
        position: _selectedLocation,
      ),
    );
    _getAddressFromCoordinates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tentukan Lokasi Survei'),
        backgroundColor: tPrimaryColor,
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _selectedLocation,
              zoom: 14.0,
            ),
            onMapCreated: _onMapCreated,
            onTap: _selectLocation,
            zoomControlsEnabled: false,
            markers: _markers,
          ),
          Positioned(
            top: 16,
            left: 16,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Text(
                _selectedAddress,
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ),
          Positioned(
            top: 76,
            right: 16,
            child: Column(
              children: [
                FloatingActionButton(
                  onPressed: _zoomIn,
                  backgroundColor: tPrimaryColor,
                  child: const Icon(Icons.add),
                ),
                const SizedBox(height: 10),
                FloatingActionButton(
                  onPressed: _zoomOut,
                  backgroundColor: tPrimaryColor,
                  child: const Icon(Icons.remove),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            child: ElevatedButton(
              onPressed: _saveLocation,
              style: ElevatedButton.styleFrom(
                backgroundColor: tPrimaryColor,
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(16),
              ),
              child: const Icon(Icons.check, color: tTertiaryColor),
            ),
          ),
        ],
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _selectLocation(LatLng latLng) {
    setState(() {
      _selectedLocation = latLng;
      _markers.clear();
      _markers.add(
        Marker(
          markerId: const MarkerId('selected-location'),
          position: _selectedLocation,
        ),
      );
    });
    _getAddressFromCoordinates();
  }

  void _saveLocation() {
    Navigator.pop(context, _selectedLocation);
  }

  void _zoomIn() {
    _mapController.animateCamera(CameraUpdate.zoomIn());
  }

  void _zoomOut() {
    _mapController.animateCamera(CameraUpdate.zoomOut());
  }

  Future<void> _getAddressFromCoordinates() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(_selectedLocation.latitude, _selectedLocation.longitude);
      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;
        String address = '${placemark.name ?? ''}, ${placemark.street ?? ''}, ${placemark.subLocality ?? ''}, ${placemark.locality ?? ''}, ${placemark.administrativeArea ?? ''}, ${placemark.country ?? ''}';
        setState(() {
          _selectedAddress = address;
        });
      }
    } catch (e) {
      print('Error getting address: $e');
    }
  }
}
