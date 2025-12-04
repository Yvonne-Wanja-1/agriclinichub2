import 'package:flutter/material.dart';

class EducationScreen extends StatefulWidget {
  const EducationScreen({Key? key}) : super(key: key);

  @override
  State<EducationScreen> createState() => _EducationScreenState();
}

class _EducationScreenState extends State<EducationScreen> {
  String _selectedCategory = 'All';
  String _searchQuery = '';

  final List<String> _categories = [
    'All',
    'Pest Management',
    'Crop Care',
    'Soil Health',
    'Water Management',
    'Harvesting',
  ];

  final List<Map<String, dynamic>> _articles = [
    {
      'id': 1,
      'title': 'Managing Fall Armyworm in Maize',
      'category': 'Pest Management',
      'excerpt': 'Learn effective strategies to control fall armyworm...',
      'content':
          'Fall armyworm is a major pest affecting maize crops. Early detection is key...',
      'icon': Icons.bug_report,
      'color': Colors.red,
      'isBookmarked': false,
    },
    {
      'id': 2,
      'title': 'Proper Watering Techniques',
      'category': 'Water Management',
      'excerpt': 'Master the art of watering your crops efficiently...',
      'content':
          'Proper watering is essential for crop growth. Water should be applied...',
      'icon': Icons.water_drop,
      'color': Colors.blue,
      'isBookmarked': true,
    },
    {
      'id': 3,
      'title': 'Soil Preparation for Tomato Farming',
      'category': 'Soil Health',
      'excerpt': 'Prepare your soil for optimal tomato growth...',
      'content':
          'Tomatoes require well-draining soil rich in organic matter...',
      'icon': Icons.grass,
      'color': Colors.brown,
      'isBookmarked': false,
    },
    {
      'id': 4,
      'title': 'Organic Pest Control Methods',
      'category': 'Pest Management',
      'excerpt': 'Explore organic ways to protect your crops...',
      'content': 'Organic pest control uses natural predators and materials...',
      'icon': Icons.eco,
      'color': Colors.green,
      'isBookmarked': false,
    },
    {
      'id': 5,
      'title': 'Harvesting at the Right Time',
      'category': 'Harvesting',
      'excerpt': 'Know when to harvest for maximum yield...',
      'content':
          'Timing is crucial for harvest. Different crops have different...',
      'icon': Icons.grain,
      'color': Colors.orange,
      'isBookmarked': false,
    },
    {
      'id': 6,
      'title': 'Composting for Better Soil',
      'category': 'Soil Health',
      'excerpt': 'Create nutrient-rich compost for your farm...',
      'content':
          'Composting converts organic waste into valuable fertilizer...',
      'icon': Icons.compost,
      'color': Colors.amber,
      'isBookmarked': true,
    },
  ];

  List<Map<String, dynamic>> get _filteredArticles {
    return _articles.where((article) {
      final matchesCategory =
          _selectedCategory == 'All' ||
          article['category'] == _selectedCategory;
      final matchesSearch = article['title'].toLowerCase().contains(
        _searchQuery.toLowerCase(),
      );
      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Education'),
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
          child: Column(
            children: [
              // Search Bar
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  onChanged: (value) {
                    setState(() => _searchQuery = value);
                  },
                  decoration: InputDecoration(
                    hintText: 'Search articles...',
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.green.shade600,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade300),
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
                  ),
                ),
              ),

              // Category Filter
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SizedBox(
                  height: 45,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _categories.length,
                    itemBuilder: (context, index) {
                      final category = _categories[index];
                      final isSelected = _selectedCategory == category;
                      return Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: FilterChip(
                          label: Text(category),
                          selected: isSelected,
                          onSelected: (value) {
                            setState(() => _selectedCategory = category);
                          },
                          backgroundColor: Colors.white,
                          selectedColor: Colors.green.shade600,
                          labelStyle: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : Colors.grey.shade700,
                            fontWeight: FontWeight.w600,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(
                              color: isSelected
                                  ? Colors.green.shade600
                                  : Colors.grey.shade300,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 15),

              // Articles List
              Expanded(
                child: _filteredArticles.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.article,
                              size: 80,
                              color: Colors.grey.shade300,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'No articles found',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        itemCount: _filteredArticles.length,
                        itemBuilder: (context, index) {
                          final article = _filteredArticles[index];
                          return _buildArticleCard(article, index);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildArticleCard(Map<String, dynamic> article, int index) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Opening: ${article['title']}'),
            duration: const Duration(seconds: 2),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with icon and category
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: (article['color'] as Color).withOpacity(0.1),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: article['color'] as Color,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      article['icon'] as IconData,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          article['category'] as String,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          article['title'] as String,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      article['isBookmarked']
                          ? Icons.bookmark
                          : Icons.bookmark_border,
                      color: article['isBookmarked']
                          ? Colors.amber
                          : Colors.grey.shade400,
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            article['isBookmarked']
                                ? 'Removed from bookmarks'
                                : 'Added to bookmarks',
                          ),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article['excerpt'] as String,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade700,
                      height: 1.5,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 14,
                        color: Colors.grey.shade500,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '${(index + 1) * 5} min read',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const Spacer(),
                      TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.arrow_forward, size: 16),
                        label: const Text('Read More'),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.green.shade600,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
