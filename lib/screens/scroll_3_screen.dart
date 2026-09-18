import 'package:flutter/material.dart';

class Achievement {
  final String title;
  final String subtitle;
  final IconData icon;

  const Achievement({
    required this.title,
    required this.subtitle,
    required this.icon,
  });
}

class Scroll3Screen extends StatelessWidget {
  const Scroll3Screen({super.key});

  final List<Achievement> achievements = const [
    Achievement(
      title: 'First Workout',
      subtitle: 'Completed your first workout',
      icon: Icons.fitness_center,
    ),
    Achievement(
      title: '5 Day Streak',
      subtitle: 'Worked out for 5 days in a row',
      icon: Icons.local_fire_department,
    ),
    Achievement(
      title: '10 Workouts',
      subtitle: 'Completed 10 workouts',
      icon: Icons.emoji_events_outlined,
    ),
    Achievement(
      title: 'Step Master',
      subtitle: 'Reached 10,000 steps in a day',
      icon: Icons.directions_walk,
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
          'Achievements',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: achievements.length + 3,
        itemBuilder: (context, index) {
          if (index == 0) {
            return _buildHeaderImage();
          }

          if (index == 1) {
            return const Padding(
              padding: EdgeInsets.only(
                top: 26,
                bottom: 16,
              ),
              child: Text(
                'Your Achievements',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }

          if (index == achievements.length + 2) {
            return _buildFooterCard();
          }

          final achievementIndex = index - 2;

          return _AchievementTile(
            achievement: achievements[achievementIndex],
          );
        },
      ),
    );
  }

  Widget _buildHeaderImage() {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset(
          'assets/images/Scroll 3.jpg',
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
                Icons.emoji_events,
                size: 45,
                color: Colors.grey,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildFooterCard() {
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
          Icon(
            Icons.star_outline,
            size: 42,
          ),
          SizedBox(height: 10),
          Text(
            'Great Job!',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Keep training to unlock more achievements.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

class _AchievementTile extends StatelessWidget {
  final Achievement achievement;

  const _AchievementTile({
    required this.achievement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: const Color(0xFFF0F2F5),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              achievement.icon,
              size: 28,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  achievement.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  achievement.subtitle,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.check_circle,
            size: 24,
          ),
        ],
      ),
    );
  }
}