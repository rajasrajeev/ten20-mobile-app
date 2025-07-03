import 'package:flutter/material.dart';
import 'package:ten20/components/custom_layout_inner.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomLayout(
      title: 'Calendar',
      body: SafeArea(
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: Colors.grey),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search calendar...',
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Colors.grey[500]),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.blue[100],
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child:
                          Icon(Icons.tune, size: 18, color: Colors.blue[700]),
                    ),
                  ],
                ),
              ),
            ),

            // Favorites List
            Expanded(
              child: ListView(
                children: [
                  // _buildFavoriteItem(
                  //     context,
                  //     'Protein Shakes',
                  //     'A blend of protein powder and milk',
                  //     'assets/protein_shake.jpg'),
                  // _buildFavoriteItem(
                  //     context,
                  //     'Smoothies',
                  //     'Fresh fruits blended with yogurt or milk',
                  //     'assets/smoothie.jpg'),
                  // _buildFavoriteItem(
                  //     context,
                  //     'Pre-Workout Drinks',
                  //     'Energy boost drinks for before exercise',
                  //     'assets/pre_workout.jpg'),
                  // _buildFavoriteItem(
                  //     context,
                  //     'Post-Workout Drinks',
                  //     'Recovery drinks with electrolytes',
                  //     'assets/post_workout.jpg'),
                  // _buildFavoriteItem(
                  //     context,
                  //     'Hydration Drinks',
                  //     'Water with added electrolytes and minerals',
                  //     'assets/hydration.jpg'),
                  // _buildFavoriteItem(
                  //     context,
                  //     'Hot Drinks',
                  //     'Coffee, tea, and other warm beverages',
                  //     'assets/hot_drink.jpg'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFavoriteItem(
      BuildContext context, String title, String description, String imageUrl) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              imageUrl,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
              // Fallback to a placeholder if the asset isn't available
              errorBuilder: (context, error, stackTrace) => Container(
                width: 60,
                height: 60,
                color: Colors.grey[300],
                child: Icon(Icons.local_drink, color: Colors.grey[600]),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, bool isSelected) {
    return Icon(
      icon,
      color: isSelected ? Colors.black : Colors.black54,
      size: 24,
    );
  }
}

// Note: You'll need to add these image assets to your project or replace with NetworkImage
// For a complete application, you would also implement proper navigation between screens