import 'package:flutter/material.dart';
import 'convex_bottom_nav.dart';

class BottomNavWrapper extends StatefulWidget {
  final int initialIndex;
  final Widget child;

  const BottomNavWrapper({
    Key? key,
    required this.initialIndex,
    required this.child,
  }) : super(key: key);

  @override
  State<BottomNavWrapper> createState() => _BottomNavWrapperState();
}

class _BottomNavWrapperState extends State<BottomNavWrapper> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  void _onNavTap(int index) {
    setState(() {
      _currentIndex = index;
    });

    // Define route names based on index
    final routes = ['/scan', '/history', '/profile', '/calendar', '/home'];

    if (index < routes.length) {
      Navigator.of(
        context,
      ).pushNamedAndRemoveUntil(routes[index], (route) => false);
    }
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
