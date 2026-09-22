import 'package:flutter/material.dart';

// ==========================================
// 1. DATA MODEL
// ==========================================

class FitnessFeature {
  final String title;
  final String subtitle;
  final IconData icon;

  const FitnessFeature({
    required this.title,
    required this.subtitle,
    required this.icon,
  });
}

// ==========================================
// 2. MAIN SCREEN
// ==========================================

class FitnessOverviewScreen extends StatelessWidget {
  const FitnessOverviewScreen({super.key});

  static const List<FitnessFeature> _features = [
    FitnessFeature(
      title: 'Track Your Activity',
      subtitle: 'Keep track of your daily fitness activity.',
      icon: Icons.track_changes_outlined,
    ),
    FitnessFeature(
      title: 'Set Your Goals',
      subtitle: 'Create goals and stay motivated.',
      icon: Icons.flag_outlined,
    ),
    FitnessFeature(
      title: 'Follow Your Progress',
      subtitle: 'See how much you have improved.',
      icon: Icons.show_chart,
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
          'Fitness Overview',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const HeaderImage(
              imagePath: 'assets/images/Frame 3.jpg',
            ),
            const SizedBox(height: 28),
            const HeaderTitleSection(
              title: 'Your Fitness Journey',
              subtitle:
                  'Stay active, track your progress, and reach your fitness goals.',
            ),
            const SizedBox(height: 26),
            const FeatureList(
              features: _features,
            ),
            const SizedBox(height: 8),
            GetStartedButton(
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 3. HEADER IMAGE
// ==========================================

class HeaderImage extends StatelessWidget {
  final String imagePath;

  const HeaderImage({
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
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: 220,
              height: 130,
              decoration: BoxDecoration(
                color: const Color(0xFFF0F1F3),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.fitness_center,
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
// 4. HEADER TITLE SECTION
// ==========================================

class HeaderTitleSection extends StatelessWidget {
  final String title;
  final String subtitle;

  const HeaderTitleSection({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}

// ==========================================
// 5. FEATURE LIST
// ==========================================

class FeatureList extends StatelessWidget {
  final List<FitnessFeature> features;

  const FeatureList({
    super.key,
    required this.features,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: features.length,
      separatorBuilder: (context, index) {
        return const SizedBox(height: 12);
      },
      itemBuilder: (context, index) {
        return FeatureCard(
          feature: features[index],
        );
      },
    );
  }
}

// ==========================================
// 6. FEATURE CARD
// ==========================================

class FeatureCard extends StatelessWidget {
  final FitnessFeature feature;

  const FeatureCard({
    super.key,
    required this.feature,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: const Color(0xFFF0F2F5),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(
              feature.icon,
              size: 27,
              color: Colors.black,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  feature.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  feature.subtitle,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// 7. GET STARTED BUTTON
// ==========================================

class GetStartedButton extends StatelessWidget {
  final VoidCallback onPressed;

  const GetStartedButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: onPressed,
        child: const Text(
          'GET STARTED',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}