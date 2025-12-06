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
  late AnimationController _scaleController;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
  }

  @override
  void didUpdateWidget(ConvexBottomNav oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIndex != widget.currentIndex) {
      _scaleController.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      decoration: BoxDecoration(
        color: Colors.green.shade400,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Bottom nav items
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNavItem(0, Icons.camera_alt, 'Scan'),
              _buildNavItem(1, Icons.history, 'History'),
              SizedBox(width: 120), // Space for center button
              _buildNavItem(2, Icons.person, 'Profile'),
              _buildNavItem(3, Icons.calendar_month, 'Calendar'),
            ],
          ),
          // Center floating home button
          Positioned(
            top: -32,
            left: MediaQuery.of(context).size.width / 2 - 50,
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.9, end: 1.0),
              duration: const Duration(milliseconds: 300),
              curve: Curves.elasticOut,
              builder: (context, scale, child) {
                return Transform.scale(
                  scale: scale,
                  child: InkWell(
                    onTap: () => widget.onTap(4),
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: TweenAnimationBuilder<double>(
                      tween: Tween(
                        begin: widget.currentIndex == 4 ? 0.0 : 0.0,
                        end: widget.currentIndex == 4 ? 0.08 : 0.0,
                      ),
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      builder: (context, shadowIntensity, _) {
                        return Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.green.shade600.withOpacity(
                                  0.3 + shadowIntensity,
                                ),
                                blurRadius: 20 + (shadowIntensity * 20),
                                spreadRadius: 2 + (shadowIntensity * 4),
                              ),
                            ],
                          ),
                          child: Center(
                            child: ScaleTransition(
                              scale: Tween<double>(begin: 1.0, end: 1.15)
                                  .animate(
                                    CurvedAnimation(
                                      parent: _scaleController,
                                      curve: Curves.elasticOut,
                                    ),
                                  ),
                              child: Icon(
                                Icons.home,
                                color: Colors.green.shade600,
                                size: 40,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isActive = widget.currentIndex == index;

    return InkWell(
      onTap: () => widget.onTap(index),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.0, end: isActive ? 1.0 : 0.0),
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
        builder: (context, animValue, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon inside white circle
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(isActive ? 1.0 : 0.2),
                  shape: BoxShape.circle,
                  boxShadow: isActive
                      ? [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 12,
                            spreadRadius: 2,
                          ),
                        ]
                      : [],
                ),
                child: Center(
                  child: ScaleTransition(
                    scale: Tween<double>(begin: 1.0, end: 1.2).animate(
                      CurvedAnimation(
                        parent: _scaleController,
                        curve: Curves.elasticOut,
                      ),
                    ),
                    child: Icon(
                      icon,
                      color: isActive ? Colors.green.shade600 : Colors.white,
                      size: 22,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 4),
              // Label below circle
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 300),
                style: TextStyle(
                  color: isActive ? Colors.white : Colors.white70,
                  fontSize: 11,
                  fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                ),
                child: Text(label),
              ),
            ],
          );
        },
      ),
    );
  }
}
