import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/constants.dart';
import 'core/theme.dart';
import 'screens/home_screen.dart';
import 'services/audio_service.dart';
import 'services/progress_service.dart';
import 'state/progress_provider.dart';

class UrduCoreApp extends StatelessWidget {
  final ProgressService progressService;

  const UrduCoreApp({super.key, required this.progressService});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProgressProvider(progressService)),
        Provider<AudioService>(
          create: (_) => AudioService(),
          dispose: (_, service) => service.dispose(),
        ),
      ],
      child: MaterialApp(
        title: AppConstants.appTitle,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        home: const HomeScreen(),
      ),
    );
  }
}
