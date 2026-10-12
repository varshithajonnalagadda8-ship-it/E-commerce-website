import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/product.dart';
import 'providers/cart_provider.dart';
import 'providers/wishlist_provider.dart';

import 'theme/app_theme.dart';

import 'screens/home_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/checkout_screen.dart';
import 'screens/product_details_screen.dart';
import 'screens/wishlist_screen.dart';

void main() {
  runApp(const ShopEaseApp());
}

class ShopEaseApp extends StatelessWidget {
  const ShopEaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CartProvider>(
          create: (_) => CartProvider(),
        ),
        ChangeNotifierProvider<WishlistProvider>(
          create: (_) => WishlistProvider(),
        ),
      ],

      // VERY IMPORTANT:
      // Both providers are ABOVE MaterialApp,
      // so every screen and every route can access them.
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ShopEase',
        theme: AppTheme.theme,
        initialRoute: '/',
        routes: {
          '/': (context) => const HomeScreen(),
          '/cart': (context) => const CartScreen(),
          '/wishlist': (context) => const WishlistScreen(),
          '/checkout': (context) => const CheckoutScreen(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == '/detail') {
            final product = settings.arguments as Product;

            return MaterialPageRoute(
              builder: (context) {
                return ProductDetailScreen(
                  product: product,
                );
              },
            );
          }

          return null;
        },
      ),
    );
  }
}
