import 'package:flutter/material.dart';
import 'workout_details_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();

  final List<String> results = [
    'Morning Workout',
    'Full Body Training',
    'Running',
    'Strength Training',
    'Cardio Workout',
    'Yoga',
  ];

  List<String> filteredResults = [];

  @override
  void initState() {
    super.initState();
    filteredResults = List<String>.from(results);
  }

  void search(String value) {
    final query = value.trim().toLowerCase();

    setState(() {
      if (query.isEmpty) {
        filteredResults = List<String>.from(results);
      } else {
        filteredResults = results
            .where(
              (item) => item.toLowerCase().contains(query),
            )
            .toList();
      }
    });
  }

  void clearSearch() {
    searchController.clear();

    setState(() {
      filteredResults = List<String>.from(results);
    });
  }

  void openWorkout(String title) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const WorkoutDetailsScreen(),
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),

      // =========================
      // APP BAR
      // =========================
      appBar: AppBar(
        title: const Text(
          'Search',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),

      // =========================
      // BODY
      // =========================
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 10),

            // =========================
            // IMAGE
            // =========================
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/images/Search.jpg',
                  width: 220,
                  height: 130,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 220,
                      height: 130,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(
                        Icons.search,
                        size: 45,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 25),

            // =========================
            // TITLE
            // =========================
            const Text(
              'Search',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Find workouts, activities and fitness content.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 25),

            // =========================
            // SEARCH FIELD
            // =========================
            TextField(
              controller: searchController,
              onChanged: search,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                suffixIcon: searchController.text.isNotEmpty
                    ? IconButton(
                        onPressed: clearSearch,
                        icon: const Icon(Icons.close),
                      )
                    : null,
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 16,
                ),
              ),
            ),

            const SizedBox(height: 25),

            // =========================
            // SEARCH RESULTS
            // =========================
            if (filteredResults.isEmpty)
              const Padding(
                padding: EdgeInsets.only(top: 30),
                child: Column(
                  children: [
                    Icon(
                      Icons.search_off,
                      size: 55,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 12),
                    Text(
                      'No results found',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              )
            else
              ...filteredResults.map(
                (item) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _searchItem(item),
                ),
              ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  // =========================
  // SEARCH ITEM
  // =========================
  Widget _searchItem(String title) {
    return InkWell(
      onTap: () {
        openWorkout(title);
      },
      borderRadius: BorderRadius.circular(18),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFFF0F1F3),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(
                Icons.fitness_center,
                color: Colors.black,
              ),
            ),

            const SizedBox(width: 13),

            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
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
    );
  }
}