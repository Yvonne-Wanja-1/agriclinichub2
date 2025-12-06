import 'package:flutter/material.dart';

class ArticlesScreen extends StatelessWidget {
  const ArticlesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final articles = [
      {
        'title': 'Tomato Leaf Disease Management',
        'category': 'Disease Control',
        'icon': Icons.eco,
        'color': Colors.red,
      },
      {
        'title': 'Soil pH and Crop Health',
        'category': 'Soil Management',
        'icon': Icons.grain,
        'color': Colors.brown,
      },
      {
        'title': 'Irrigation Best Practices',
        'category': 'Water Management',
        'icon': Icons.water,
        'color': Colors.blue,
      },
      {
        'title': 'Pest Control Strategies',
        'category': 'Pest Management',
        'icon': Icons.bug_report,
        'color': Colors.orange,
      },
      {
        'title': 'Organic Farming Techniques',
        'category': 'Farming Methods',
        'icon': Icons.eco,
        'color': Colors.green,
      },
      {
        'title': 'Seasonal Crop Planning',
        'category': 'Planning',
        'icon': Icons.calendar_month,
        'color': Colors.purple,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Articles'),
        backgroundColor: Colors.green.shade400,
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFF5F9F5),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: articles.length,
        itemBuilder: (context, index) {
          final article = articles[index];
          return GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Opening: ${article['title']}'),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            child: Card(
              elevation: 2,
              margin: const EdgeInsets.only(bottom: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: article['color'] as Color,
                    width: 2,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: (article['color'] as Color).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          article['icon'] as IconData,
                          color: article['color'] as Color,
                          size: 32,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              article['title'] as String,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: (article['color'] as Color).withOpacity(
                                  0.15,
                                ),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                article['category'] as String,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: article['color'] as Color,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey.shade400,
                        size: 18,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
