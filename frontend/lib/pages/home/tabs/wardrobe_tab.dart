import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Wardrobe Tab - Explore Your Perfect Looks
///
/// AI suggests outfits and color palettes for every occasion
class WardrobeTab extends StatefulWidget {
  const WardrobeTab({super.key});

  @override
  State<WardrobeTab> createState() => _WardrobeTabState();
}

class _WardrobeTabState extends State<WardrobeTab> {
  String _selectedOccasion = 'All';

  // Occasion categories matching the design
  static const List<String> _occasions = [
    'All',
    'Work',
    'Date',
    'Travel',
    'Party',
    'Interview',
  ];

  // Theme colors
  static const Color primaryPurple = Color(0xFF7C3AED);
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color textPrimary = Color(0xFF000000);
  static const Color textSecondary = Color(0xFF6B7280);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Header with menu, title, and search
            _buildHeader(),

            // Subtitle description
            _buildSubtitle(),

            // Occasion tabs
            _buildOccasionTabs(),

            // Outfit cards grid
            Expanded(
              child: _buildOutfitGrid(),
            ),
          ],
        ),
      ),
    );
  }

  /// Build header with hamburger menu, title, and search icon
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Hamburger menu
          IconButton(
            icon: const Icon(Icons.menu, size: 24),
            onPressed: () {
              Get.snackbar(
                'Menu',
                'Navigation menu',
                snackPosition: SnackPosition.BOTTOM,
              );
            },
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),

          // Title
          const Expanded(
            child: Text(
              'Explore Your Perfect Looks',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: textPrimary,
                letterSpacing: -0.3,
              ),
            ),
          ),

          // Search icon
          IconButton(
            icon: const Icon(Icons.search, size: 24),
            onPressed: () {
              Get.snackbar(
                'Search',
                'Search outfits',
                snackPosition: SnackPosition.BOTTOM,
              );
            },
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }

  /// Build subtitle description
  Widget _buildSubtitle() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      color: Colors.white,
      child: const Text(
        'AI suggests outfits and color palettes for every occasion.',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: textSecondary,
          height: 1.4,
          letterSpacing: -0.1,
        ),
      ),
    );
  }

  /// Build occasion tabs
  Widget _buildOccasionTabs() {
    return Container(
      height: 48,
      margin: const EdgeInsets.only(top: 16, bottom: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _occasions.length,
        itemBuilder: (context, index) {
          final occasion = _occasions[index];
          final isSelected = _selectedOccasion == occasion;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedOccasion = occasion;
              });
            },
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? primaryPurple : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? primaryPurple : const Color(0xFFE5E7EB),
                  width: 1,
                ),
              ),
              child: Center(
                child: Text(
                  occasion,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: isSelected ? Colors.white : textSecondary,
                    letterSpacing: -0.1,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /// Build outfit grid
  Widget _buildOutfitGrid() {
    final outfits = _getFilteredOutfits();

    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 20,
        childAspectRatio: 0.58, // Increased height for more content space
      ),
      itemCount: outfits.length,
      itemBuilder: (context, index) {
        return _OutfitCard(outfit: outfits[index]);
      },
    );
  }

  /// Get filtered outfits based on selected occasion
  List<_OutfitData> _getFilteredOutfits() {
    final allOutfits = _getMockOutfits();
    if (_selectedOccasion == 'All') {
      return allOutfits;
    }
    return allOutfits
        .where((outfit) => outfit.occasion == _selectedOccasion)
        .toList();
  }

  /// Mock outfit data matching the design
  List<_OutfitData> _getMockOutfits() {
    return [
      _OutfitData(
        title: 'Chic City Brunch',
        description: 'Cool summer palette',
        occasion: 'Date',
        isPremium: true,
        imageUrl: 'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?w=400',
        colors: [
          const Color(0xFF2C3E50),
          const Color(0xFFFFC0CB),
          const Color(0xFF95A5A6),
        ],
      ),
      _OutfitData(
        title: 'Boardroom Ready',
        description: 'Deep winter power look',
        occasion: 'Work',
        isPremium: false,
        imageUrl: 'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=400',
        colors: [
          const Color(0xFF1C2833),
          const Color(0xFFE74C3C),
          const Color(0xFF7F8C8D),
        ],
      ),
      _OutfitData(
        title: 'Sunset Dinner Date',
        description: 'Warm autumn romance',
        occasion: 'Date',
        isPremium: false,
        imageUrl: 'https://images.unsplash.com/photo-1529139574466-a303027c1d8b?w=400',
        colors: [
          const Color(0xFFD35400),
          const Color(0xFFC0392B),
          const Color(0xFFF39C12),
          const Color(0xFFE67E22),
        ],
      ),
      _OutfitData(
        title: 'Casual Weekend Wander',
        description: 'Soft spring comfort',
        occasion: 'Travel',
        isPremium: false,
        imageUrl: 'https://images.unsplash.com/photo-1487222477894-8943e31ef7b2?w=400',
        colors: [
          const Color(0xFF27AE60),
          const Color(0xFF3498DB),
          const Color(0xFFFFC0CB),
        ],
      ),
      _OutfitData(
        title: 'Garden Party Elegance',
        description: 'Bright spring florals',
        occasion: 'Party',
        isPremium: true,
        imageUrl: 'https://images.unsplash.com/photo-1469334031218-e382a71b716b?w=400',
        colors: [
          const Color(0xFFE91E63),
          const Color(0xFF9C27B0),
          const Color(0xFFFFC107),
        ],
      ),
      _OutfitData(
        title: 'Professional Presence',
        description: 'Classic interview ready',
        occasion: 'Interview',
        isPremium: false,
        imageUrl: 'https://images.unsplash.com/photo-1551232864-3f0890e580d9?w=400',
        colors: [
          const Color(0xFF34495E),
          const Color(0xFFECF0F1),
          const Color(0xFF2C3E50),
        ],
      ),
      _OutfitData(
        title: 'Travel in Style',
        description: 'Comfortable chic',
        occasion: 'Travel',
        isPremium: true,
        imageUrl: 'https://images.unsplash.com/photo-1483985988355-763728e1935b?w=400',
        colors: [
          const Color(0xFF8B4513),
          const Color(0xFFD2691E),
          const Color(0xFFDEB887),
        ],
      ),
      _OutfitData(
        title: 'Office Power Move',
        description: 'Bold confidence',
        occasion: 'Work',
        isPremium: false,
        imageUrl: 'https://images.unsplash.com/photo-1592328715880-e335f08cb905?w=400',
        colors: [
          const Color(0xFFB22222),
          const Color(0xFF000000),
          const Color(0xFFFFFFFF),
        ],
      ),
    ];
  }
}

