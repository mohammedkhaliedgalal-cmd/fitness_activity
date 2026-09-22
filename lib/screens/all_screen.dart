import 'package:flutter/material.dart';

import 'activity_screen.dart';
import 'duels_screen.dart';
import 'my_workouts_screen.dart';

class AllScreen extends StatelessWidget {
  const AllScreen({super.key});

  void openCategory(
    BuildContext context,
    String title,
  ) {
    Widget screen;

    switch (title) {
      case 'Workouts':
        screen = const MyWorkoutsScreen();
        break;

      case 'Cardio':
        screen = const ActivityScreen();
        break;

      case 'Strength':
        screen = const MyWorkoutsScreen();
        break;

      case 'Yoga':
        screen = const ActivityScreen();
        break;

      case 'Stretching':
        screen = const ActivityScreen();
        break;

      case 'Challenges':
        screen = const DuelsScreen();
        break;

      default:
        return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => screen,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final categories = [
      {
        'title': 'Workouts',
        'subtitle': 'Find your perfect workout',
        'icon': Icons.fitness_center,
      },
      {
        'title': 'Cardio',
        'subtitle': 'Improve your endurance',
        'icon': Icons.directions_run,
      },
      {
        'title': 'Strength',
        'subtitle': 'Build muscle and strength',
        'icon': Icons.fitness_center_outlined,
      },
      {
        'title': 'Yoga',
        'subtitle': 'Relax and improve flexibility',
        'icon': Icons.self_improvement,
      },
      {
        'title': 'Stretching',
        'subtitle': 'Recover and stay flexible',
        'icon': Icons.accessibility_new,
      },
      {
        'title': 'Challenges',
        'subtitle': 'Push yourself further',
        'icon': Icons.emoji_events_outlined,
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        foregroundColor: Colors.black,
        title: const Text(
          'All',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 10),

            // All Image
            Center(
              child: Container(
                width: 220,
                height: 130,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Image.asset(
                    'assets/images/All.jpg',
                    width: 220,
                    height: 130,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Icon(
                          Icons.image_not_supported_outlined,
                          size: 50,
                          color: Colors.grey,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),

            const SizedBox(height: 26),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Explore Everything',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 16),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: categories.length,
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.95,
              ),
              itemBuilder: (context, index) {
                final category = categories[index];

                return InkWell(
                  onTap: () {
                    openCategory(
                      context,
                      category['title'] as String,
                    );
                  },
                  borderRadius: BorderRadius.circular(18),
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.03),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 55,
                          height: 55,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF0F2F5),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Icon(
                            category['icon'] as IconData,
                            size: 28,
                            color: Colors.black,
                          ),
                        ),

                        const SizedBox(height: 12),

                        Text(
                          category['title'] as String,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 6),

                        Text(
                          category['subtitle'] as String,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 11,
                            height: 1.3,
                          ),
                        ),

                        const SizedBox(height: 8),

                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 13,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}