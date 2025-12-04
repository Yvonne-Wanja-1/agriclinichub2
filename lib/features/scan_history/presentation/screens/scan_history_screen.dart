import 'package:flutter/material.dart';

class ScanHistoryScreen extends StatefulWidget {
  const ScanHistoryScreen({Key? key}) : super(key: key);

  @override
  State<ScanHistoryScreen> createState() => _ScanHistoryScreenState();
}

class _ScanHistoryScreenState extends State<ScanHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan History'), elevation: 0),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Text(
                'Your Plant Scans',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              _buildScanItem(
                context,
                date: 'Dec 3, 2025',
                crop: 'Tomato',
                status: 'Healthy',
                statusColor: Colors.green,
              ),
              const SizedBox(height: 12),
              _buildScanItem(
                context,
                date: 'Dec 1, 2025',
                crop: 'Maize',
                status: 'Early Blight',
                statusColor: Colors.orange,
              ),
              const SizedBox(height: 12),
              _buildScanItem(
                context,
                date: 'Nov 28, 2025',
                crop: 'Potato',
                status: 'Healthy',
                statusColor: Colors.green,
              ),
              const SizedBox(height: 32),
              Center(
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/scan');
                  },
                  child: const Text('Scan New Plant'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScanItem(
    BuildContext context, {
    required String date,
    required String crop,
    required String status,
    required Color statusColor,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          '/scan-result',
          arguments: {
            'scanData': {'crop': crop, 'status': status, 'date': date},
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(crop, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 4),
                Text(date, style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                status,
                style: TextStyle(
                  color: statusColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
