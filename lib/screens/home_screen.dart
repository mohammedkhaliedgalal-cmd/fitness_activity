import 'package:flutter/material.dart';

import 'activity_screen.dart';
import 'journey_screen.dart';
import 'map_screen.dart';
import 'my_workouts_screen.dart';

// ==========================================
// 1. DATA MODEL
// ==========================================

class HomeNavigationItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final Widget destination;

  const HomeNavigationItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.destination,
  });
}

// ==========================================
// 2. MAIN SCREEN
// ==========================================

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static final List<HomeNavigationItem> _navigationItems = [
    HomeNavigationItem(
      title: 'Activity',
      subtitle: 'Track your daily activity',
      icon: Icons.directions_walk,
      destination: ActivityScreen(),
    ),
    HomeNavigationItem(
      title: 'My Workouts',
      subtitle: 'View your workouts',
      icon: Icons.fitness_center,
      destination: MyWorkoutsScreen(),
    ),
    HomeNavigationItem(
      title: 'Journey',
      subtitle: 'Follow your fitness journey',
      icon: Icons.flag_outlined,
      destination: JourneyScreen(),
    ),
    HomeNavigationItem(
      title: 'Map',
      subtitle: 'View your activity route',
      icon: Icons.map_outlined,
      destination: MapScreen(),
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
          'Home',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HomeHeaderImage(
              imagePath: 'assets/images/Home.jpg',
            ),
            const SizedBox(height: 18),
            const HomeWelcomeText(
              title: 'Welcome Back!',
              subtitle: 'Keep moving and stay active every day.',
            ),
            const SizedBox(height: 18),
            NavigationCardList(
              items: _navigationItems,
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 3. HOME HEADER IMAGE
// ==========================================

class HomeHeaderImage extends StatelessWidget {
  final String imagePath;

  const HomeHeaderImage({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset(
          imagePath,
          width: 220,
          height: 130,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: 220,
              height: 130,
              decoration: BoxDecoration(
                color: const Color(0xFFF0F1F3),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.home_outlined,
                size: 50,
                color: Colors.grey,
              ),
            );
          },
        ),
      ),
    );
  }
}

// ==========================================
// 4. WELCOME TEXT
// ==========================================

class HomeWelcomeText extends StatelessWidget {
  final String title;
  final String subtitle;

  const HomeWelcomeText({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          subtitle,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}

// ==========================================
// 5. NAVIGATION CARD LIST
// ==========================================

class NavigationCardList extends StatelessWidget {
  final List<HomeNavigationItem> items;

  const NavigationCardList({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      separatorBuilder: (context, index) {
        return const SizedBox(height: 11);
      },
      itemBuilder: (context, index) {
        return HomeNavigationCard(
          item: items[index],
        );
      },
    );
  }
}

// ==========================================
// 6. NAVIGATION CARD
// ==========================================

class HomeNavigationCard extends StatelessWidget {
  final HomeNavigationItem item;

  const HomeNavigationCard({
    super.key,
    required this.item,
  });

  void _navigateToDestination(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => item.destination,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {
          _navigateToDestination(context);
        },
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F1F3),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Icon(
                  item.icon,
                  size: 24,
                  color: Colors.black,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      item.subtitle,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                size: 15,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}