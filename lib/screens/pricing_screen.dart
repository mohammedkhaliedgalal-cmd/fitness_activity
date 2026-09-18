import 'package:flutter/material.dart';

class PricingScreen extends StatefulWidget {
  const PricingScreen({super.key});

  @override
  State<PricingScreen> createState() => _PricingScreenState();
}

class _PricingScreenState extends State<PricingScreen> {
  String selectedPlan = 'Free';

  void selectPlan(String plan) {
    setState(() {
      selectedPlan = plan;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$plan plan selected'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        title: const Text(
          'Pricing',
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
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 10),

            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/images/Pricing.jpg',
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
                        Icons.image_not_supported_outlined,
                        size: 45,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              'Choose Your Plan',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Select the plan that works best for your fitness journey.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 25),

            _planCard(
              title: 'Free',
              price: '\$0',
              period: 'Forever',
              features: const [
                'Basic workouts',
                'Activity tracking',
                'Basic statistics',
              ],
              buttonText:
                  selectedPlan == 'Free' ? 'SELECTED' : 'CHOOSE FREE',
              highlighted: false,
              selected: selectedPlan == 'Free',
              onPressed: () {
                selectPlan('Free');
              },
            ),

            const SizedBox(height: 15),

            _planCard(
              title: 'Premium',
              price: '\$9.99',
              period: 'per month',
              features: const [
                'Unlimited workouts',
                'Advanced statistics',
                'Personal workout plans',
                'Premium content',
              ],
              buttonText:
                  selectedPlan == 'Premium' ? 'SELECTED' : 'GET PREMIUM',
              highlighted: true,
              selected: selectedPlan == 'Premium',
              onPressed: () {
                selectPlan('Premium');
              },
            ),

            const SizedBox(height: 15),

            _planCard(
              title: 'Yearly',
              price: '\$79.99',
              period: 'per year',
              features: const [
                'Everything in Premium',
                'Save on yearly membership',
                'Exclusive fitness content',
                'Priority support',
              ],
              buttonText:
                  selectedPlan == 'Yearly' ? 'SELECTED' : 'CHOOSE YEARLY',
              highlighted: false,
              selected: selectedPlan == 'Yearly',
              onPressed: () {
                selectPlan('Yearly');
              },
            ),

            const SizedBox(height: 20),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.check_circle_outline,
                    size: 28,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Selected Plan',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          selectedPlan,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
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

  Widget _planCard({
    required String title,
    required String price,
    required String period,
    required List<String> features,
    required String buttonText,
    required bool highlighted,
    required bool selected,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: selected
            ? Border.all(
                color: Colors.black,
                width: 2,
              )
            : highlighted
                ? Border.all(
                    color: Colors.black,
                    width: 1,
                  )
                : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (highlighted)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'POPULAR',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

          if (highlighted) const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (selected)
                const Icon(
                  Icons.check_circle,
                  size: 24,
                ),
            ],
          ),

          const SizedBox(height: 10),

          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                price,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 6),
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  period,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          ...features.map(
            (feature) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  const Icon(
                    Icons.check_circle_outline,
                    size: 19,
                    color: Colors.black,
                  ),
                  const SizedBox(width: 9),
                  Expanded(
                    child: Text(
                      feature,
                      style: const TextStyle(
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 8),

          SizedBox(
            width: double.infinity,
            height: 48,
            child: highlighted
                ? ElevatedButton(
                    onPressed: onPressed,
                    child: Text(
                      buttonText,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : OutlinedButton(
                    onPressed: onPressed,
                    child: Text(
                      buttonText,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}