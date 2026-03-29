import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models.dart';
import '../theme.dart';
import '../providers/cart_provider.dart';
import '../widgets/bouncy_scale.dart';

class ProductDetailsScreen extends ConsumerWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppTheme.textDark,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () {},
          )
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Huge Product Image Showcase with Hero Tag
                  Hero(
                    tag: 'product_image_${product.id}',
                    child: Container(
                      height: 400,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(40)),
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(product.imageUrl),
                          fit: BoxFit.cover,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 10),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Product Information Array
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                product.name,
                                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.textDark,
                                  fontSize: 26,
                                ),
                              ),
                            ),
                            Text(
                              '\$${product.price}',
                              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppTheme.textDark,
                                fontSize: 26,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(product.unit, style: const TextStyle(color: AppTheme.textLight, fontSize: 16)),
                        const SizedBox(height: 24),
                        
                        // Action Pills
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.amber.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Icon(Icons.star, color: Colors.amber, size: 20),
                                  SizedBox(width: 4),
                                  Text('4.5', style: TextStyle(fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE2F6E9),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.timer, color: AppTheme.accentGreen, size: 20),
                                  const SizedBox(width: 6),
                                  Text('${product.deliveryMinutes} MINS', style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.accentGreen)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        
                        const SizedBox(height: 32),
                        const Text(
                          'Product Details',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppTheme.textDark),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Sourced locally, our organic products are hand-picked fresh every morning guaranteed to bring the farm-to-table experience right to your modern kitchen. Perfect for quick and healthy meals.',
                          style: TextStyle(color: AppTheme.textLight, fontSize: 15, height: 1.5),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          
          // Sticky Bottom "Add to Cart" Bar with Bouncy Animation
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                )
              ],
            ),
            child: BouncyScale(
              onTap: () {
                ref.read(cartProvider.notifier).addItem(product);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${product.name} Added to Cart!'),
                    backgroundColor: AppTheme.accentGreen,
                    duration: const Duration(seconds: 1),
                  )
                );
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.accentGreen,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const SizedBox(
                  width: double.infinity,
                  child: Text('Add to Cart', textAlign: TextAlign.center, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
