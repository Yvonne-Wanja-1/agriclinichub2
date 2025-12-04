import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agri Clinic Hub', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        backgroundColor: Colors.green.shade600,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).pushNamed('/settings');
            },
          ),
        ],
      ),
      body: _buildContent(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() => _selectedIndex = index);
          _navigateToScreen(index);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.camera_alt), label: 'Scan'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildContent() {
    switch (_selectedIndex) {
      case 0:
        return const HomeContent();
      case 1:
        return Container();
      case 2:
        return Container();
      case 3:
        return Container();
      default:
        return const HomeContent();
    }
  }

  void _navigateToScreen(int index) {
    switch (index) {
      case 1:
        Navigator.of(context).pushNamed('/scan').then((_) {
          setState(() => _selectedIndex = 0);
        });
        break;
      case 2:
        Navigator.of(context).pushNamed('/history').then((_) {
          setState(() => _selectedIndex = 0);
        });
        break;
      case 3:
        Navigator.of(context).pushNamed('/profile').then((_) {
          setState(() => _selectedIndex = 0);
        });
        break;
    }
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome Card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green.shade400, Colors.green.shade700],
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
                const Text(
                  'Welcome back, Farmer!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Your farm is healthy and thriving',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
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
                Icons.school,
                'Learn',
                Colors.purple,
                () => Navigator.of(context).pushNamed('/education'),
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
          // Recent Scans
          Text(
            'Recent Activity',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Card(
            elevation: 2,
            child: ListTile(
              leading: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.leaf, color: Colors.green.shade700),
              ),
              title: const Text('Tomato Leaf Scan'),
              subtitle: const Text('2 hours ago'),
              trailing: const Chip(
                label: Text('Healthy', style: TextStyle(color: Colors.white)),
                backgroundColor: Colors.green,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            elevation: 2,
            child: ListTile(
              leading: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.yellow.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.warning, color: Colors.yellow.shade700),
              ),
              title: const Text('Maize Leaf Scan'),
              subtitle: const Text('Yesterday'),
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

  Widget _buildActionCard(BuildContext context, IconData icon, String label, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.3), width: 1),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Your Digital Farm Clinic',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Quick Actions
            Text(
              'Quick Actions',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: [
                _buildActionCard(
                  context,
                  icon: Icons.camera_alt,
                  title: 'Scan Plant',
                  onTap: () => Navigator.of(context).pushNamed('/scan'),
                ),
                _buildActionCard(
                  context,
                  icon: Icons.calendar_today,
                  title: 'Crop Calendar',
                  onTap: () => Navigator.of(context).pushNamed('/calendar'),
                ),
                _buildActionCard(
                  context,
                  icon: Icons.school,
                  title: 'Learn',
                  onTap: () => Navigator.of(context).pushNamed('/education'),
                ),
                _buildActionCard(
                  context,
                  icon: Icons.mic,
                  title: 'Voice Mode',
                  onTap: () => Navigator.of(context).pushNamed('/voice-mode'),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Recent Scans
            Text('Recent Scans', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text('No recent scans. Start by scanning a plant!'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.green.shade200),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Colors.green.shade700, size: 28),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}

class ScanPlaceholder extends StatelessWidget {
  const ScanPlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Scan Screen - Navigate from home'));
  }
}

class HistoryPlaceholder extends StatelessWidget {
  const HistoryPlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('History Screen - Navigate from home'));
  }
}

class ProfilePlaceholder extends StatelessWidget {
  const ProfilePlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Profile Screen - Navigate from home'));
  }
}
