import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isOnline = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _checkConnectivity();
  }

  void _checkConnectivity() async {
    final connectivity = Connectivity();
    connectivity.onConnectivityChanged.listen((result) {
      setState(() {
        _isOnline = result != ConnectivityResult.none;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFFF5F9F5),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 0.0),
              child: IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  _scaffoldKey.currentState?.openEndDrawer();
                },
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ),
            const SizedBox(width: 2),
            Container(
              width: 39,
              height: 39,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.green.shade600, width: 2),
              ),
              child: ClipOval(
                child: Image.asset('assets/images/logo.png', fit: BoxFit.cover),
              ),
            ),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                'Agri Clinic Hub',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        elevation: 0,
        backgroundColor: Colors.green.shade400,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.green.shade400,
          statusBarBrightness: Brightness.light,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Center(
              child: Tooltip(
                message: _isOnline ? 'Online' : 'Offline',
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: _isOnline
                              ? Colors.green.shade700
                              : Colors.grey.shade700,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        _isOnline ? 'Online' : 'Offline',
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: HomeContent(isOnline: _isOnline),
      endDrawer: Drawer(
        backgroundColor: const Color(0xFFF5F9F5),
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: const Color(0xFFF5F9F5),
                borderRadius: BorderRadius.circular(32),
              ),
              margin: EdgeInsets.zero,
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green.shade400,
                          blurRadius: 8,
                          spreadRadius: 3,
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/logo.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Agri Clinic Hub',
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildDrawerMenuItem(
                    context,
                    Icons.person,
                    'Profile',
                    '/profile',
                    dense: true,
                  ),
                  _buildDrawerMenuItem(
                    context,
                    Icons.history,
                    'Scan History',
                    '/history',
                    dense: true,
                  ),
                  _buildDrawerMenuItem(
                    context,
                    Icons.calendar_month,
                    'Crop Calendar',
                    '/calendar',
                    dense: true,
                  ),
                  _buildDrawerMenuItem(
                    context,
                    Icons.article,
                    'Articles',
                    '/articles',
                    dense: true,
                  ),
                  _buildDrawerMenuItem(
                    context,
                    Icons.mic,
                    'Voice Mode',
                    '/voice-mode',
                    dense: true,
                  ),
                  _buildDrawerMenuItem(
                    context,
                    Icons.language,
                    'Language',
                    '/language',
                    dense: true,
                  ),
                  _buildDrawerMenuItem(
                    context,
                    Icons.phone,
                    'Contact Us',
                    '/contact-us',
                    dense: true,
                  ),
                  _buildDrawerMenuItem(
                    context,
                    Icons.info,
                    'About Us',
                    '/about-us',
                    dense: true,
                  ),
                ],
              ),
            ),
            _buildDrawerMenuItem(
              context,
              Icons.settings,
              'Settings',
              '/settings',
              dense: true,
            ),
            ListTile(
              dense: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 0,
              ),
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text(
                'Logout',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
                // add logout logic here
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerMenuItem(
    BuildContext context,
    IconData icon,
    String title,
    String route, {
    bool dense = false,
  }) {
    return ListTile(
      dense: dense,
      contentPadding: dense
          ? const EdgeInsets.symmetric(horizontal: 16, vertical: 0)
          : null,
      leading: Icon(icon, color: Colors.green.shade600),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.green.shade600,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: () {
        Navigator.of(context).pop();
        Navigator.of(context).pushNamed(route);
      },
    );
  }
}

class HomeContent extends StatefulWidget {
  final bool isOnline;
  const HomeContent({Key? key, this.isOnline = true}) : super(key: key);

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Greeting and Weather Card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green.shade300, Colors.green.shade500],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.green.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${_getGreeting()}, Yvonne!',
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.isOnline
                                ? 'Your farm is healthy and thriving'
                                : 'Offline mode: displaying cached data',
                            style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.cloud_outlined,
                            color: Colors.black87,
                            size: 32,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.isOnline ? '24°C' : '24°C (cached)',
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            widget.isOnline ? 'Partly Cloudy' : 'Offline',
                            style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Quick Actions
          Text(
            'Quick Actions',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            children: [
              _buildActionCard(
                context,
                Icons.camera_alt,
                'Scan Plant',
                Colors.blue,
                () => Navigator.of(context).pushNamed('/scan'),
              ),
              _buildActionCard(
                context,
                Icons.calendar_month,
                'Crop Calendar',
                Colors.orange,
                () => Navigator.of(context).pushNamed('/calendar'),
              ),
              _buildActionCard(
                context,
                Icons.article,
                'Articles',
                Colors.purple,
                () => Navigator.of(context).pushNamed('/articles'),
              ),
              _buildActionCard(
                context,
                Icons.mic,
                'Voice Mode',
                Colors.red,
                () => Navigator.of(context).pushNamed('/voice-mode'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Recent Activity
          Text(
            'Recent Activity',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
              boxShadow: [
                BoxShadow(
                  color: Colors.green.shade400,
                  blurRadius: 5,
                  offset: const Offset(0, 4),
                  spreadRadius: 2,
                ),
              ],
            ),
            child: ListTile(
              leading: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.eco, color: Colors.green.shade700),
              ),
              title: const Text(
                'Tomato Leaf Scan',
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: const Text(
                '2 hours ago',
                style: TextStyle(color: Colors.black54),
              ),
              trailing: const Chip(
                label: Text('Healthy', style: TextStyle(color: Colors.white)),
                backgroundColor: Colors.green,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
              boxShadow: [
                BoxShadow(
                  color: Colors.green.shade400,
                  blurRadius: 5,
                  offset: const Offset(0, 4),
                  spreadRadius: 2,
                ),
              ],
            ),
            child: ListTile(
              leading: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.warning, color: Colors.orange.shade700),
              ),
              title: const Text(
                'Maize Leaf Scan',
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: const Text(
                'Yesterday',
                style: TextStyle(color: Colors.black54),
              ),
              trailing: const Chip(
                label: Text('Warning', style: TextStyle(color: Colors.white)),
                backgroundColor: Colors.orange,
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  static Widget _buildActionCard(
    BuildContext context,
    IconData icon,
    String label,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color, width: 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Colors.white, size: 28),
            ),
            const SizedBox(height: 12),
            Text(
              label,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
