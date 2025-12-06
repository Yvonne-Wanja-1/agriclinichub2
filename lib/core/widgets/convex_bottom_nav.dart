import 'package:flutter/material.dart';

class ConvexBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const ConvexBottomNav({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Colors.green.shade400,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 12,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(0, Icons.camera_alt, 'Scan'),
                _buildNavItem(1, Icons.history, 'History'),
                SizedBox(width: 100), // Space for convex curve
                _buildNavItem(2, Icons.person, 'Profile'),
                _buildNavItem(3, Icons.shopping_cart, 'More'),
              ],
            ),
            Positioned(
              top: -25,
              left: MediaQuery.of(context).size.width / 2 - 45,
              child: GestureDetector(
                onTap: () => onTap(4),
                child: Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 12,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Icon(
                      Icons.home,
                      color: Colors.green.shade600,
                      size: 40,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    bool isActive = currentIndex == index;
    return GestureDetector(
      onTap: () => onTap(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: isActive ? Colors.white : Colors.white.withOpacity(0.3),
              shape: BoxShape.circle,
              boxShadow: isActive
                  ? [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                      ),
                    ]
                  : [],
            ),
            child: Center(
              child: Icon(
                icon,
                color: isActive ? Colors.green.shade600 : Colors.white,
                size: 24,
              ),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
