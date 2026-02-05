import 'package:flutter/material.dart';
import 'package:welangflood/src/constants/color.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'dart:core';
import 'package:welangflood/src/features/screens/entri/widgets/map_picker_screen.dart';

class LocationPicker extends StatefulWidget {
  final String hintText;
  final Function(LatLng)? onLocationSelected;

  const LocationPicker({
    Key? key,
    required this.hintText,
    this.onLocationSelected,
  }) : super(key: key);

  @override
  _LocationPickerState createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  TextEditingController _locationController = TextEditingController();
  GoogleMapController? _mapController;
  LatLng _pickedLocation = const LatLng(-7.741785, 112.797416);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Container(
      width: screenSize.width >= 375 ? 375 : screenSize.width - 30,
      height: 300,
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.hintText,
            style: const TextStyle(
              color: tPrimaryColor,
              fontSize: 16,
              fontFamily: 'Inter',
            ),
          ),
          SizedBox(height: screenSize.height * 0.01),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: tPrimaryColor),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 200,
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: _pickedLocation,
                        zoom: 14.0,
                      ),
                      onMapCreated: _onMapCreated,
                      onTap: _selectLocation,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _locationController,
                          decoration: const InputDecoration(
                            hintText: 'Masukkan lokasi survei',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                          ),
                          style: const TextStyle(color: tPrimaryColor),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.location_on),
                        onPressed: _pickLocation,
                        color: tPrimaryColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  Future<void> _selectLocation(LatLng latLng) async {
    setState(() {
      _pickedLocation = latLng;
    });
    widget.onLocationSelected?.call(_pickedLocation);

    List<Placemark> placemarks = await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
    _locationController.text = placemarks.isNotEmpty ? placemarks[0].name ?? '' : '';
  }

  Future<void> _pickLocation() async {
    LatLng? selectedLocation = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MapPickerScreen(initialLocation: _pickedLocation,),
      ),
    );

    if (selectedLocation != null) {
      setState(() {
        _pickedLocation = selectedLocation;
      });

      widget.onLocationSelected?.call(_pickedLocation);

      List<Placemark> placemarks = await placemarkFromCoordinates(selectedLocation.latitude, selectedLocation.longitude);
      _locationController.text = placemarks.isNotEmpty ? placemarks[0].name ?? '' : '';
    }
  }

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }
}


