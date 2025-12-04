import 'package:flutter/material.dart';

class VoiceModeScreen extends StatefulWidget {
  const VoiceModeScreen({Key? key}) : super(key: key);

  @override
  State<VoiceModeScreen> createState() => _VoiceModeScreenState();
}

class _VoiceModeScreenState extends State<VoiceModeScreen> {
  bool _isListening = false;
  String _transcribedText = '';
  String _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Voice Mode'), elevation: 0),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade400, Colors.blue.shade700],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Icon(Icons.mic, size: 48, color: Colors.white),
                    const SizedBox(height: 16),
                    Text(
                      _isListening ? 'Listening...' : 'Ready to listen',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'Select Language',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _selectedLanguage,
                items: const [
                  DropdownMenuItem(value: 'English', child: Text('English')),
                  DropdownMenuItem(
                    value: 'Kiswahili',
                    child: Text('Kiswahili'),
                  ),
                  DropdownMenuItem(value: 'Kikuyu', child: Text('Kikuyu')),
                  DropdownMenuItem(value: 'Luo', child: Text('Luo')),
                  DropdownMenuItem(value: 'Kalenjin', child: Text('Kalenjin')),
                ],
                onChanged: (value) {
                  setState(() => _selectedLanguage = value ?? 'English');
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              if (_transcribedText.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'You said:',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _transcribedText,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    _isListening = !_isListening;
                    if (!_isListening) {
                      _transcribedText = 'I want to scan my tomato plant...';
                    }
                  });
                },
                icon: Icon(_isListening ? Icons.stop : Icons.mic),
                label: Text(
                  _isListening ? 'Stop Listening' : 'Start Listening',
                ),
              ),
              const SizedBox(height: 16),
              OutlinedButton(
                onPressed: () {
                  setState(() => _transcribedText = '');
                },
                child: const Text('Clear'),
              ),
              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  border: Border.all(color: Colors.blue.shade200),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Voice Commands',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 12),
                    const Text('• "Scan my plant"'),
                    const Text('• "Show my history"'),
                    const Text('• "Disease information"'),
                    const Text('• "Crop calendar"'),
                    const Text('• "Help me"'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
