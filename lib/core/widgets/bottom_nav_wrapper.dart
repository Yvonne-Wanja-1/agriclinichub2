import 'package:flutter/material.dart';
import 'convex_bottom_nav.dart';

class BottomNavWrapper extends StatefulWidget {
  final Widget child;
  final int initialIndex;

  const BottomNavWrapper({
    Key? key,
    required this.child,
    this.initialIndex = 4, // Home is default
  }) : super(key: key);

  @override
  State<BottomNavWrapper> createState() => _BottomNavWrapperState();
}

class _BottomNavWrapperState extends State<BottomNavWrapper> {
  late int _currentIndex;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNavTap(int index) {
    setState(() {
      _currentIndex = index;
    });
    _navigateToScreen(index);
  }

  void _navigateToScreen(int index) {
    String route;
    switch (index) {
      case 0: // Scan
        route = '/scan';
        break;
      case 1: // History
        route = '/history';
        break;
      case 2: // Profile
        route = '/profile';
        break;
      case 3: // Calendar
        route = '/calendar';
        break;
      case 4: // Home
        route = '/home';
        break;
      default:
        route = '/home';
    }

    Navigator.of(context).pushNamed(route).then((_) {
      setState(() {
        // Keep the current index when returning from another screen
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: ConvexBottomNav(
        currentIndex: _currentIndex,
        onTap: _onNavTap,
      ),
    );
  }
}
