import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SimpleMapPage extends StatefulWidget {
  const SimpleMapPage({super.key});

  @override
  State<SimpleMapPage> createState() => _SimpleMapPageState();
}

class _SimpleMapPageState extends State<SimpleMapPage> {
  int _selectedIndex = 0;
  List<Map<String, dynamic>> _markers = [
    {
      'id': 'marker_1',
      'title': 'Times Square',
      'subtitle': 'Popular tourist destination',
      'position': {'lat': 40.7589, 'lng': -73.9851},
      'color': Colors.red,
    },
    {
      'id': 'marker_2',
      'title': 'Empire State Building',
      'subtitle': 'Famous landmark',
      'position': {'lat': 40.7505, 'lng': -73.9934},
      'color': Colors.blue,
    },
    {
      'id': 'marker_3',
      'title': 'Statue of Liberty',
      'subtitle': 'National monument',
      'position': {'lat': 40.6892, 'lng': -74.0445},
      'color': Colors.green,
    },
    {
      'id': 'marker_4',
      'title': 'Central Park',
      'subtitle': 'Large public park',
      'position': {'lat': 40.7614, 'lng': -73.9776},
      'color': Colors.orange,
    },
  ];

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
          // Map Placeholder
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFE8F5E8), // Light green
                  Color(0xFFE0F2F1), // Light teal
                ],
              ),
            ),
            child: Stack(
              children: [
                // Grid pattern to simulate map
                CustomPaint(
                  painter: GridPainter(),
                  size: Size.infinite,
                ),
                
                // Sample markers
                ..._markers.map((marker) => Positioned(
                  left: (marker['position']['lng'] + 74.1) * MediaQuery.of(context).size.width / 0.2,
                  top: (40.8 - marker['position']['lat']) * MediaQuery.of(context).size.height / 0.2,
                  child: GestureDetector(
                    onTap: () {
                      Get.dialog(
                        AlertDialog(
                          title: Text(marker['title']),
                          content: Text(marker['subtitle']),
                          actions: [
                            TextButton(
                              onPressed: () => Get.back(),
                              child: const Text('Close'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: marker['color'],
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                    ),
                  ),
                )).toList(),
                
              ],
            ),
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
                    onPressed: () {
                      Get.snackbar(
                        'Location',
                        'Location services will be available with Google Maps API',
                        snackPosition: SnackPosition.TOP,
                        backgroundColor: Colors.orange,
                        colorText: Colors.white,
                      );
                    },
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

class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.withOpacity(0.3)
      ..strokeWidth = 1;

    // Draw vertical lines
    for (double x = 0; x < size.width; x += 50) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        paint,
      );
    }

    // Draw horizontal lines
    for (double y = 0; y < size.height; y += 50) {
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
