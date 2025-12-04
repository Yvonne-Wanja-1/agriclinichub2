import 'package:flutter/material.dart';

class EducationScreen extends StatefulWidget {
  const EducationScreen({Key? key}) : super(key: key);

  @override
  State<EducationScreen> createState() => _EducationScreenState();
}

class _EducationScreenState extends State<EducationScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Learn & Train'),
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Articles'),
            Tab(text: 'Videos'),
            Tab(text: 'Guides'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildArticlesList(),
          _buildVideosList(),
          _buildGuidesList(),
        ],
      ),
    );
  }

  Widget _buildArticlesList() {
    final articles = [
      {
        'title': 'Understanding Plant Diseases',
        'excerpt': 'Learn how to identify and manage common plant diseases...',
        'author': 'Dr. Jane Kimani',
        'date': 'Dec 1, 2025',
      },
      {
        'title': 'Soil Health Management',
        'excerpt':
            'Tips for maintaining healthy soil for better crop yields...',
        'author': 'Prof. John Kipchoge',
        'date': 'Nov 25, 2025',
      },
      {
        'title': 'Water Conservation Techniques',
        'excerpt': 'Efficient irrigation methods for dry seasons...',
        'author': 'Dr. Mary Mwai',
        'date': 'Nov 20, 2025',
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: articles.length,
      itemBuilder: (context, index) {
        final article = articles[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                article['title']!,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                article['excerpt']!,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    article['author']!,
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                  Text(
                    article['date']!,
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: () {},
                child: Text(
                  'Read More →',
                  style: TextStyle(
                    color: Colors.green.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildVideosList() {
    final videos = [
      {'title': 'Tomato Disease Management', 'duration': '12:45'},
      {'title': 'Maize Planting Guide', 'duration': '8:20'},
      {'title': 'Pest Control Methods', 'duration': '15:30'},
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: videos.length,
      itemBuilder: (context, index) {
        final video = videos[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(12),
          ),
          clipBehavior: Clip.hardEdge,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 180,
                color: Colors.grey.shade300,
                child: Center(
                  child: Icon(
                    Icons.play_circle_outline,
                    size: 64,
                    color: Colors.green.shade700,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      video['title']!,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Duration: ${video['duration']}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildGuidesList() {
    final guides = [
      'Getting Started with Agri Clinic Hub',
      'Setting Up Your Farm Profile',
      'Understanding Disease Scan Results',
      'Using Voice Mode',
      'Offline Mode Guide',
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: guides.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  guides[index],
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              Icon(Icons.arrow_forward, color: Colors.green.shade700),
            ],
          ),
        );
      },
    );
  }
}
