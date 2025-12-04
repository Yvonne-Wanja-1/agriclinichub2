import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notifications = true;
  bool _darkMode = false;
  String _language = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings'), elevation: 0),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            _buildSettingsSection(
              title: 'Preferences',
              children: [
                _buildToggleSetting(
                  title: 'Push Notifications',
                  value: _notifications,
                  onChanged: (value) {
                    setState(() => _notifications = value);
                  },
                ),
                _buildToggleSetting(
                  title: 'Dark Mode',
                  value: _darkMode,
                  onChanged: (value) {
                    setState(() => _darkMode = value);
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildSettingsSection(
              title: 'Language & Region',
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: DropdownButtonFormField<String>(
                    value: _language,
                    items: const [
                      DropdownMenuItem(
                        value: 'English',
                        child: Text('English'),
                      ),
                      DropdownMenuItem(
                        value: 'Kiswahili',
                        child: Text('Kiswahili'),
                      ),
                      DropdownMenuItem(value: 'Kikuyu', child: Text('Kikuyu')),
                    ],
                    onChanged: (value) {
                      setState(() => _language = value ?? 'English');
                    },
                    decoration: InputDecoration(
                      labelText: 'Language',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildSettingsSection(
              title: 'About',
              children: [
                _buildSettingItem('App Version', '1.0.0'),
                _buildSettingItem('Build Number', '1'),
              ],
            ),
            const SizedBox(height: 16),
            _buildSettingsSection(
              title: 'Legal',
              children: [
                _buildTappableSetting('Privacy Policy', onTap: () {}),
                _buildTappableSetting('Terms of Service', onTap: () {}),
                _buildTappableSetting('Contact Us', onTap: () {}),
              ],
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: OutlinedButton(
                onPressed: () {
                  // Handle logout
                  Navigator.of(context).pushReplacementNamed('/login');
                },
                child: const Text('Logout'),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
          child: Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: Colors.grey.shade300),
              bottom: BorderSide(color: Colors.grey.shade300),
            ),
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildToggleSetting({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Switch(value: value, onChanged: onChanged),
        ],
      ),
    );
  }

  Widget _buildSettingItem(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value, style: TextStyle(color: Colors.grey.shade600)),
        ],
      ),
    );
  }

  Widget _buildTappableSetting(String title, {required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
            Icon(Icons.arrow_forward, color: Colors.grey.shade400),
          ],
        ),
      ),
    );
  }
}
