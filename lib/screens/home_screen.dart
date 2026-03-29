import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models.dart';
import '../theme.dart';
import '../providers/cart_provider.dart';
import '../widgets/bouncy_scale.dart';
import '../widgets/staggered_fade.dart';
import 'product_details_screen.dart';
import 'cart_screen.dart';
import 'orders_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      drawer: _buildSidebarDrawer(context),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _buildYellowSliverAppBar(context, ref),
          _buildQuickActionBanner(context),
          _buildDenseCategories(),
          _buildProductShelf(context, ref, 'Bestsellers', mockBestsellers, 400),
          _buildProductShelf(context, ref, 'Snack Attack', mockSnacks, 500),
          const SliverPadding(padding: EdgeInsets.only(bottom: 60)),
        ],
      ),
    );
  }

  Widget _buildSidebarDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(),
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(color: AppTheme.primaryColor),
            accountName: const Text('Siddharth', style: TextStyle(color: AppTheme.textDark, fontWeight: FontWeight.bold, fontSize: 20)),
            accountEmail: const Text('+1 9876543210', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w600)),
            currentAccountPicture: Container(
              decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              child: const Icon(Icons.person, size: 40, color: AppTheme.textDark),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.shopping_bag_outlined, color: AppTheme.textDark),
            title: const Text('My Orders', style: TextStyle(fontWeight: FontWeight.bold)),
            onTap: () {
              Navigator.pop(context); // Close Drawer
              Navigator.push(context, MaterialPageRoute(builder: (_) => const OrdersScreen()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.person_outline, color: AppTheme.textDark),
            title: const Text('My Profile', style: TextStyle(fontWeight: FontWeight.bold)),
            onTap: () {
              Navigator.pop(context); // Close Drawer
              Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileScreen()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.location_on_outlined, color: AppTheme.textDark),
            title: const Text('Delivery Addresses', style: TextStyle(fontWeight: FontWeight.bold)),
            onTap: () {
              Navigator.pop(context);
              _showAddressModal(context);
            },
          ),
          const Divider(height: 32),
          ListTile(
            leading: const Icon(Icons.help_outline, color: AppTheme.textDark),
            title: const Text('Help & Support', style: TextStyle(fontWeight: FontWeight.bold)),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: AppTheme.offerRed),
            title: const Text('Logout', style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.offerRed)),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  void _showAddressModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Select Delivery Location', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.textDark)),
              const SizedBox(height: 24),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.my_location, color: AppTheme.accentGreen),
                title: const Text('Use current location', style: TextStyle(color: AppTheme.accentGreen, fontWeight: FontWeight.bold)),
                subtitle: const Text('Enable location services', style: TextStyle(fontSize: 12)),
                onTap: () => Navigator.pop(ctx),
              ),
              const Divider(height: 32),
              const Text('Saved Addresses', style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.textLight)),
              const SizedBox(height: 16),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.home_outlined),
                title: const Text('Home', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: const Text('B-62, Sector 14, New Delhi', style: TextStyle(fontSize: 12)),
                trailing: const Icon(Icons.check_circle, color: AppTheme.accentGreen),
                onTap: () => Navigator.pop(ctx),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.work_outline),
                title: const Text('Work', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: const Text('Tech Park, Block C, Gurugram', style: TextStyle(fontSize: 12)),
                onTap: () => Navigator.pop(ctx),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () => Navigator.pop(ctx),
                  icon: const Icon(Icons.add),
                  label: const Text('Add New Address'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppTheme.accentGreen,
                    side: const BorderSide(color: AppTheme.accentGreen),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildYellowSliverAppBar(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);
    final cartCount = cartItems.fold(0, (sum, item) => sum + item.quantity);

    return SliverAppBar(
      pinned: true,
      floating: false,
      backgroundColor: AppTheme.primaryColor,
      surfaceTintColor: Colors.transparent,
      collapsedHeight: 80,
      expandedHeight: 140,
      leading: Builder(
        builder: (ctx) => IconButton(
          icon: const Icon(Icons.menu, color: Colors.black87),
          onPressed: () => Scaffold.of(ctx).openDrawer(),
        ),
      ),
      flexibleSpace: SafeArea(
        child: StaggeredFade(
          delay: 0,
          slideOffset: -20, // Slide down instead of up
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 48, right: 16, top: 8, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Delivery in 8 minutes',
                            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: Colors.black87),
                          ),
                          const SizedBox(height: 2),
                          BouncyScale(
                            onTap: () => _showAddressModal(context),
                            child: Row(
                              children: const [
                                Flexible(child: Text('Home - B-62, New Delhi', style: TextStyle(color: Colors.black54, fontSize: 13, fontWeight: FontWeight.w600), overflow: TextOverflow.ellipsis)),
                                Icon(Icons.arrow_drop_down, color: Colors.black87),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    BouncyScale(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const CartScreen())),
                      child: Container(
                        height: 45,
                        width: 45,
                        decoration: const BoxDecoration(
                          color: Colors.black12,
                          shape: BoxShape.circle,
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          clipBehavior: Clip.none,
                          children: [
                            const Icon(Icons.shopping_bag_outlined, color: Colors.black87),
                            if (cartCount > 0)
                              Positioned(
                                top: -2,
                                right: -2,
                                child: Hero(
                                  tag: 'cart_badge',
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: const BoxDecoration(
                                      color: AppTheme.offerRed,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Text(
                                      '$cartCount',
                                      style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              // White search bar overlapping
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: BouncyScale(
                  onTap: () {},
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5))],
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 16),
                        const Icon(Icons.search, color: Colors.black54),
                        const SizedBox(width: 8),
                        const Expanded(
                          child: Text(
                            'Search "Milk"',
                            style: TextStyle(color: Colors.black38, fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const VerticalDivider(width: 1, indent: 10, endIndent: 10, color: Colors.black12),
                        IconButton(
                          icon: const Icon(Icons.mic_none, color: AppTheme.accentGreen),
                          onPressed: () {},
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickActionBanner(BuildContext context) {
    return SliverToBoxAdapter(
      child: StaggeredFade(
        delay: 150,
        slideOffset: 30,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: BouncyScale(
            onTap: () {},
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                color: const Color(0xFFE2F6E9),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Fresh Fruits Extravaganza', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppTheme.textDark)),
                          const SizedBox(height: 4),
                          const Text('Get up to 30% OFF', style: TextStyle(color: AppTheme.accentGreen, fontWeight: FontWeight.bold, fontSize: 12)),
                        ],
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: const BorderRadius.only(topRight: Radius.circular(16), bottomRight: Radius.circular(16)),
                    child: CachedNetworkImage(
                      imageUrl: 'https://images.unsplash.com/photo-1542838132-92c53300491e?q=80&w=300&auto=format&fit=crop',
                      width: 120,
                      height: 100,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, dynamic error) => Container(
                        width: 120,
                        height: 100,
                        color: Colors.green.withOpacity(0.1),
                        child: const Icon(Icons.shopping_basket, color: Colors.green),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDenseCategories() {
    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 0.7,
          crossAxisSpacing: 12,
          mainAxisSpacing: 16,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final cat = mockCategories[index];
            return StaggeredFade(
              delay: 200 + (index * 40), // Cascading popup effect for categories
              slideOffset: 40,
              child: BouncyScale(
                onTap: () {},
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0F2F5),
                          borderRadius: BorderRadius.circular(16),
                          image: DecorationImage(
                            image: CachedNetworkImageProvider(cat.imageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      cat.name,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppTheme.textDark, height: 1.1),
                    ),
                  ],
                ),
              ),
            );
          },
          childCount: mockCategories.length,
        ),
      ),
    );
  }

  Widget _buildProductShelf(BuildContext context, WidgetRef ref, String title, List<Product> sourceList, int baseDelay) {
    return SliverToBoxAdapter(
      child: StaggeredFade(
        delay: baseDelay,
        slideOffset: 40,
        child: Container(
          padding: const EdgeInsets.only(top: 16, bottom: 24),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.textDark)),
                    const Text('See all', style: TextStyle(color: AppTheme.accentGreen, fontWeight: FontWeight.w600, fontSize: 13)),
                  ],
                ),
              ),
              SizedBox(
                height: 230,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: sourceList.length,
                  itemBuilder: (context, index) => _buildBlinkitProductCard(context, ref, sourceList[index]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBlinkitProductCard(BuildContext context, WidgetRef ref, Product product) {
    final cartItems = ref.watch(cartProvider);
    final cartItem = cartItems.where((i) => i.product.id == product.id).firstOrNull;
    final quantity = cartItem?.quantity ?? 0;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 300),
            pageBuilder: (_, __, ___) => ProductDetailsScreen(product: product),
            transitionsBuilder: (_, animation, __, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          )
        );
      },
      child: Container(
        width: 130,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Box
            Hero(
              tag: 'product_image_${product.id}',
              child: Container(
                height: 120,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12, width: 0.5),
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(image: CachedNetworkImageProvider(product.imageUrl), fit: BoxFit.cover),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(8), bottomRight: Radius.circular(12)),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.timer, size: 10, color: AppTheme.textLight),
                            const SizedBox(width: 2),
                            Text('${product.deliveryMinutes} MINS', style: const TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: AppTheme.textDark)),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            // Title
            Expanded(child: Text(product.name, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13, height: 1.2))),
            const SizedBox(height: 2),
            Text(product.unit, style: const TextStyle(color: AppTheme.textLight, fontSize: 11)),
            const SizedBox(height: 6),
            // Bottom Price and ADD logic
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('\$${product.price.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                
                // Blinkit ADD button
                quantity == 0 
                ? BouncyScale(
                    onTap: () => ref.read(cartProvider.notifier).addItem(product),
                    child: Container(
                      height: 30,
                      width: 55,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppTheme.accentGreen.withOpacity(0.5), width: 1.5),
                        color: const Color(0xFFF3FAF4),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Center(
                        child: Text('ADD', style: TextStyle(color: AppTheme.accentGreen, fontWeight: FontWeight.bold, fontSize: 12)),
                      ),
                    ),
                  )
                : Container(
                    height: 30,
                    decoration: BoxDecoration(
                      color: AppTheme.accentGreen,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        BouncyScale(
                          onTap: () => ref.read(cartProvider.notifier).decrementQuantity(product.id),
                          child: const Padding(padding: EdgeInsets.symmetric(horizontal: 6), child: Icon(Icons.remove, color: Colors.white, size: 16)),
                        ),
                        Text('$quantity', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                        BouncyScale(
                          onTap: () => ref.read(cartProvider.notifier).addItem(product),
                          child: const Padding(padding: EdgeInsets.symmetric(horizontal: 6), child: Icon(Icons.add, color: Colors.white, size: 16)),
                        ),
                      ],
                    ),
                  )
              ],
            )
          ],
        ),
      ),
    );
  }
}
