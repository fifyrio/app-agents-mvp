import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Wardrobe Tab - Explore outfits by color category
class WardrobeTab extends StatefulWidget {
  const WardrobeTab({super.key});

  @override
  State<WardrobeTab> createState() => _WardrobeTabState();
}

class _WardrobeTabState extends State<WardrobeTab> {
  String _selectedFilter = 'All';

  // Color filter categories
  static const List<String> _filterCategories = ['All', 'Warm', 'Cool', 'Neutral'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: SafeArea(
        child: Column(
          children: [
            // Custom App Bar
            _buildAppBar(context),

            // Filter Tabs
            _buildFilterTabs(),

            // Outfit Grid
            Expanded(
              child: _buildOutfitGrid(),
            ),
          ],
        ),
      ),
    );
  }

  /// Custom app bar with hamburger menu, title, and search icon
  Widget _buildAppBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Colors.white,
      child: Row(
        children: [
          // Hamburger Menu
          InkWell(
            onTap: () {
              Get.snackbar(
                'Menu',
                'Opening navigation menu',
                snackPosition: SnackPosition.BOTTOM,
              );
            },
            borderRadius: BorderRadius.circular(8),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.menu,
                size: 26,
                color: Colors.black87,
              ),
            ),
          ),

          // Title
          const Expanded(
            child: Text(
              'Explore',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black,
                letterSpacing: -0.4,
              ),
            ),
          ),

          // Search Icon
          InkWell(
            onTap: () {
              Get.snackbar(
                'Search',
                'Search functionality coming soon',
                snackPosition: SnackPosition.BOTTOM,
              );
            },
            borderRadius: BorderRadius.circular(8),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.search,
                size: 26,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Filter tabs for color categories
  Widget _buildFilterTabs() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      color: Colors.white,
      child: Row(
        children: _filterCategories.map((category) {
          final isActive = _selectedFilter == category;
          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedFilter = category;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: isActive
                          ? const Color(0xFF7C3AED)
                          : Colors.transparent,
                      width: 2,
                    ),
                  ),
                ),
                child: Text(
                  category,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                    color: isActive
                        ? const Color(0xFF7C3AED)
                        : const Color(0xFF9E9E9E),
                    letterSpacing: -0.2,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  /// Outfit grid with 2-column layout
  Widget _buildOutfitGrid() {
    final outfits = _getFilteredOutfits();

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.75,
      ),
      itemCount: outfits.length,
      itemBuilder: (context, index) {
        return _OutfitCard(outfit: outfits[index]);
      },
    );
  }

  /// Get filtered outfits based on selected category
  List<_OutfitData> _getFilteredOutfits() {
    final allOutfits = _getMockOutfits();
    if (_selectedFilter == 'All') {
      return allOutfits;
    }
    return allOutfits.where((outfit) => outfit.category == _selectedFilter).toList();
  }

  /// Mock outfit data - in production, this would come from an API
  List<_OutfitData> _getMockOutfits() {
    return [
      _OutfitData(
        category: 'Warm',
        imageUrl: 'https://images.unsplash.com/photo-1539533018447-63fcce2678e3?w=400',
        colors: [
          const Color(0xFFE5B299),
          const Color(0xFFD4A574),
          const Color(0xFFC2905F),
          const Color(0xFF8B6F47),
        ],
      ),
      _OutfitData(
        category: 'Cool',
        imageUrl: 'https://images.unsplash.com/photo-1515372039744-b8f02a3ae446?w=400',
        colors: [
          const Color(0xFFFFB6C1),
          const Color(0xFFFF69B4),
          const Color(0xFFDA70D6),
          const Color(0xFF9370DB),
        ],
      ),
      _OutfitData(
        category: 'Neutral',
        imageUrl: 'https://images.unsplash.com/photo-1434389677669-e08b4cac3105?w=400',
        colors: [
          const Color(0xFFE5E5E5),
          const Color(0xFFB8B8B8),
          const Color(0xFF737373),
          const Color(0xFF404040),
        ],
      ),
      _OutfitData(
        category: 'Warm',
        imageUrl: 'https://images.unsplash.com/photo-1483985988355-763728e1935b?w=400',
        colors: [
          const Color(0xFFFF6B6B),
          const Color(0xFFFF8E53),
          const Color(0xFFE63946),
          const Color(0xFFB71C1C),
        ],
      ),
      _OutfitData(
        category: 'Cool',
        imageUrl: 'https://images.unsplash.com/photo-1551488831-00ddcb6c6bd3?w=400',
        colors: [
          const Color(0xFF87CEEB),
          const Color(0xFF4682B4),
          const Color(0xFF4169E1),
          const Color(0xFF191970),
        ],
      ),
      _OutfitData(
        category: 'Neutral',
        imageUrl: 'https://images.unsplash.com/photo-1490481651871-ab68de25d43d?w=400',
        colors: [
          const Color(0xFFF5F5DC),
          const Color(0xFFD3C6AA),
          const Color(0xFFA89968),
          const Color(0xFF6B5D4F),
        ],
      ),
      _OutfitData(
        category: 'Warm',
        imageUrl: 'https://images.unsplash.com/photo-1467043237213-65f2da53396f?w=400',
        colors: [
          const Color(0xFFFFA07A),
          const Color(0xFFFF7F50),
          const Color(0xFFFF6347),
          const Color(0xFFD2691E),
        ],
      ),
      _OutfitData(
        category: 'Cool',
        imageUrl: 'https://images.unsplash.com/photo-1485968579580-b6d095142e6e?w=400',
        colors: [
          const Color(0xFFDDA0DD),
          const Color(0xFFBA55D3),
          const Color(0xFF9932CC),
          const Color(0xFF8B008B),
        ],
      ),
    ];
  }
}

