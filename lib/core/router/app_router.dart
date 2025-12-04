import 'package:flutter/material.dart';
import '../../features/scan_history/presentation/screens/scan_history_screen.dart';
import '../../features/farmer_profile/presentation/screens/farmer_profile_screen.dart';
import '../../features/crop_calendar/presentation/screens/crop_calendar_screen.dart';
import '../../features/education/presentation/screens/education_screen.dart';
import '../../features/voice_mode/presentation/screens/voice_mode_screen.dart';

class AppRouter {
  static const String splash = '/';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/home';
  static const String scan = '/scan';
  static const String scanResult = '/scan-result';
  static const String history = '/history';
  static const String profile = '/profile';
  static const String editProfile = '/edit-profile';
  static const String cropCalendar = '/calendar';
  static const String education = '/education';
  static const String voiceMode = '/voice-mode';
  static const String settings = '/settings';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRouter.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case AppRouter.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case AppRouter.signup:
        return MaterialPageRoute(builder: (_) => const SignupScreen());
      case AppRouter.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case AppRouter.scan:
        return MaterialPageRoute(builder: (_) => const ScanScreen());
      case AppRouter.scanResult:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => ScanResultScreen(scanData: args?['scanData'] ?? {}),
        );
      case AppRouter.history:
        return MaterialPageRoute(builder: (_) => const ScanHistoryScreen());
      case AppRouter.profile:
        return MaterialPageRoute(builder: (_) => const FarmerProfileScreen());
      case AppRouter.editProfile:
        return MaterialPageRoute(builder: (_) => const EditProfileScreen());
      case AppRouter.cropCalendar:
        return MaterialPageRoute(builder: (_) => const CropCalendarScreen());
      case AppRouter.education:
        return MaterialPageRoute(builder: (_) => const EducationScreen());
      case AppRouter.voiceMode:
        return MaterialPageRoute(builder: (_) => const VoiceModeScreen());
      case AppRouter.settings:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}

// Placeholder imports - will be implemented
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      Navigator.of(context).pushReplacementNamed(AppRouter.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                Icons.agriculture,
                size: 60,
                color: Colors.green.shade700,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Agri Clinic Hub',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.green.shade700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Smart Farming Assistant',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade600),
            ),
            const SizedBox(height: 40),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Login Screen')));
  }
}

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Signup Screen')));
  }
}

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
      appBar: AppBar(title: const Text('Agri Clinic Hub')),
      body: const Center(child: Text('Home Screen')),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.camera_alt), label: 'Scan'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() => _selectedIndex = index);
          _navigateToScreen(index);
        },
      ),
    );
  }

  void _navigateToScreen(int index) {
    switch (index) {
      case 0:
        break; // Already on home
      case 1:
        Navigator.of(context).pushNamed(AppRouter.scan);
        break;
      case 2:
        Navigator.of(context).pushNamed(AppRouter.history);
        break;
      case 3:
        Navigator.of(context).pushNamed(AppRouter.profile);
        break;
    }
  }
}

class ScanScreen extends StatefulWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan Plant')),
      body: const Center(child: Text('Scan Screen')),
    );
  }
}

// Placeholder screens - using imported feature screens instead
class ScanResultScreen extends StatelessWidget {
  final Map<String, dynamic> scanData;

  const ScanResultScreen({Key? key, required this.scanData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan Results')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Disease: ${scanData['disease'] ?? 'Unknown'}'),
            const SizedBox(height: 16),
            Text('Confidence: ${scanData['confidence'] ?? '0'}%'),
            const SizedBox(height: 16),
            Text('Treatment: ${scanData['treatment'] ?? 'N/A'}'),
          ],
        ),
      ),
    );
  }
}

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _farmSizeController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _farmSizeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _phoneController,
            decoration: const InputDecoration(
              labelText: 'Phone',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _farmSizeController,
            decoration: const InputDecoration(
              labelText: 'Farm Size (acres)',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Save Changes'),
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Language'),
            trailing: DropdownButton<String>(
              value: 'en',
              items: const [
                DropdownMenuItem(value: 'en', child: Text('English')),
                DropdownMenuItem(value: 'sw', child: Text('Kiswahili')),
              ],
              onChanged: (value) {
                // Handle language change
              },
            ),
          ),
          ListTile(
            title: const Text('Dark Mode'),
            trailing: Switch(
              value: false,
              onChanged: (value) {
                // Handle dark mode toggle
              },
            ),
          ),
          ListTile(
            title: const Text('Notifications'),
            trailing: Switch(
              value: true,
              onChanged: (value) {
                // Handle notifications toggle
              },
            ),
          ),
        ],
      ),
    );
  }
}
