import 'package:flutter/material.dart';
import '../core/constants.dart';
import '../data/module_registry.dart';
import '../widgets/app_drawer.dart';
import 'lesson_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final firstLesson = ModuleRegistry.modules.first.lessons.first;

    return Scaffold(
      appBar: AppBar(title: const Text(AppConstants.appTitle)),
      drawer: const AppDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.auto_stories, size: 80, color: Theme.of(context).primaryColor),
            const SizedBox(height: 20),
            const Text(
              AppConstants.appTitle,
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: Text(
                "Learn Urdu by understanding the core 'engines' and 'logic' behind the script.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.blueGrey),
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => LessonScreen(lesson: firstLesson)),
              ),
              child: const Text("Begin with Basics"),
            ),
          ],
        ),
      ),
    );
  }
}