/// Data model for outfit items
class _OutfitData {
  final String category;
  final String imageUrl;
  final List<Color> colors;

  _OutfitData({
    required this.category,
    required this.imageUrl,
    required this.colors,
  });
}

/// Individual outfit card widget
class _OutfitCard extends StatelessWidget {
  const _OutfitCard({required this.outfit});

  final _OutfitData outfit;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.snackbar(
          'Outfit',
          'View ${outfit.category} outfit details',
          snackPosition: SnackPosition.BOTTOM,
        );
      },
      borderRadius: BorderRadius.circular(24),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with category badge
            Expanded(
              child: Stack(
                children: [
                  // Outfit Image
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: _getCategoryBackgroundColor(outfit.category),
                      ),
                      child: Image.network(
                        outfit.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          // Fallback for images that fail to load
                          return Center(
                            child: Icon(
                              Icons.checkroom,
                              size: 48,
                              color: Colors.grey[400],
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  // Category Badge
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: _getCategoryBadgeColor(outfit.category),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        outfit.category,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: _getCategoryTextColor(outfit.category),
                          letterSpacing: -0.1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Color palette dots
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: outfit.colors.map((color) {
                  return Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Get badge background color for category
  Color _getCategoryBadgeColor(String category) {
    switch (category) {
      case 'Warm':
        return const Color(0xFFFFE5D9);
      case 'Cool':
        return const Color(0xFFFFD9E5);
      case 'Neutral':
        return const Color(0xFFE5E5E5);
      default:
        return const Color(0xFFE5E5E5);
    }
  }

  /// Get badge text color for category
  Color _getCategoryTextColor(String category) {
    switch (category) {
      case 'Warm':
        return const Color(0xFFD2691E);
      case 'Cool':
        return const Color(0xFFDA70D6);
      case 'Neutral':
        return const Color(0xFF737373);
      default:
        return const Color(0xFF737373);
    }
  }

  /// Get background color for category when image fails to load
  Color _getCategoryBackgroundColor(String category) {
    switch (category) {
      case 'Warm':
        return const Color(0xFFFFF5EE);
      case 'Cool':
        return const Color(0xFFFFF0F5);
      case 'Neutral':
        return const Color(0xFFF5F5F5);
      default:
        return const Color(0xFFF5F5F5);
    }
  }
}
