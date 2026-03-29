import 'package:flutter/material.dart';
import '../../models.dart';
import '../../theme.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CategoryScreen extends StatelessWidget {
  final Category category;

  const CategoryScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    // Mock mapping: If it's a specific category, show subset. For demo, we mix them.
    final products = [...mockBestsellers, ...mockSnacks];

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: Text(category.name.replaceAll('\n', ' '), style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.textDark)),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: AppTheme.textDark),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Strict 2-column rule for CRO
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.72, // Taller cards for images and CTA
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final p = products[index];
          final hasDiscount = index % 3 == 0; // Fake discount badges locally

          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.black.withOpacity(0.05)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image Box
                Expanded(
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                          image: DecorationImage(image: CachedNetworkImageProvider(p.imageUrl), fit: BoxFit.cover),
                        ),
                      ),
                      if (hasDiscount)
                        Positioned(
                          top: 8, left: 8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(color: AppTheme.offerRed, borderRadius: BorderRadius.circular(4)),
                            child: const Text('20% OFF', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                          ),
                        ),
                    ],
                  ),
                ),
                // Details Box
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(p.name, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppTheme.textDark)),
                      const SizedBox(height: 4),
                      Text(p.unit, style: const TextStyle(fontSize: 11, color: AppTheme.textLight)),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (hasDiscount) Text('\$${(p.price * 1.2).toStringAsFixed(2)}', style: const TextStyle(fontSize: 10, decoration: TextDecoration.lineThrough, color: AppTheme.textLight)),
                              Text('\$${p.price.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                            ],
                          ),
                          // The CRO quick add button
                          Container(
                            height: 32,
                            width: 32,
                            decoration: BoxDecoration(color: Colors.white, border: Border.all(color: AppTheme.accentGreen), borderRadius: BorderRadius.circular(8)),
                            child: const Icon(Icons.add, color: AppTheme.accentGreen, size: 20),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
