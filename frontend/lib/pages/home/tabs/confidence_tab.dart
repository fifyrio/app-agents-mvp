import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// AI Confidence Coach Tab
class ConfidenceTab extends StatelessWidget {
  const ConfidenceTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          children: [
            const SizedBox(height: 16),

            // Header with title and menu icon
            _buildHeader(context),
            const SizedBox(height: 32),

            // Today's Affirmation section
            _buildAffirmationSection(context),
            const SizedBox(height: 24),

            // Tip Card
            _buildTipCard(context),
            const SizedBox(height: 24),

            // Daily Streak section
            _buildDailyStreakSection(context),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  /// Header with title and menu icon
  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        // Title
        const Expanded(
          child: Text(
            'AI Confidence Coach',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.black,
              letterSpacing: -0.5,
            ),
          ),
        ),

        // Menu Icon
        InkWell(
          onTap: () {
            Get.snackbar(
              'Menu',
              'Confidence coach settings',
              snackPosition: SnackPosition.BOTTOM,
            );
          },
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(8),
            child: const Icon(
              Icons.more_horiz,
              size: 28,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }

  /// Today's Affirmation section with AI Assistant and message
  Widget _buildAffirmationSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Title
        const Text(
          "Today's Affirmation",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            color: Colors.black,
            height: 1.2,
            letterSpacing: -0.8,
          ),
        ),
        const SizedBox(height: 24),

        // AI Assistant Label
        Text(
          'AI Assistant',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey[600],
            letterSpacing: -0.2,
          ),
        ),
        const SizedBox(height: 12),

        // Chat bubble with avatar
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[300],
                image: const DecorationImage(
                  image: NetworkImage(
                    'https://ui-avatars.com/api/?name=AI&background=7C3AED&color=fff&size=128',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 12),

            // Message Bubble
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFFE9D5FF), // Light purple
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'I am confident in my unique style.',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                    height: 1.4,
                    letterSpacing: -0.2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Tip Card with icon, title, description, and action button
  Widget _buildTipCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon and Title Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon Circle
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFFE9D5FF), // Light purple
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.auto_awesome,
                  size: 24,
                  color: Color(0xFF7C3AED),
                ),
              ),
              const SizedBox(width: 16),

              // Title
              const Expanded(
                child: Text(
                  'Wear a color that makes you feel powerful',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                    height: 1.3,
                    letterSpacing: -0.4,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Description
          Text(
            'Choose an outfit in a color that boosts your mood and confidence. Embrace the power of color to express your inner strength.',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Colors.grey[600],
              height: 1.5,
              letterSpacing: -0.2,
            ),
          ),
          const SizedBox(height: 24),

          // Save to Journal Button
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () {
                Get.snackbar(
                  'Saved',
                  'Affirmation saved to your journal',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: const Color(0xFF7C3AED),
                  colorText: Colors.white,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF7C3AED),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
              ),
              child: const Text(
                'Save to Journal',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.3,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Daily Streak section with progress bar
  Widget _buildDailyStreakSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Title
        const Text(
          'Daily Streak',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
            letterSpacing: -0.4,
          ),
        ),
        const SizedBox(height: 16),

        // Progress Bar
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: SizedBox(
            height: 12,
            child: Stack(
              children: [
                // Background
                Container(
                  width: double.infinity,
                  color: const Color(0xFFE5E7EB), // Light gray
                ),
                // Progress
                FractionallySizedBox(
                  widthFactor: 0.6, // 60% progress (3 out of 5 days example)
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF7C3AED), // Purple
                          Color(0xFF9F67FF), // Lighter purple
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Progress Text
        Text(
          '3 days of self-love tips read',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey[600],
            letterSpacing: -0.2,
          ),
        ),
      ],
    );
  }
}
