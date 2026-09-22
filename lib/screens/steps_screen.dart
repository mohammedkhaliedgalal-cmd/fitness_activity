import 'package:flutter/material.dart';

class StepsScreen extends StatefulWidget {
  const StepsScreen({
    super.key,
    this.initialSteps = 8426,
    this.goalSteps = 10000,
  });

  final int initialSteps;
  final int goalSteps;

  @override
  State<StepsScreen> createState() => _StepsScreenState();
}

class _StepsScreenState extends State<StepsScreen> {
  late int currentSteps;

  @override
  void initState() {
    super.initState();
    currentSteps = widget.initialSteps;
  }

  double get progress {
    if (widget.goalSteps <= 0) {
      return 0;
    }

    return (currentSteps / widget.goalSteps).clamp(0.0, 1.0);
  }

  int get percentage {
    return (progress * 100).round();
  }

  double get distanceKm {
    return currentSteps * 0.000688;
  }

  int get caloriesKcal {
    return (currentSteps * 0.0384).round();
  }

  void addSteps() {
    setState(() {
      currentSteps += 100;
    });
  }

  void removeSteps() {
    setState(() {
      currentSteps = (currentSteps - 100).clamp(0, 999999);
    });
  }

  void resetSteps() {
    setState(() {
      currentSteps = widget.initialSteps;
    });
  }

  String formatNumber(int number) {
    return number.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (match) => '${match[1]},',
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        title: const Text(
          'Steps',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: resetSteps,
            tooltip: 'Reset',
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // IMAGE
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/images/Stats Scroll.jpg',
                  width: 220,
                  height: 130,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 220,
                      height: 130,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(
                        Icons.directions_walk,
                        size: 50,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              "Today's Steps",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            // STEP COUNTER
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.directions_walk,
                    size: 45,
                    color: Colors.black,
                  ),

                  const SizedBox(height: 12),

                  Text(
                    formatNumber(currentSteps),
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  const Text(
                    'Steps',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // + / -
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _controlButton(
                        icon: Icons.remove,
                        onPressed: currentSteps > 0
                            ? removeSteps
                            : null,
                      ),
                      const SizedBox(width: 15),
                      _controlButton(
                        icon: Icons.add,
                        onPressed: addSteps,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // DISTANCE + CALORIES
            Row(
              children: [
                Expanded(
                  child: _infoCard(
                    title: 'Distance',
                    value: '${distanceKm.toStringAsFixed(1)} km',
                    icon: Icons.route,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _infoCard(
                    title: 'Calories',
                    value: '$caloriesKcal kcal',
                    icon: Icons.local_fire_department,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            const Text(
              'Daily Goal',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            // PROGRESS
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${formatNumber(currentSteps)} / ${formatNumber(widget.goalSteps)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        '$percentage%',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 10,
                      backgroundColor:
                          const Color(0xFFF0F1F3),
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(
                        Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Center(
              child: Text(
                currentSteps >= widget.goalSteps
                    ? '🎉 Daily goal completed!'
                    : '${formatNumber(widget.goalSteps - currentSteps)} steps left to reach your goal',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: currentSteps >= widget.goalSteps
                      ? Colors.black
                      : Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // CONTROL BUTTON
  Widget _controlButton({
    required IconData icon,
    required VoidCallback? onPressed,
  }) {
    return Material(
      color: const Color(0xFFF0F1F3),
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(14),
        child: SizedBox(
          width: 52,
          height: 48,
          child: Icon(
            icon,
            size: 24,
            color: onPressed == null
                ? Colors.grey
                : Colors.black,
          ),
        ),
      ),
    );
  }

  // INFO CARD
  Widget _infoCard({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
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
        children: [
          Icon(
            icon,
            size: 28,
            color: Colors.black,
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
        ],
      ),
    );
  }
}
