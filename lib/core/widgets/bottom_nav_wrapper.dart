import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class BottomNavWrapper extends StatefulWidget {
  final Widget child;
  final int initialIndex;

  const BottomNavWrapper({Key? key, required this.child, this.initialIndex = 2})
    : super(key: key);

  @override
  State<BottomNavWrapper> createState() => _BottomNavWrapperState();
}

class _BottomNavWrapperState extends State<BottomNavWrapper> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  void _onNavTap(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Navigate based on the selected index
    // Order: Profile (0), Scan (1), Home (2), Calendar (3), History (4)
    switch (index) {
      case 0:
        Navigator.of(context).pushNamed('/profile');
        break;
      case 1:
        Navigator.of(context).pushNamed('/scan');
        break;
      case 2:
        Navigator.of(context).pushNamed('/home');
        break;
      case 3:
        Navigator.of(context).pushNamed('/calendar');
        break;
      case 4:
        Navigator.of(context).pushNamed('/history');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: CurvedNavigationBar(
        index: _selectedIndex,
        height: 75.0,
        items: [
          Icon(Icons.person, size: 30, color: Colors.white),
          Icon(Icons.camera_alt, size: 30, color: Colors.white),
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.calendar_month, size: 30, color: Colors.white),
          Icon(Icons.history, size: 30, color: Colors.white),
        ],
        color: Colors.green.shade600,
        backgroundColor: Colors.white,
        animationDuration: const Duration(milliseconds: 300),
        onTap: _onNavTap,
        letIndexChange: (index) => true,
      ),
    );
  }
}
