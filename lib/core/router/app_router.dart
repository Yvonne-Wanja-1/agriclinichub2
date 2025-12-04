import 'package:flutter/material.dart';
import '../../features/auth/presentation/screens/splash_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/signup_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/disease_detection/presentation/screens/scan_screen.dart';
import '../../features/disease_detection/presentation/screens/scan_result_screen.dart';
import '../../features/scan_history/presentation/screens/scan_history_screen.dart';
import '../../features/farmer_profile/presentation/screens/farmer_profile_screen.dart';
import '../../features/farmer_profile/presentation/screens/edit_profile_screen.dart';
import '../../features/crop_calendar/presentation/screens/crop_calendar_screen.dart';
import '../../features/education/presentation/screens/education_screen.dart';
import '../../features/voice_mode/presentation/screens/voice_mode_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';

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
          builder: (_) => ScanResultScreen(imagePath: args?['imagePath'] ?? ''),
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
