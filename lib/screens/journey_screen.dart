import 'package:flutter/material.dart';

// ==========================================
// 1. DATA MODEL
// ==========================================

class JourneyStepItem {
  final IconData icon;
  final String title;
  final String description;
  final bool isCompleted;

  const JourneyStepItem({
    required this.icon,
    required this.title,
    required this.description,
    this.isCompleted = false,
  });

  JourneyStepItem copyWith({
    bool? isCompleted,
  }) {
    return JourneyStepItem(
      icon: icon,
      title: title,
      description: description,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}

// ==========================================
// 2. MAIN SCREEN
// ==========================================

class JourneyScreen extends StatefulWidget {
  const JourneyScreen({super.key});

  @override
  State<JourneyScreen> createState() => _JourneyScreenState();
}

class _JourneyScreenState extends State<JourneyScreen> {
  List<JourneyStepItem> _steps = const [
    JourneyStepItem(
      icon: Icons.flag_outlined,
      title: 'Started',
      description: 'You started your fitness journey.',
      isCompleted: true,
    ),
    JourneyStepItem(
      icon: Icons.directions_walk,
      title: 'First Goal',
      description: 'You completed your first activity goal.',
      isCompleted: true,
    ),
    JourneyStepItem(
      icon: Icons.fitness_center,
      title: 'Workout',
      description: 'Complete your workout to unlock this step.',
      isCompleted: false,
    ),
    JourneyStepItem(
      icon: Icons.emoji_events_outlined,
      title: 'Achievement',
      description: 'Keep going to unlock more achievements.',
      isCompleted: false,
    ),
  ];

  int get _completedCount {
    return _steps.where((step) => step.isCompleted).length;
  }

  double get _progress {
    return _steps.isEmpty ? 0 : _completedCount / _steps.length;
  }

  void _toggleStepCompletion(int index) {
    setState(() {
      final updatedSteps = List<JourneyStepItem>.from(_steps);

      updatedSteps[index] = updatedSteps[index].copyWith(
        isCompleted: !updatedSteps[index].isCompleted,
      );

      _steps = updatedSteps;
    });
  }

  void _goBack(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        title: const Text(
          'Journey',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            // Journey Image
            const HeaderImage(
              imagePath: 'assets/images/Jounery.jpg',
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeaderTitleSection(
                    title: 'Your Fitness Journey',
                    description:
                        'Keep going, stay active, and track your progress throughout your fitness journey.',
                  ),

                  const SizedBox(height: 25),

                  ProgressBarCard(
                    progress: _progress,
                    completedCount: _completedCount,
                    totalCount: _steps.length,
                  ),

                  const SizedBox(height: 25),

                  const Text(
                    'Journey Steps',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  JourneyStepList(
                    steps: _steps,
                    onStepToggled: _toggleStepCompletion,
                  ),

                  const SizedBox(height: 10),

                  BackButtonSection(
                    onPressed: () => _goBack(context),
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
        borderRadius: BorderRadius.circular(20),
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
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.flag_outlined,
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
  final String description;

  const HeaderTitleSection({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          description,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 15,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}

// ==========================================
// 5. PROGRESS BAR CARD
// ==========================================

class ProgressBarCard extends StatelessWidget {
  final double progress;
  final int completedCount;
  final int totalCount;

  const ProgressBarCard({
    super.key,
    required this.progress,
    required this.completedCount,
    required this.totalCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Your Progress',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${(progress * 100).round()}%',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 10,
              backgroundColor: const Color(0xFFE8E9EC),
              valueColor: const AlwaysStoppedAnimation<Color>(
                Colors.black,
              ),
            ),
          ),

          const SizedBox(height: 10),

          Text(
            '$completedCount of $totalCount goals completed',
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// 6. JOURNEY STEP LIST
// ==========================================

class JourneyStepList extends StatelessWidget {
  final List<JourneyStepItem> steps;
  final ValueChanged<int> onStepToggled;

  const JourneyStepList({
    super.key,
    required this.steps,
    required this.onStepToggled,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: steps.length,
      separatorBuilder: (context, index) {
        return const SizedBox(height: 12);
      },
      itemBuilder: (context, index) {
        return JourneyStepCard(
          step: steps[index],
          onTap: () {
            onStepToggled(index);
          },
        );
      },
    );
  }
}

// ==========================================
// 7. JOURNEY STEP CARD
// ==========================================

class JourneyStepCard extends StatelessWidget {
  final JourneyStepItem step;
  final VoidCallback onTap;

  const JourneyStepCard({
    super.key,
    required this.step,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: step.isCompleted
                      ? Colors.black
                      : const Color(0xFFF0F1F3),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(
                  step.icon,
                  color: step.isCompleted
                      ? Colors.white
                      : Colors.black,
                  size: 26,
                ),
              ),

              const SizedBox(width: 15),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      step.title,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: step.isCompleted
                            ? Colors.black
                            : Colors.grey.shade800,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      step.description,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              Icon(
                step.isCompleted
                    ? Icons.check_circle
                    : Icons.radio_button_unchecked,
                color: step.isCompleted
                    ? Colors.green
                    : Colors.grey,
                size: 23,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==========================================
// 8. BACK BUTTON
// ==========================================

class BackButtonSection extends StatelessWidget {
  final VoidCallback onPressed;

  const BackButtonSection({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.black,
          side: const BorderSide(
            color: Colors.black,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: const Text(
          'BACK',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}