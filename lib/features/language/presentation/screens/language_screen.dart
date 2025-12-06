import 'package:flutter/material.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String _selectedLanguage = 'en';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Language'),
        backgroundColor: Colors.green.shade400,
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFF5F9F5),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildLanguageOption('English', 'en'),
          const SizedBox(height: 16),
          _buildLanguageOption('Swahili', 'sw'),
          const SizedBox(height: 16),
          _buildLanguageOption('French', 'fr'),
          const SizedBox(height: 16),
          _buildLanguageOption('Spanish', 'es'),
        ],
      ),
    );
  }

  Widget _buildLanguageOption(String language, String code) {
    return GestureDetector(
      onTap: () {
        setState(() => _selectedLanguage = code);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _selectedLanguage == code ? Colors.green.shade100 : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _selectedLanguage == code ? Colors.green.shade400 : Colors.grey.shade300,
            width: 2,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              language,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: _selectedLanguage == code ? Colors.green.shade700 : Colors.black87,
              ),
            ),
            if (_selectedLanguage == code)
              Icon(Icons.check_circle, color: Colors.green.shade700, size: 24),
          ],
        ),
      ),
    );
  }
}
