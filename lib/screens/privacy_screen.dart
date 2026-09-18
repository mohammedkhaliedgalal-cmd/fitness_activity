import 'package:flutter/material.dart';

class PrivacyScreen extends StatefulWidget {
  const PrivacyScreen({super.key});

  @override
  State<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  bool privateProfile = false;
  bool activityVisibility = true;
  bool locationSharing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        title: const Text(
          'Privacy',
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

            const Icon(
              Icons.lock_outline,
              size: 65,
              color: Colors.black,
            ),

            const SizedBox(height: 20),

            const Text(
              'Privacy Settings',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Control your privacy and activity visibility.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 25),

            _privacyItem(
              title: 'Private Profile',
              subtitle: 'Only approved users can view your profile.',
              value: privateProfile,
              onChanged: (value) {
                setState(() {
                  privateProfile = value;
                });
              },
            ),

            const SizedBox(height: 12),

            _privacyItem(
              title: 'Activity Visibility',
              subtitle: 'Allow others to see your fitness activity.',
              value: activityVisibility,
              onChanged: (value) {
                setState(() {
                  activityVisibility = value;
                });
              },
            ),

            const SizedBox(height: 12),

            _privacyItem(
              title: 'Location Sharing',
              subtitle: 'Allow location information to be shared.',
              value: locationSharing,
              onChanged: (value) {
                setState(() {
                  locationSharing = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _privacyItem({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.shield_outlined,
            size: 27,
            color: Colors.black,
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}