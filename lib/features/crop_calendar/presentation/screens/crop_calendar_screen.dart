import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CropCalendarScreen extends StatefulWidget {
  const CropCalendarScreen({Key? key}) : super(key: key);

  @override
  State<CropCalendarScreen> createState() => _CropCalendarScreenState();
}

class _CropCalendarScreenState extends State<CropCalendarScreen> {
  DateTime _selectedMonth = DateTime.now();
  final List<Map<String, dynamic>> _events = [
    {
      'date': DateTime(2024, 12, 5),
      'title': 'Plant Tomatoes',
      'type': 'planting',
      'color': Colors.green,
    },
    {
      'date': DateTime(2024, 12, 10),
      'title': 'Water Plants',
      'type': 'watering',
      'color': Colors.blue,
    },
    {
      'date': DateTime(2024, 12, 15),
      'title': 'Apply Fertilizer',
      'type': 'care',
      'color': Colors.orange,
    },
    {
      'date': DateTime(2024, 12, 20),
      'title': 'Harvest Maize',
      'type': 'harvest',
      'color': Colors.amber,
    },
    {
      'date': DateTime(2024, 12, 25),
      'title': 'Plant Beans',
      'type': 'planting',
      'color': Colors.green,
    },
  ];

  @override
  void initState() {
    super.initState();
    _selectedMonth = DateTime.now();
  }

  List<Map<String, dynamic>> get _upcomingEvents {
    return _events
        .where((event) => event['date'].isAfter(DateTime.now()))
        .toList()
      ..sort((a, b) => a['date'].compareTo(b['date']));
  }

  void _previousMonth() {
    setState(() {
      _selectedMonth = DateTime(_selectedMonth.year, _selectedMonth.month - 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _selectedMonth = DateTime(_selectedMonth.year, _selectedMonth.month + 1);
    });
  }

  void _showEditDialog() {
    final titleController = TextEditingController();
    final descController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add/Edit Event'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: 'Event title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: descController,
                decoration: InputDecoration(
                  hintText: 'Description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Select date',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  suffixIcon: const Icon(Icons.calendar_today),
                ),
                readOnly: true,
                onTap: () async {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2030),
                  );
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Event added successfully!')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green.shade600,
            ),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _openMenu() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Edit Calendar'),
              onTap: () {
                Navigator.pop(context);
                _showEditDialog();
              },
            ),
            ListTile(
              leading: const Icon(Icons.download),
              title: const Text('Download Calendar'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Calendar downloaded!')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.share),
              title: const Text('Share Calendar'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Calendar shared!')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crop Calendar'),
        centerTitle: true,
        backgroundColor: Colors.green.shade600,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.menu), onPressed: _openMenu),
        ],
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Month Navigation
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.chevron_left,
                          color: Colors.green.shade600,
                        ),
                        onPressed: _previousMonth,
                      ),
                      Text(
                        DateFormat('MMMM yyyy').format(_selectedMonth),
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.chevron_right,
                          color: Colors.green.shade600,
                        ),
                        onPressed: _nextMonth,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Edit Calendar Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _showEditDialog,
                      icon: const Icon(Icons.edit),
                      label: const Text('Add Event'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade600,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Calendar Grid
                  _buildCalendarGrid(),
                  const SizedBox(height: 30),

                  // Legend
                  _buildLegend(),
                  const SizedBox(height: 30),

                  // Upcoming Events
                  Text(
                    'Upcoming Events',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  if (_upcomingEvents.isEmpty)
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Text(
                          'No upcoming events',
                          style: TextStyle(color: Colors.black87),
                        ),
                      ),
                    )
                  else
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _upcomingEvents.length,
                      itemBuilder: (context, index) {
                        final event = _upcomingEvents[index];
                        return _buildEventCard(event);
                      },
                    ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCalendarGrid() {
    final firstDay = DateTime(_selectedMonth.year, _selectedMonth.month, 1);
    final lastDay = DateTime(_selectedMonth.year, _selectedMonth.month + 1, 0);
    final daysInMonth = lastDay.day;
    final startingDayOfWeek = firstDay.weekday;

    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          // Day headers
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
                .map(
                  (day) => SizedBox(
                    width: 40,
                    child: Center(
                      child: Text(
                        day,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 10),
          // Calendar days
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 1,
            ),
            itemCount: 42,
            itemBuilder: (context, index) {
              int dayNumber = index - startingDayOfWeek + 2;

              if (dayNumber < 1 || dayNumber > daysInMonth) {
                return Container();
              }

              final date = DateTime(
                _selectedMonth.year,
                _selectedMonth.month,
                dayNumber,
              );
              final hasEvent = _events.any(
                (event) =>
                    event['date'].year == date.year &&
                    event['date'].month == date.month &&
                    event['date'].day == date.day,
              );
              final isToday =
                  date.year == DateTime.now().year &&
                  date.month == DateTime.now().month &&
                  date.day == DateTime.now().day;

              return Container(
                margin: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: isToday ? Colors.green.shade600 : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: hasEvent
                      ? Border.all(color: Colors.green.shade400, width: 2)
                      : Border.all(color: Colors.grey.shade200),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Text(
                        '$dayNumber',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isToday ? Colors.white : Colors.black87,
                        ),
                      ),
                    ),
                    if (hasEvent)
                      Positioned(
                        bottom: 4,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: Colors.green.shade600,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLegend() {
    final eventTypes = [
      {'type': 'planting', 'label': 'Planting', 'color': Colors.green},
      {'type': 'watering', 'label': 'Watering', 'color': Colors.blue},
      {'type': 'care', 'label': 'Care', 'color': Colors.orange},
      {'type': 'harvest', 'label': 'Harvest', 'color': Colors.amber},
    ];

    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Event Types',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 15,
            runSpacing: 10,
            children: eventTypes.map((type) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: type['color'] as Color,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    type['label'] as String,
                    style: const TextStyle(fontSize: 13, color: Colors.black87),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildEventCard(Map<String, dynamic> event) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: (event['color'] as Color).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: (event['color'] as Color).withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: event['color'] as Color,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              _getEventIcon(event['type']),
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event['title'] as String,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  DateFormat('MMM dd, yyyy').format(event['date'] as DateTime),
                  style: const TextStyle(fontSize: 12, color: Colors.black87),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData _getEventIcon(String type) {
    switch (type) {
      case 'planting':
        return Icons.local_florist;
      case 'watering':
        return Icons.water_drop;
      case 'harvest':
        return Icons.grain;
      default:
        return Icons.spa;
    }
  }
}
