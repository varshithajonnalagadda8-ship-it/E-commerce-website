import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../providers/cart_provider.dart';
import '../providers/wishlist_provider.dart';
import 'cart_screen.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final wishlist = Provider.of<WishlistProvider>(context);
    final bool isWishlisted = wishlist.isWishlisted(product);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        title: const Text(
          'Product Details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              wishlist.toggleWishlist(product);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    isWishlisted
                        ? '${product.name} removed from wishlist'
                        : '${product.name} added to wishlist',
                  ),
                  duration: const Duration(seconds: 1),
                ),
              );
            },
            icon: Icon(
              isWishlisted ? Icons.favorite : Icons.favorite_border,
              color: isWishlisted ? Colors.pink : null,
            ),
          ),
          const SizedBox(width: 5),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ZOOMABLE PRODUCT IMAGE
            ProductZoomImage(product: product),

            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Center(
                child: Text(
                  'Scroll to zoom • Drag to explore',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),

            // PRODUCT INFORMATION
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Product ID: ${product.id}',
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    product.formattedPrice,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 15),
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    product.description,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black87,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // DELIVERY INFORMATION
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              color: Colors.white,
              child: Column(
                children: [
                  _infoTile(
                    icon: Icons.local_shipping_outlined,
                    title: 'Free Delivery',
                    subtitle: 'Delivery available to your location',
                  ),
                  const SizedBox(height: 18),
                  _infoTile(
                    icon: Icons.assignment_return_outlined,
                    title: 'Easy Returns',
                    subtitle: '7 days easy return policy',
                  ),
                  const SizedBox(height: 18),
                  _infoTile(
                    icon: Icons.verified_outlined,
                    title: '100% Genuine Product',
                    subtitle: 'Quality checked products',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 100),
          ],
        ),
      ),

      // EXISTING WISHLIST AND CART BUTTONS
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(12),
          color: Colors.white,
          child: Row(
            children: [
              SizedBox(
                width: 55,
                height: 52,
                child: OutlinedButton(
                  onPressed: () {
                    wishlist.toggleWishlist(product);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          wishlist.isWishlisted(product)
                              ? '${product.name} added to wishlist'
                              : '${product.name} removed from wishlist',
                        ),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Icon(
                    wishlist.isWishlisted(product)
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: Colors.pink,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: SizedBox(
                  height: 52,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      final cartProvider = Provider.of<CartProvider>(
                        context,
                        listen: false,
                      );

                      cartProvider.addToCart(product);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '${product.name} added to cart',
                          ),
                          duration: const Duration(seconds: 1),
                          action: SnackBarAction(
                            label: 'VIEW CART',
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const CartScreen(),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.shopping_cart_outlined,
                    ),
                    label: const Text(
                      'Add to Cart',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
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

  Widget _infoTile({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Row(
      children: [
        Container(
          height: 45,
          width: 45,
          decoration: BoxDecoration(
            color: const Color(0xFFF2F2F2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 25),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ZOOMABLE IMAGE WIDGET
class ProductZoomImage extends StatefulWidget {
  final Product product;

  const ProductZoomImage({
    super.key,
    required this.product,
  });

  @override
  State<ProductZoomImage> createState() => _ProductZoomImageState();
}

class _ProductZoomImageState extends State<ProductZoomImage> {
  final TransformationController _controller = TransformationController();

  double _scale = 1.0;

  void _handlePointerSignal(PointerSignalEvent event) {
    if (event is! PointerScrollEvent) return;

    final factor = event.scrollDelta.dy < 0 ? 1.2 : 1 / 1.2;
    final newScale = (_scale * factor).clamp(1.0, 4.0).toDouble();

    if (newScale == _scale) return;

    setState(() {
      _scale = newScale;
      // ignore: deprecated_member_use
      _controller.value = Matrix4.identity()..scale(_scale);
    });
  }

  void _resetZoom() {
    setState(() {
      _scale = 1.0;
      _controller.value = Matrix4.identity();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 400,
      color: Colors.white,
      child: Column(
        children: [
          Expanded(
            child: Listener(
              onPointerSignal: _handlePointerSignal,
              child: InteractiveViewer(
                transformationController: _controller,
                minScale: 1.0,
                maxScale: 4.0,
                panEnabled: true,
                scaleEnabled: true,
                child: SizedBox(
                  width: double.infinity,
                  height: 350,
                  child: widget.product.imageUrl.isNotEmpty
                      ? Image.network(
                          widget.product.imageUrl,
                          fit: BoxFit.contain,
                          loadingBuilder: (
                            context,
                            child,
                            loadingProgress,
                          ) {
                            if (loadingProgress == null) {
                              return child;
                            }

                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Center(
                              child: Text(
                                widget.product.emoji,
                                style: const TextStyle(fontSize: 120),
                              ),
                            );
                          },
                        )
                      : Center(
                          child: Text(
                            widget.product.emoji,
                            style: const TextStyle(fontSize: 120),
                          ),
                        ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Scroll to zoom',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  tooltip: 'Zoom in',
                  onPressed: () {
                    final newScale = (_scale * 1.2).clamp(1.0, 4.0).toDouble();

                    setState(() {
                      _scale = newScale;
                      // ignore: deprecated_member_use
                      _controller.value = Matrix4.identity()..scale(_scale);
                    });
                  },
                  icon: const Icon(Icons.zoom_in),
                ),
                IconButton(
                  tooltip: 'Zoom out',
                  onPressed: () {
                    final newScale = (_scale / 1.2).clamp(1.0, 4.0).toDouble();

                    setState(() {
                      _scale = newScale;
                      // ignore: deprecated_member_use
                      _controller.value = Matrix4.identity()..scale(_scale);
                    });
                  },
                  icon: const Icon(Icons.zoom_out),
                ),
                IconButton(
                  tooltip: 'Reset zoom',
                  onPressed: _resetZoom,
                  icon: const Icon(Icons.zoom_out_map),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
