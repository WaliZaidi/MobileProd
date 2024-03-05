import 'package:flutter/material.dart';
import 'package:frontend/screens/home_screen.dart';
import 'package:frontend/store/store.dart';
import 'package:frontend/widgets/loader_bars.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController _urlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _urlController,
              decoration: const InputDecoration(
                labelText: 'Server URL',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                final newUrl = _urlController.text;
                if (newUrl.isNotEmpty) {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString('serverUrl', newUrl);
                  AppDataStore.updateServerUrl(
                      newUrl); // Update the URL in AppDataStore
                  // ignore: use_build_context_synchronously
                  LoaderBar.showMessage(
                      context, "Server URL updated successfully");
                  MaterialPageRoute(builder: (context) => const HomeScreen());
                }
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
