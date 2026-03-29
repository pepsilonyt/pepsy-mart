class Category {
  final String id;
  final String name;
  final String imageUrl;
  
  Category({required this.id, required this.name, required this.imageUrl});
}

class Product {
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  final String categoryId;
  final String unit;
  final int deliveryMinutes;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.categoryId,
    required this.unit,
    required this.deliveryMinutes,
  });
}

// Ultra-Stable Picsum ID links (Guaranteed fast TLS routing, no hotlink blocks)
final List<Category> mockCategories = [
  Category(id: 'c1', name: 'Vegetables \n& Fruits', imageUrl: 'https://picsum.photos/id/824/200/200'), // Tomatoes
  Category(id: 'c2', name: 'Dairy & \nBreakfast', imageUrl: 'https://picsum.photos/id/429/200/200'), // Berries
  Category(id: 'c3', name: 'Munchies \nChips', imageUrl: 'https://picsum.photos/id/292/200/200'), // Ingredients
  Category(id: 'c4', name: 'Cold Drinks \n& Juices', imageUrl: 'https://picsum.photos/id/365/200/200'), // Coffee beans
  Category(id: 'c5', name: 'Instant & \nFrozen', imageUrl: 'https://picsum.photos/id/1080/200/200'), // Strawberries
  Category(id: 'c6', name: 'Meat & \nSeafood', imageUrl: 'https://picsum.photos/id/493/200/200'), // Strawberry detail
  Category(id: 'c7', name: 'Bakery & \nBiscuits', imageUrl: 'https://picsum.photos/id/111/200/200'), // Vintage car (placeholder)
  Category(id: 'c8', name: 'Sweet \nTooth', imageUrl: 'https://picsum.photos/id/30/200/200'), // Mug
];

final List<Product> mockBestsellers = [
  Product(id: 'p1', name: 'Amul Taaza Homogenised Toned Milk', price: 1.50, unit: '1 L', categoryId: 'c2', deliveryMinutes: 8, imageUrl: 'https://picsum.photos/id/660/400/400'),
  Product(id: 'p2', name: 'Onion (Pyaz)', price: 0.80, unit: '1 kg', categoryId: 'c1', deliveryMinutes: 8, imageUrl: 'https://picsum.photos/id/824/400/400'),
  Product(id: 'p3', name: 'Farm Fresh Brown Eggs', price: 2.10, unit: '6 pcs', categoryId: 'c2', deliveryMinutes: 9, imageUrl: 'https://picsum.photos/id/292/400/400'),
  Product(id: 'p4', name: 'Fresh Coriander Leaves', price: 0.30, unit: '100 g', categoryId: 'c1', deliveryMinutes: 8, imageUrl: 'https://picsum.photos/id/429/400/400'),
  Product(id: 'p5', name: 'Amul Butter Salted', price: 1.45, unit: '100 g', categoryId: 'c2', deliveryMinutes: 8, imageUrl: 'https://picsum.photos/id/1080/400/400'),
  Product(id: 'p6', name: 'Fresh Tomato (Desi)', price: 1.25, unit: '1 kg', categoryId: 'c1', deliveryMinutes: 10, imageUrl: 'https://picsum.photos/id/493/400/400'),
];

final List<Product> mockSnacks = [
  Product(id: 'p7', name: 'Lays India\'s Magic Masala Chips', price: 0.50, unit: '50 g', categoryId: 'c3', deliveryMinutes: 10, imageUrl: 'https://picsum.photos/id/365/400/400'),
  Product(id: 'p8', name: 'Coca-Cola Original', price: 1.20, unit: '750 ml', categoryId: 'c4', deliveryMinutes: 8, imageUrl: 'https://picsum.photos/id/30/400/400'),
  Product(id: 'p9', name: 'Instant Noodles Maggi', price: 0.35, unit: '70 g', categoryId: 'c5', deliveryMinutes: 8, imageUrl: 'https://picsum.photos/id/111/400/400'),
  Product(id: 'p10', name: 'Haldiram\'s Bhujia Sev', price: 1.75, unit: '200 g', categoryId: 'c3', deliveryMinutes: 12, imageUrl: 'https://picsum.photos/id/824/400/400'),
];
