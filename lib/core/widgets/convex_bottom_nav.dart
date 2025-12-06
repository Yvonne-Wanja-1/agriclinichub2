import 'package:flutter/material.dart';

class ConvexBottomNav extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const ConvexBottomNav({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  State<ConvexBottomNav> createState() => _ConvexBottomNavState();
}

class _ConvexBottomNavState extends State<ConvexBottomNav>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late List<AnimationController> _itemAnimationControllers;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _itemAnimationControllers = List.generate(
      5,
      (index) => AnimationController(
        duration: const Duration(milliseconds: 400),
        vsync: this,
      ),
    );

    _animateToIndex(widget.currentIndex);
  }

  @override
  void didUpdateWidget(ConvexBottomNav oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIndex != widget.currentIndex) {
      _animateToIndex(widget.currentIndex);
    }
  }

  void _animateToIndex(int index) {
    for (int i = 0; i < _itemAnimationControllers.length; i++) {
      if (i == index) {
        _itemAnimationControllers[i].forward();
      } else {
        _itemAnimationControllers[i].reverse();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    for (var controller in _itemAnimationControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
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
              _buildAnimatedNavItem(0, Icons.camera_alt, 'Scan'),
              _buildAnimatedNavItem(1, Icons.history, 'History'),
              SizedBox(width: 110), // Space for convex curve
              _buildAnimatedNavItem(2, Icons.person, 'Profile'),
              _buildAnimatedNavItem(3, Icons.calendar_month, 'Calendar'),
            ],
          ),
          Positioned(
            top: -30,
            left: MediaQuery.of(context).size.width / 2 - 50,
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.8, end: 1.0).animate(
                CurvedAnimation(
                  parent: _itemAnimationControllers[4],
                  curve: Curves.elasticOut,
                ),
              ),
              child: GestureDetector(
                onTap: () {
                  widget.onTap(4);
                },
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 16,
                        spreadRadius: 4,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Icon(
                      Icons.home,
                      color: Colors.green.shade600,
                      size: 44,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedNavItem(int index, IconData icon, String label) {
    return GestureDetector(
      onTap: () {
        widget.onTap(index);
      },
      child: ScaleTransition(
        scale: Tween<double>(begin: 1.0, end: 1.15).animate(
          CurvedAnimation(
            parent: _itemAnimationControllers[index],
            curve: Curves.easeInOutBack,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Center(child: Icon(icon, color: Colors.black87, size: 26)),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
