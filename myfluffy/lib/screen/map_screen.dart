import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? mapController;
  LatLng? _center;
  Marker? _centerMarker;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Location'),
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
              _setInitialLocation();
            },
            initialCameraPosition: CameraPosition(
              target: LatLng(13.736717, 100.523186), // Initial location (San Francisco)
              zoom: 12.0, // Initial zoom level
            ),
            myLocationEnabled: true, // Show current location button
            myLocationButtonEnabled: true, // Show current location button
            mapType: MapType.normal, // Map type
            onCameraMove: (CameraPosition position) {
              _updateCenter(position.target);
            },
            onTap: (LatLng latLng) {
              _selectLocation(latLng);
            },
            markers: _centerMarker != null ? {_centerMarker!} : {},
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: Colors.white.withOpacity(0.8),
            onPressed: () async {
              if (_center != null) {
                // Handle button press to select location
                String? address = await _getAddressFromLatLng(_center!);
                debugPrint(address);
                String title = address != null
                    ? 'Selected Location: $address'
                    : 'Selected Location: ${_center!.latitude}, ${_center!.longitude}';
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(title)));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('No location selected')));
              }
            },
            child: Icon(Icons.check, color: Color(0xff0064FF)),
          ),
          SizedBox(height: 16),
          FloatingActionButton(
            backgroundColor: Colors.white.withOpacity(0.8),
            onPressed: () {
              _navigateToCurrentLocation();
            },
            child: Icon(Icons.my_location, color: Color(0xff0064FF)),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    mapController?.dispose();
    super.dispose();
  }

  void _setInitialLocation() async {
    LatLng? currentLocation = await _getCurrentLocation();
    if (currentLocation != null) {
      mapController?.animateCamera(CameraUpdate.newLatLngZoom(currentLocation, 17.0));
      _updateCenter(currentLocation);
    }
  }

  Future<LatLng?> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Location services are disabled.')));
      return null;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Location permissions are denied.')));
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Location permissions are permanently denied.')));
      return null;
    }

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return LatLng(position.latitude, position.longitude);
  }

  void _updateCenter(LatLng newCenter) {
    setState(() {
      _center = newCenter;
      _centerMarker = Marker(
        markerId: MarkerId('center'),
        position: newCenter,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      );
    });
  }

  void _selectLocation(LatLng latLng) {
    _updateCenter(latLng);
  }

  void _navigateToCurrentLocation() async {
    LatLng? currentLocation = await _getCurrentLocation();
    if (currentLocation != null) {
      mapController?.animateCamera(CameraUpdate.newLatLngZoom(currentLocation, 17.0));
      _updateCenter(currentLocation);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Unable to get current location')));
    }
  }

  Future<String?> _getAddressFromLatLng(LatLng latLng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        return "${place.name} ${place.street} ${place.subLocality} ${place.locality} ${place.subAdministrativeArea} ${place.administrativeArea} ${place.postalCode} ${place.country}";
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
}