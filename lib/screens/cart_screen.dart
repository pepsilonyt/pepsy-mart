import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../theme.dart';
import '../providers/cart_provider.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);
    final totalPrice = ref.watch(cartProvider.notifier).totalPrice;

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Checkout', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: cartItems.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined, size: 100, color: AppTheme.textLight.withOpacity(0.3)),
                  const SizedBox(height: 16),
                  const Text('No items in cart', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      // Cart Items Block
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.timer, color: AppTheme.accentGreen, size: 20),
                                const SizedBox(width: 8),
                                const Text('Delivery in 8 mins', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              ],
                            ),
                            const Divider(height: 32),
                            ...cartItems.map((item) => Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 60,
                                        width: 60,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black12),
                                          borderRadius: BorderRadius.circular(8),
                                          image: DecorationImage(image: CachedNetworkImageProvider(item.product.imageUrl), fit: BoxFit.cover),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(item.product.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                                            Text(item.product.unit, style: const TextStyle(color: AppTheme.textLight, fontSize: 12)),
                                            const SizedBox(height: 4),
                                            Text('\$${item.product.price.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold)),
                                          ],
                                        ),
                                      ),
                                      // Quick Stepper
                                      Container(
                                        height: 32,
                                        decoration: BoxDecoration(color: AppTheme.accentGreen, borderRadius: BorderRadius.circular(6)),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(icon: const Icon(Icons.remove, color: Colors.white, size: 16), padding: EdgeInsets.zero, constraints: const BoxConstraints(minWidth: 28), onPressed: () => ref.read(cartProvider.notifier).decrementQuantity(item.product.id)),
                                            Text('${item.quantity}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                            IconButton(icon: const Icon(Icons.add, color: Colors.white, size: 16), padding: EdgeInsets.zero, constraints: const BoxConstraints(minWidth: 28), onPressed: () => ref.read(cartProvider.notifier).addItem(item.product)),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ))
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Bill Details Block
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Bill Details', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            const SizedBox(height: 16),
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('Item Total', style: TextStyle(color: AppTheme.textLight)), Text('\$${totalPrice.toStringAsFixed(2)}')]),
                            const SizedBox(height: 8),
                            const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Delivery Fee', style: TextStyle(color: AppTheme.textLight)), Text('\$0.00', style: TextStyle(color: AppTheme.accentGreen, fontWeight: FontWeight.bold))]),
                            const Divider(height: 24),
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('Grand Total', style: TextStyle(fontWeight: FontWeight.bold)), Text('\$${totalPrice.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold))]),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                // Fixed Bottom Payment Bar
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))]),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('PAY USING', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppTheme.textLight)),
                          const SizedBox(height: 4),
                          Row(children: const [Icon(Icons.money, size: 16, color: AppTheme.textDark), SizedBox(width: 4), Text('Cash on Delivery', style: TextStyle(fontWeight: FontWeight.bold))]),
                        ],
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(backgroundColor: AppTheme.accentGreen, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [Text('\$${totalPrice.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)), const Text('TOTAL', style: TextStyle(fontSize: 10, color: Colors.white70))],
                                ),
                                const Row(children: [Text('Place Order ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)), Icon(Icons.arrow_forward_ios, size: 14)]),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
