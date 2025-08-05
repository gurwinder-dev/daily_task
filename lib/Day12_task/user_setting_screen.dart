import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSettingsScreen extends StatefulWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onDarkModeChanged;

  const UserSettingsScreen({super.key,
    required this.isDarkMode,
    required this.onDarkModeChanged,
  });

  @override
  State<UserSettingsScreen> createState() => _UserSettingsScreenState();
}

class _UserSettingsScreenState extends State<UserSettingsScreen> {
  late bool isDarkMode;
  bool appAlerts = true;
  bool emailUpdates = false;
  String selectedLanguage = 'English';

  final List<String> languages = ['English', 'Hindi', 'Spanish', 'French','Punjabi'];

  @override
  void initState() {
    super.initState();
    isDarkMode = widget.isDarkMode;
    loadPreferences();
  }

  Future<void> loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      appAlerts = prefs.getBool('appAlerts') ?? true;
      emailUpdates = prefs.getBool('emailUpdates') ?? false;
      selectedLanguage = prefs.getString('language') ?? 'English';
    });
  }

  Future<void> savePreference(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value is bool) {
      await prefs.setBool(key, value);
    } else if (value is String) {
      await prefs.setString(key, value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Settings'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Account', style: sectionHeaderStyle),
            const SizedBox(height: 8),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Name'),
              subtitle: const Text('Simar Ajnala'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.email),
              title: const Text('Email'),
              subtitle: const Text('SimarAjnala02@example.com'),
              onTap: () {},
            ),
            const Divider(height: 32),

            Text('Preferences', style: sectionHeaderStyle),

            const SizedBox(height: 8),

            SwitchListTile(
              title: Text('Dark Mode'),
              secondary: Icon(Icons.dark_mode),
              value: isDarkMode,
              onChanged: (value) {
                widget.onDarkModeChanged(value);
                setState(() {
                  isDarkMode = value;
                });
              },
            ),
            ListTile(
              leading: Icon(Icons.language),
              title: Text('Language'),
              trailing: DropdownButton<String>(
                value: selectedLanguage,
                items: languages.map((lang) {
                  return DropdownMenuItem<String>(
                    value: lang,
                    child: Text(lang),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      selectedLanguage = value;
                    });
                    savePreference('language', value);
                  }
                },
              ),
            ),
            const Divider(height: 32),

            Text('Notifications', style: sectionHeaderStyle),

            const SizedBox(height: 8),

            SwitchListTile(
              title: Text('App Alerts'),
              value: appAlerts,
              onChanged: (value) {
                setState(() {
                  appAlerts = value;
                });
                savePreference('appAlerts', value);
              },
              secondary: Icon(Icons.notifications_active),
            ),
            SwitchListTile(
              title: Text('Email Updates'),
              value: emailUpdates,
              onChanged: (value) {
                setState(() {
                  emailUpdates = value;
                });
                savePreference('emailUpdates', value);
              },
              secondary: Icon(Icons.email),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle get sectionHeaderStyle => TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Theme.of(context).colorScheme.secondary,
  );
}
