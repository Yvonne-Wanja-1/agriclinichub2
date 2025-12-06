import 'package:flutter/material.dart';

class ScanHistoryScreen extends StatefulWidget {
  const ScanHistoryScreen({Key? key}) : super(key: key);

  @override
  State<ScanHistoryScreen> createState() => _ScanHistoryScreenState();
}

class _ScanHistoryScreenState extends State<ScanHistoryScreen> {
  late TextEditingController _searchController;
  String _selectedFilter = 'All';
  bool _showFilters = false;

  final List<Map<String, dynamic>> _scans = [
    {
      'date': 'Dec 3, 2025',
      'crop': 'Tomato',
      'status': 'Healthy',
      'statusColor': Colors.green,
      'confidence': 98,
      'cropIcon': Icons.local_florist,
    },
    {
      'date': 'Dec 1, 2025',
      'crop': 'Maize',
      'status': 'Early Blight',
      'statusColor': Colors.orange,
      'confidence': 85,
      'cropIcon': Icons.grass,
    },
    {
      'date': 'Nov 28, 2025',
      'crop': 'Potato',
      'status': 'Healthy',
      'statusColor': Colors.green,
      'confidence': 94,
      'cropIcon': Icons.agriculture,
    },
    {
      'date': 'Nov 25, 2025',
      'crop': 'Rice',
      'status': 'Leaf Spot',
      'statusColor': Colors.red,
      'confidence': 76,
      'cropIcon': Icons.grass,
    },
    {
      'date': 'Nov 22, 2025',
      'crop': 'Pepper',
      'status': 'Healthy',
      'statusColor': Colors.green,
      'confidence': 92,
      'cropIcon': Icons.local_florist,
    },
  ];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filteredScans {
    return _scans.where((scan) {
      final matchesSearch = scan['crop'].toString().toLowerCase().contains(
        _searchController.text.toLowerCase(),
      );
      final matchesFilter =
          _selectedFilter == 'All' ||
          scan['status'].toString().contains(_selectedFilter);
      return matchesSearch && matchesFilter;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan History'),
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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                // Statistics Header
                _buildStatisticsSection(),
                const SizedBox(height: 24),

                // Search Bar
                _buildSearchBar(),
                const SizedBox(height: 16),

                // Filter & Sort Controls
                _buildFilterControls(),
                const SizedBox(height: 16),

                // Scan Items List or Empty State
                if (_filteredScans.isEmpty)
                  _buildEmptyState()
                else
                  Column(
                    children: [
                      Text(
                        'Your Plant Scans',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade700,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ...List.generate(_filteredScans.length, (index) {
                        final scan = _filteredScans[index];
                        return Column(
                          children: [
                            _buildScanItem(
                              context,
                              date: scan['date'],
                              crop: scan['crop'],
                              status: scan['status'],
                              statusColor: scan['statusColor'],
                              confidence: scan['confidence'],
                              cropIcon: scan['cropIcon'],
                            ),
                            if (index < _filteredScans.length - 1)
                              const SizedBox(height: 12),
                          ],
                        );
                      }),
                    ],
                  ),
                const SizedBox(height: 32),

                // Scan New Plant Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/scan');
                    },
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('Scan New Plant'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade600,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 5,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatisticsSection() {
    final totalScans = _scans.length;
    final healthyScans = _scans.where((s) => s['status'] == 'Healthy').length;
    final diseased = totalScans - healthyScans;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(
            Icons.camera_alt,
            totalScans.toString(),
            'Total Scans',
            Colors.blue,
          ),
          _buildStatItem(
            Icons.check_circle,
            healthyScans.toString(),
            'Healthy',
            Colors.green,
          ),
          _buildStatItem(
            Icons.warning_rounded,
            diseased.toString(),
            'Diseased',
            Colors.orange,
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
    IconData icon,
    String value,
    String label,
    Color color,
  ) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8),
        ],
      ),
      child: TextField(
        controller: _searchController,
        onChanged: (value) {
          setState(() {});
        },
        decoration: InputDecoration(
          hintText: 'Search scans...',
          hintStyle: TextStyle(color: Colors.grey.shade500),
          prefixIcon: Icon(Icons.search, color: Colors.green.shade600),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    setState(() {});
                  },
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }

  Widget _buildFilterControls() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Filter by Status',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade800,
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _showFilters = !_showFilters;
                });
              },
              child: Icon(
                _showFilters ? Icons.expand_less : Icons.expand_more,
                color: Colors.green.shade600,
              ),
            ),
          ],
        ),
        if (_showFilters) ...[
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: [
              _buildFilterChip('All'),
              _buildFilterChip('Healthy'),
              _buildFilterChip('Blight'),
              _buildFilterChip('Spot'),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildFilterChip(String filter) {
    final isSelected = _selectedFilter == filter;
    return FilterChip(
      label: Text(filter),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _selectedFilter = filter;
        });
      },
      backgroundColor: Colors.white,
      selectedColor: Colors.green.shade100,
      side: BorderSide(
        color: isSelected ? Colors.green.shade600 : Colors.grey.shade300,
      ),
      labelStyle: TextStyle(
        color: isSelected ? Colors.green.shade600 : Colors.grey.shade700,
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(Icons.history, size: 64, color: Colors.green.shade300),
          ),
          const SizedBox(height: 20),
          Text(
            'No scans found',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Start scanning plants to build your history',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey.shade600),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildScanItem(
    BuildContext context, {
    required String date,
    required String crop,
    required String status,
    required Color statusColor,
    required int confidence,
    required IconData cropIcon,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          '/scan-result',
          arguments: {
            'scanData': {
              'crop': crop,
              'status': status,
              'date': date,
              'confidence': confidence,
            },
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            // Top Row: Icon, Info, and Status
            Row(
              children: [
                // Crop Icon
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(cropIcon, color: statusColor, size: 24),
                ),
                const SizedBox(width: 12),

                // Crop Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        crop,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            size: 14,
                            color: Colors.grey.shade500,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            date,
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Status Badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: statusColor.withOpacity(0.3)),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),

            // Confidence Bar
            const SizedBox(height: 12),
            Row(
              children: [
                Text(
                  'Confidence:',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: confidence / 100,
                      minHeight: 6,
                      backgroundColor: Colors.grey.shade200,
                      valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '$confidence%',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade800,
                  ),
                ),
              ],
            ),

            // Action Buttons
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Shared "$crop" scan!'),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.share,
                      size: 16,
                      color: Colors.blue.shade600,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Deleted "$crop" scan'),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.delete_outline,
                      size: 16,
                      color: Colors.red.shade600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
