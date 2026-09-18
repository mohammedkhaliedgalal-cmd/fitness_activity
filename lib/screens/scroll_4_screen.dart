import 'package:flutter/material.dart';

class WeeklyWorkout {
  final String day;
  final String workout;
  final String time;
  final String calories;

  const WeeklyWorkout({
    required this.day,
    required this.workout,
    required this.time,
    required this.calories,
  });
}

class Scroll4Screen extends StatelessWidget {
  const Scroll4Screen({super.key});

  final List<WeeklyWorkout> weeklyData = const [
    WeeklyWorkout(
      day: 'Monday',
      workout: 'Full Body',
      time: '35 min',
      calories: '280 kcal',
    ),
    WeeklyWorkout(
      day: 'Tuesday',
      workout: 'Cardio',
      time: '30 min',
      calories: '320 kcal',
    ),
    WeeklyWorkout(
      day: 'Wednesday',
      workout: 'Strength',
      time: '40 min',
      calories: '350 kcal',
    ),
    WeeklyWorkout(
      day: 'Thursday',
      workout: 'Rest Day',
      time: '-',
      calories: '-',
    ),
    WeeklyWorkout(
      day: 'Friday',
      workout: 'Upper Body',
      time: '35 min',
      calories: '290 kcal',
    ),
    WeeklyWorkout(
      day: 'Saturday',
      workout: 'Cardio',
      time: '25 min',
      calories: '250 kcal',
    ),
    WeeklyWorkout(
      day: 'Sunday',
      workout: 'Recovery',
      time: '20 min',
      calories: '120 kcal',
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
          'Weekly Activity',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: weeklyData.length + 3,
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
                'This Week',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }

          if (index == weeklyData.length + 2) {
            return _buildSummaryCard();
          }

          final itemIndex = index - 2;

          return _DayActivityCard(
            item: weeklyData[itemIndex],
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
          'assets/images/Scroll 4.jpg',
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
                Icons.calendar_month,
                size: 45,
                color: Colors.grey,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSummaryCard() {
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
            'Weekly Summary',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _SummaryItem(
                value: '6',
                label: 'Workouts',
              ),
              _SummaryItem(
                value: '185',
                label: 'Minutes',
              ),
              _SummaryItem(
                value: '1610',
                label: 'Calories',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DayActivityCard extends StatelessWidget {
  final WeeklyWorkout item;

  const _DayActivityCard({
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFFF0F2F5),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.calendar_today_outlined,
              size: 23,
            ),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.day,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.workout,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                item.time,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                item.calories,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final String value;
  final String label;

  const _SummaryItem({
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}