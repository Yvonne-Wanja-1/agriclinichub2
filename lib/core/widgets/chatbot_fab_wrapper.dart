import 'package:flutter/material.dart';

class ChatbotFABWrapper extends StatelessWidget {
  final Widget child;

  const ChatbotFABWrapper({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned(
          bottom: 80,
          right: 16,
          child: FloatingActionButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Chatbot feature coming soon!'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            backgroundColor: Colors.green.shade600,
            tooltip: 'Chat with AgriBot',
            child: const Icon(Icons.smart_toy),
          ),
        ),
      ],
    );
  }
}
