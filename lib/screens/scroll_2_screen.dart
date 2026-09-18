import 'package:flutter/material.dart';

class ProgressItem {
  final String title;
  final String value;
  final String goal;
  final double progress;
  final IconData icon;

  const ProgressItem({
    required this.title,
    required this.value,
    required this.goal,
    required this.progress,
    required this.icon,
  });
}

class Scroll2Screen extends StatelessWidget {
  const Scroll2Screen({super.key});

  final List<ProgressItem> progressItems = const [
    ProgressItem(
      title: 'Daily Steps',
      value: '7,850',
      goal: '10,000 steps',
      progress: 0.78,
      icon: Icons.directions_walk,
    ),
    ProgressItem(
      title: 'Calories Burned',
      value: '420 kcal',
      goal: '600 kcal',
      progress: 0.70,
      icon: Icons.local_fire_department,
    ),
    ProgressItem(
      title: 'Workout Time',
      value: '42 min',
      goal: '60 min',
      progress: 0.70,
      icon: Icons.timer_outlined,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Activity Progress',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: progressItems.length + 3,
        itemBuilder: (context, index) {
          if (index == 0) {
            return _buildHeaderImage();
          }

          if (index == 1) {
            return const Padding(
              padding: EdgeInsets.only(top: 26, bottom: 16),
              child: Text(
                'Your Progress',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }

          if (index == progressItems.length + 2) {
            return _buildMotivationCard();
          }

          final itemIndex = index - 2;
          return _ProgressCard(item: progressItems[itemIndex]);
        },
      ),
    );
  }

  Widget _buildHeaderImage() {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset(
          'assets/images/Scroll 2.jpg',
          width: 220,
          height: 130,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: 220,
              height: 130,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.analytics_outlined,
                size: 45,
                color: Colors.grey,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildMotivationCard() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(
        top: 8,
        bottom: 10,
      ),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: const Column(
        children: [
          Text(
            'Keep Going!',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'You are making great progress toward your daily goals.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProgressCard extends StatelessWidget {
  final ProgressItem item;

  const _ProgressCard({
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 23,
                backgroundColor: const Color(0xFFF0F1F3),
                foregroundColor: Colors.black,
                child: Icon(item.icon),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.value,
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                item.goal,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: item.progress,
              minHeight: 9,
              backgroundColor: const Color(0xFFEFEFEF),
              valueColor: const AlwaysStoppedAnimation<Color>(
                Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}