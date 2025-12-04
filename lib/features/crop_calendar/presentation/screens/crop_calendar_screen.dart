import 'package:flutter/material.dart';

class CropCalendarScreen extends StatefulWidget {
  const CropCalendarScreen({Key? key}) : super(key: key);

  @override
  State<CropCalendarScreen> createState() => _CropCalendarScreenState();
}

class _CropCalendarScreenState extends State<CropCalendarScreen> {
  String? selectedCounty = 'Kiambu';

  final List<String> kenyaCounties = [
    'Kiambu',
    'Nairobi',
    'Murang\'a',
    'Kisii',
    'Nakuru',
    'Nyeri',
    'Elgeyo-Marakwet',
    'Nandi',
    'Kericho',
    'Bomet',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crop Calendar'), elevation: 0),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Text(
                'Select Your County',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: selectedCounty,
                items: kenyaCounties
                    .map(
                      (county) =>
                          DropdownMenuItem(value: county, child: Text(county)),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() => selectedCounty = value);
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'Seasonal Guide for $selectedCounty',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              _buildCropCalendarItem(
                context,
                crop: 'Tomato',
                season: 'March - August',
                plantingMonth: 'March - April',
                harvestMonth: 'June - August',
                tips: [
                  'Plant in well-drained soil',
                  'Provide adequate water',
                  'Use stakes for support',
                ],
              ),
              const SizedBox(height: 12),
              _buildCropCalendarItem(
                context,
                crop: 'Maize',
                season: 'April - September',
                plantingMonth: 'April - May',
                harvestMonth: 'September',
                tips: [
                  'Requires good rainfall',
                  'Space plants properly',
                  'Control weeds regularly',
                ],
              ),
              const SizedBox(height: 12),
              _buildCropCalendarItem(
                context,
                crop: 'Beans',
                season: 'March - June',
                plantingMonth: 'March',
                harvestMonth: 'June',
                tips: [
                  'Prefers moderate climate',
                  'Mulch soil for moisture',
                  'Harvest before fully dry',
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCropCalendarItem(
    BuildContext context, {
    required String crop,
    required String season,
    required String plantingMonth,
    required String harvestMonth,
    required List<String> tips,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green.shade200),
        borderRadius: BorderRadius.circular(12),
        color: Colors.green.shade50,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                crop,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.green.shade200,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  season,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.green.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Planting',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      plantingMonth,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Harvest',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      harvestMonth,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text('Tips', style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 8),
          ...tips
              .map(
                (tip) => Padding(
                  padding: const EdgeInsets.only(bottom: 6.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.check_circle_outline,
                        size: 16,
                        color: Colors.green.shade700,
                      ),
                      const SizedBox(width: 8),
                      Expanded(child: Text(tip)),
                    ],
                  ),
                ),
              )
              .toList(),
        ],
      ),
    );
  }
}
