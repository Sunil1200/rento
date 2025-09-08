import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as location;
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GoogleMapController? _mapController;
  location.LocationData? _currentLocation;
  location.Location _location = location.Location();
  Set<Marker> _markers = {};
  int _selectedIndex = 0;

  // Default location (New York City)
  static const CameraPosition _defaultLocation = CameraPosition(
    target: LatLng(40.7128, -74.0060),
    zoom: 14.0,
  );

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
    _addSampleMarkers();
  }

  Future<void> _requestLocationPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      _getCurrentLocation();
    } else {
      Get.snackbar(
        'Permission Required',
        'Location permission is needed to show your current location',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      bool serviceEnabled = await _location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await _location.requestService();
        if (!serviceEnabled) return;
      }

      location.PermissionStatus permissionGranted = await _location.hasPermission();
      if (permissionGranted == location.PermissionStatus.denied) {
        permissionGranted = await _location.requestPermission();
        if (permissionGranted != location.PermissionStatus.granted) return;
      }

      _currentLocation = await _location.getLocation();
      if (_currentLocation != null && _mapController != null) {
        _mapController!.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(
                _currentLocation!.latitude!,
                _currentLocation!.longitude!,
              ),
              zoom: 15.0,
            ),
          ),
        );

        // Add current location marker
        setState(() {
          _markers.add(
            Marker(
              markerId: const MarkerId('current_location'),
              position: LatLng(
                _currentLocation!.latitude!,
                _currentLocation!.longitude!,
              ),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
              infoWindow: const InfoWindow(
                title: 'Your Location',
                snippet: 'Current position',
              ),
            ),
          );
        });
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Could not get current location: $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void _addSampleMarkers() {
    // Add some sample markers for demonstration
    setState(() {
      _markers.addAll([
        const Marker(
          markerId: MarkerId('marker_1'),
          position: LatLng(40.7589, -73.9851),
          infoWindow: InfoWindow(
            title: 'Times Square',
            snippet: 'Popular tourist destination',
          ),
        ),
        const Marker(
          markerId: MarkerId('marker_2'),
          position: LatLng(40.7505, -73.9934),
          infoWindow: InfoWindow(
            title: 'Empire State Building',
            snippet: 'Famous landmark',
          ),
        ),
        const Marker(
          markerId: MarkerId('marker_3'),
          position: LatLng(40.6892, -74.0445),
          infoWindow: InfoWindow(
            title: 'Statue of Liberty',
            snippet: 'National monument',
          ),
        ),
        const Marker(
          markerId: MarkerId('marker_4'),
          position: LatLng(40.7614, -73.9776),
          infoWindow: InfoWindow(
            title: 'Central Park',
            snippet: 'Large public park',
          ),
        ),
      ]);
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _onBottomNavTap(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        // Map tab - already active
        break;
      case 1:
        // Unlock tab
        Get.snackbar(
          'Unlock',
          'Unlock feature coming soon!',
          snackPosition: SnackPosition.TOP,
          backgroundColor: const Color(0xFF00E676),
          colorText: Colors.white,
        );
        break;
      case 2:
        // Settings tab
        Get.snackbar(
          'Settings',
          'Settings feature coming soon!',
          snackPosition: SnackPosition.TOP,
          backgroundColor: const Color(0xFF00E676),
          colorText: Colors.white,
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Map
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: _defaultLocation,
            markers: _markers,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            mapType: MapType.normal,
            zoomControlsEnabled: true,
            compassEnabled: true,
            onTap: (LatLng position) {
              // Add marker on tap
              setState(() {
                _markers.add(
                  Marker(
                    markerId: MarkerId('marker_${_markers.length + 1}'),
                    position: position,
                    infoWindow: InfoWindow(
                      title: 'Custom Marker',
                      snippet: 'Lat: ${position.latitude.toStringAsFixed(4)}, Lng: ${position.longitude.toStringAsFixed(4)}',
                    ),
                  ),
                );
              });
            },
          ),
          
          // Top App Bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.only(
                top: 50,
                left: 20,
                right: 20,
                bottom: 20,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.7),
                    Colors.transparent,
                  ],
                ),
              ),
              child: Row(
                children: [
                  // Profile Picture
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                      image: const DecorationImage(
                        image: NetworkImage(
                          'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150&h=150&fit=crop&crop=face',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  // Welcome Text
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Welcome back!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'Find your perfect rental',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Location Button
                  IconButton(
                    onPressed: _getCurrentLocation,
                    icon: const Icon(
                      Icons.my_location,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onBottomNavTap,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: const Color(0xFF673AB7),
          unselectedItemColor: Colors.grey,
          elevation: 0,
          items: [
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _selectedIndex == 0 
                      ? const Color(0xFF673AB7).withOpacity(0.1)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.map_outlined,
                  size: 24,
                  color: _selectedIndex == 0 
                      ? const Color(0xFF673AB7)
                      : Colors.grey,
                ),
              ),
              label: 'Map',
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _selectedIndex == 1 
                      ? const Color(0xFF673AB7).withOpacity(0.1)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.lock_open_outlined,
                  size: 24,
                  color: _selectedIndex == 1 
                      ? const Color(0xFF673AB7)
                      : Colors.grey,
                ),
              ),
              label: 'Unlock',
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _selectedIndex == 2 
                      ? const Color(0xFF673AB7).withOpacity(0.1)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.settings_outlined,
                  size: 24,
                  color: _selectedIndex == 2 
                      ? const Color(0xFF673AB7)
                      : Colors.grey,
                ),
              ),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
