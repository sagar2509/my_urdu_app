import 'package:flutter/material.dart';
import 'app.dart';
import 'services/progress_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final progressService = await ProgressService.create();
  runApp(UrduCoreApp(progressService: progressService));
}