/// Data model for outfit items
class _OutfitData {
  final String title;
  final String description;
  final String occasion;
  final bool isPremium;
  final String imageUrl;
  final List<Color> colors;

  _OutfitData({
    required this.title,
    required this.description,
    required this.occasion,
    required this.isPremium,
    required this.imageUrl,
    required this.colors,
  });
}

/// Individual outfit card widget
class _OutfitCard extends StatelessWidget {
  const _OutfitCard({required this.outfit});

  final _OutfitData outfit;

  static const Color primaryPurple = Color(0xFF7C3AED);
  static const Color lightPurple = Color(0xFFEDE9FE);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image with premium badge
          Expanded(
            flex: 10,
            child: _buildImage(),
          ),

          // Title and description
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  outfit.title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    letterSpacing: -0.2,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 3),
                Text(
                  outfit.description,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF6B7280),
                    letterSpacing: -0.1,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          // Color palette dots
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: outfit.colors.map((color) {
                return Container(
                  width: 18,
                  height: 18,
                  margin: const EdgeInsets.only(right: 5),
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.15),
                        blurRadius: 3,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 10),

          // AI Generate button
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            child: SizedBox(
              width: double.infinity,
              height: 36,
              child: ElevatedButton(
                onPressed: () {
                  Get.snackbar(
                    'AI Generate',
                    'Generating outfit for ${outfit.title}',
                    snackPosition: SnackPosition.BOTTOM,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: lightPurple,
                  foregroundColor: primaryPurple,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                ),
                child: const Text(
                  'AI Generate My Outfit',
                  style: TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.1,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build image with premium badge
  Widget _buildImage() {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(24),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Outfit image
          Container(
            color: const Color(0xFFF5F5F5),
            child: Image.network(
              outfit.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Center(
                  child: Icon(
                    Icons.checkroom,
                    size: 48,
                    color: Colors.grey[300],
                  ),
                );
              },
            ),
          ),

          // Premium badge
          if (outfit.isPremium)
            Positioned(
              top: 10,
              left: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: primaryPurple,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Premium',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
