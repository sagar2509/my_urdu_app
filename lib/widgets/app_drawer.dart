import 'package:flutter/material.dart';
import '../core/constants.dart';
import '../data/module_registry.dart';
import '../navigation/lesson_navigation.dart';

/// Navigation drawer built from [ModuleRegistry] — adding a new module to
/// the registry automatically adds it here, no drawer edits required.
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  void _goHome(BuildContext context) {
    Navigator.pop(context); // close the drawer
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: theme.primaryColor),
            child: Center(
              child: Text(
                AppConstants.menu,
                style: TextStyle(color: theme.colorScheme.onPrimary, fontSize: 24),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text(AppConstants.home),
            onTap: () => _goHome(context),
          ),
          const Divider(),
          for (final module in ModuleRegistry.modules)
            ExpansionTile(
              leading: Icon(module.icon),
              title: Text(module.title),
              initiallyExpanded: true,
              children: [
                for (final lesson in module.lessons)
                  ListTile(
                    leading: Icon(lesson.icon),
                    title: Text(lesson.title),
                    onTap: () => openLessonFromDrawer(context, lesson),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}
