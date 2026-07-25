import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'providers/app_provider.dart';
import 'providers/gps_provider.dart';
import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';
import 'screens/viewer_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/about_screen.dart';
import 'theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  final prefs = await SharedPreferences.getInstance();
  runApp(BorneoGISApp(prefs: prefs));
}

class BorneoGISApp extends StatelessWidget {
  final SharedPreferences prefs;
  const BorneoGISApp({super.key, required this.prefs});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider(prefs)),
        ChangeNotifierProvider(create: (_) => GpsProvider()),
      ],
      child: Consumer<AppProvider>(
        builder: (context, app, _) {
          return MaterialApp(
            title: 'BorneoGIS PDF Map',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: app.themeMode,
            initialRoute: '/splash',
            routes: {
              '/splash': (_) => const SplashScreen(),
              '/home': (_) => const HomeScreen(),
              '/settings': (_) => const SettingsScreen(),
              '/about': (_) => const AboutScreen(),
            },
            onGenerateRoute: (settings) {
              if (settings.name == '/viewer') {
                final args = settings.arguments as Map<String, dynamic>?;
                return MaterialPageRoute(
                  builder: (_) => ViewerScreen(
                    filePath: args?['filePath'] as String? ?? '',
                    fileName: args?['fileName'] as String? ?? '',
                  ),
                );
              }
              return null;
            },
          );
        },
      ),
    );
  }
}
