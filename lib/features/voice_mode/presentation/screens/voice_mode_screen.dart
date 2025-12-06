import 'package:flutter/material.dart';

class VoiceModeScreen extends StatefulWidget {
  const VoiceModeScreen({Key? key}) : super(key: key);

  @override
  State<VoiceModeScreen> createState() => _VoiceModeScreenState();
}

class _VoiceModeScreenState extends State<VoiceModeScreen> {
  bool _isListening = false;
  bool _isProcessing = false;
  String _transcribedText = '';
  String _responseText = '';
  String _selectedLanguage = 'English';

  Future<void> _startListening() async {
    setState(() => _isListening = true);
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      setState(() {
        _isListening = false;
        _isProcessing = true;
        _transcribedText = 'Scan my tomato plant for diseases';
      });
    }
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      setState(() {
        _isProcessing = false;
        _responseText = 'Okay, opening the disease detection camera...';
      });
    }
  }

  void _clearAll() {
    setState(() {
      _transcribedText = '';
      _responseText = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Voice Mode'),
        centerTitle: true,
        backgroundColor: Colors.green.shade600,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.green.shade50, Colors.white],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),

                  // Language Selection
                  Text(
                    'Select Language:',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    value: _selectedLanguage,
                    items: [
                      DropdownMenuItem(
                        value: 'English',
                        child: Text(
                          'English',
                          style: TextStyle(color: Colors.green.shade600),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'Kiswahili',
                        child: Text(
                          'Kiswahili',
                          style: TextStyle(color: Colors.green.shade600),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'Kikuyu',
                        child: Text(
                          'Kikuyu',
                          style: TextStyle(color: Colors.green.shade600),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'Luo',
                        child: Text(
                          'Luo',
                          style: TextStyle(color: Colors.green.shade600),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'Kalenjin',
                        child: Text(
                          'Kalenjin',
                          style: TextStyle(color: Colors.green.shade600),
                        ),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() => _selectedLanguage = value ?? 'English');
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.black87),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.black87),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.green.shade600,
                          width: 2,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      suffixIcon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.green.shade600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Microphone Button
                  Center(
                    child: GestureDetector(
                      onTap: _isListening || _isProcessing
                          ? null
                          : _startListening,
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: _isListening
                                ? [Colors.red.shade400, Colors.red.shade700]
                                : [
                                    Colors.green.shade400,
                                    Colors.green.shade700,
                                  ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: (_isListening ? Colors.red : Colors.green)
                                  .withOpacity(0.3),
                              blurRadius: 15,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Icon(Icons.mic, size: 60, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Center(
                    child: Text(
                      _isListening
                          ? 'Listening...'
                          : _isProcessing
                          ? 'Processing...'
                          : 'Tap to start',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Transcription Display
                  if (_transcribedText.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.blue.shade200),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.mic_none,
                                size: 16,
                                color: Colors.blue.shade600,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'You said:',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.blue.shade700,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            _transcribedText,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 20),

                  // Response Display
                  if (_responseText.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.green.shade200),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.info,
                                size: 16,
                                color: Colors.green.shade600,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Response:',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.green.shade700,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            _responseText,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 30),

                  // Action Buttons
                  if (_transcribedText.isNotEmpty || _responseText.isNotEmpty)
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton.icon(
                        onPressed: _clearAll,
                        icon: const Icon(Icons.clear),
                        label: const Text('Clear'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange.shade600,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(height: 30),

                  // Voice Commands Suggestions
                  Text(
                    'Voice Command Suggestions',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade600,
                    ),
                  ),
                  const SizedBox(height: 15),
                  _buildCommandCard('Scan my plant', 'Opens disease detection'),
                  const SizedBox(height: 10),
                  _buildCommandCard('Show my history', 'Views scan history'),
                  const SizedBox(height: 10),
                  _buildCommandCard('Crop calendar', 'Opens crop calendar'),
                  const SizedBox(height: 10),
                  _buildCommandCard('Read articles', 'Opens education section'),
                  const SizedBox(height: 10),
                  _buildCommandCard('Farm profile', 'Shows your profile'),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCommandCard(String command, String description) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.green.shade200),
      ),
      child: Row(
        children: [
          Icon(Icons.volume_up, size: 18, color: Colors.green.shade600),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '"$command"',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(fontSize: 11, color: Colors.black87),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
