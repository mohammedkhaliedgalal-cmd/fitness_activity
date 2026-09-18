import 'package:flutter/material.dart';

class RewardScreen extends StatefulWidget {
  const RewardScreen({super.key});

  @override
  State<RewardScreen> createState() => _RewardScreenState();
}

class _RewardScreenState extends State<RewardScreen> {
  bool rewardClaimed = false;

  void showRewardDetails({
    required String title,
    required String description,
    required IconData icon,
    bool canClaim = false,
  }) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(
                icon,
                size: 28,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(title),
              ),
            ],
          ),
          content: Text(
            description,
            style: const TextStyle(
              color: Colors.grey,
              height: 1.5,
            ),
          ),
          actions: [
            if (canClaim && !rewardClaimed)
              TextButton(
                onPressed: () {
                  setState(() {
                    rewardClaimed = true;
                  });

                  Navigator.of(dialogContext).pop();

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Reward claimed successfully!',
                      ),
                    ),
                  );
                },
                child: const Text('CLAIM REWARD'),
              ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text('CLOSE'),
            ),
          ],
        );
      },
    );
  }

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
          'Rewards',
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
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  'assets/images/Reward.jpg',
                  width: 220,
                  height: 130,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 220,
                      height: 130,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(
                        Icons.image_not_supported_outlined,
                        size: 45,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 18),

            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  'assets/images/Reward Scroll.jpg',
                  width: 220,
                  height: 130,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 220,
                      height: 130,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(
                        Icons.image_not_supported_outlined,
                        size: 45,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 28),

            const Text(
              'Your Rewards',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Keep working out and collect more rewards.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 24),

            InkWell(
              onTap: () {
                showRewardDetails(
                  title: 'Fitness Champion',
                  description:
                      'Complete 10 workouts to unlock this reward. You are currently at 7 out of 10 workouts.',
                  icon: Icons.emoji_events_outlined,
                  canClaim: false,
                );
              },
              borderRadius: BorderRadius.circular(18),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.emoji_events_outlined,
                      size: 50,
                    ),

                    const SizedBox(height: 12),

                    const Text(
                      'Fitness Champion',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      'Complete 10 workouts to unlock this reward.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),

                    const SizedBox(height: 18),

                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: const LinearProgressIndicator(
                        value: 0.7,
                        minHeight: 10,
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '7 / 10 workouts',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: OutlinedButton(
                        onPressed: () {
                          showRewardDetails(
                            title: 'Fitness Champion',
                            description:
                                'Complete 10 workouts to unlock this reward. You are currently at 7 out of 10 workouts.',
                            icon: Icons.emoji_events_outlined,
                            canClaim: false,
                          );
                        },
                        child: const Text(
                          'VIEW REWARD',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 18),

            InkWell(
              onTap: () {
                showRewardDetails(
                  title: '7 Day Streak',
                  description:
                      'You have maintained your workout streak for 7 days. Keep training every day to continue your streak!',
                  icon: Icons.local_fire_department_outlined,
                );
              },
              borderRadius: BorderRadius.circular(18),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.local_fire_department_outlined,
                      size: 42,
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      '7 Day Streak',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 6),

                    const Text(
                      'Keep your workout streak going!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),

                    const SizedBox(height: 15),

                    SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: OutlinedButton(
                        onPressed: () {
                          showRewardDetails(
                            title: '7 Day Streak',
                            description:
                                'You have maintained your workout streak for 7 days. Keep training every day to continue your streak!',
                            icon: Icons.local_fire_department_outlined,
                          );
                        },
                        child: const Text(
                          'VIEW STREAK',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 18),

            if (rewardClaimed)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      size: 28,
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Fitness Champion reward claimed!',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}