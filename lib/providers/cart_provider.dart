import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

class CartNotifier extends Notifier<List<CartItem>> {
  @override
  List<CartItem> build() {
    return [];
  }

  void addItem(Product product) {
    // Check if product exists in cart
    final existingIndex = state.indexWhere((item) => item.product.id == product.id);
    
    if (existingIndex >= 0) {
      // Create a brand new list with the updated quantity (immutable state)
      final newState = [...state];
      newState[existingIndex] = CartItem(
        product: product, 
        quantity: newState[existingIndex].quantity + 1
      );
      state = newState;
    } else {
      // Add entirely new item
      state = [...state, CartItem(product: product)];
    }
  }

  void removeItem(String productId) {
    state = state.where((item) => item.product.id != productId).toList();
  }

  void decrementQuantity(String productId) {
    final existingIndex = state.indexWhere((item) => item.product.id == productId);
    if (existingIndex >= 0) {
      if (state[existingIndex].quantity > 1) {
        final newState = [...state];
        newState[existingIndex] = CartItem(
          product: state[existingIndex].product, 
          quantity: newState[existingIndex].quantity - 1
        );
        state = newState;
      } else {
        removeItem(productId);
      }
    }
  }

  double get totalPrice {
    return state.fold(0, (total, item) => total + (item.product.price * item.quantity));
  }
}

final cartProvider = NotifierProvider<CartNotifier, List<CartItem>>(() {
  return CartNotifier();
});
