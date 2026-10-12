import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../providers/cart_provider.dart';
import '../providers/wishlist_provider.dart';
import 'product_details_screen.dart';
import 'cart_screen.dart';

const Color shopPink = Color(0xFFFF3F6C);

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _ShopProduct extends Product {
  final String _category;

  @override
  String get category => _category;

  const _ShopProduct({
    required super.id,
    required super.name,
    required super.price,
    required super.emoji,
    required super.description,
    required String category,
    super.imageUrl = '',
  }) : _category = category;
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  String selectedCategory = 'ALL';
  String searchQuery = '';

  final List<String> categories = [
    'ALL',
    'WOMEN',
    'MEN',
    'KIDS',
    'SHOES',
    'BAGS',
    'ACCESSORIES',
  ];

  final List<_ShopProduct> products = const [
    _ShopProduct(
      id: '1',
      name: 'Floral Summer Dress',
      price: 1299,
      emoji: '👗',
      description: 'Beautiful floral summer dress for a stylish look.',
      category: 'WOMEN',
      imageUrl:
          'https://images.unsplash.com/photo-1612336307429-8a898d10e223?auto=format&fit=crop&w=700&q=85',
    ),
    _ShopProduct(
      id: '2',
      name: 'Oversized T-Shirt',
      price: 699,
      emoji: '👕',
      description: 'Comfortable oversized t-shirt for everyday wear.',
      category: 'MEN',
      imageUrl:
          'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?auto=format&fit=crop&w=700&q=85',
    ),
    _ShopProduct(
      id: '3',
      name: 'Classic Sneakers',
      price: 1999,
      emoji: '👟',
      description: 'Stylish everyday sneakers.',
      category: 'SHOES',
      imageUrl:
          'https://images.unsplash.com/photo-1542291026-7eec264c27ff?auto=format&fit=crop&w=700&q=85',
    ),
    _ShopProduct(
      id: '4',
      name: 'Classic Handbag',
      price: 1499,
      emoji: '👜',
      description: 'Elegant handbag for every occasion.',
      category: 'BAGS',
      imageUrl:
          'https://images.unsplash.com/photo-1584917865442-de89df76afd3?auto=format&fit=crop&w=700&q=85',
    ),
    _ShopProduct(
      id: '5',
      name: 'Denim Jacket',
      price: 1799,
      emoji: '🧥',
      description: 'Classic denim jacket for casual outfits.',
      category: 'WOMEN',
      imageUrl:
          'https://images.unsplash.com/photo-1543076447-215ad9ba6923?auto=format&fit=crop&w=700&q=85',
    ),
    _ShopProduct(
      id: '6',
      name: 'Everyday Backpack',
      price: 999,
      emoji: '🎒',
      description: 'Spacious backpack for everyday essentials.',
      category: 'BAGS',
      imageUrl:
          'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?auto=format&fit=crop&w=700&q=85',
    ),
    _ShopProduct(
      id: '7',
      name: 'Kids Casual Outfit',
      price: 899,
      emoji: '👚',
      description: 'Comfortable casual outfit for kids.',
      category: 'KIDS',
      imageUrl:
          'https://images.unsplash.com/photo-1519238263530-99bdd11df2ea?auto=format&fit=crop&w=700&q=85',
    ),
    _ShopProduct(
      id: '8',
      name: 'Fashion Sunglasses',
      price: 599,
      emoji: '🕶️',
      description: 'Trendy sunglasses for sunny days.',
      category: 'ACCESSORIES',
      imageUrl:
          'https://images.unsplash.com/photo-1511499767150-a48a237f0083?auto=format&fit=crop&w=700&q=85',
    ),
    _ShopProduct(
      id: '9',
      name: 'Elegant Party Dress',
      price: 1899,
      emoji: '👗',
      description: 'Elegant party dress for special occasions.',
      category: 'WOMEN',
      imageUrl:
          'https://images.unsplash.com/photo-1566174053879-31528523f8ae?auto=format&fit=crop&w=700&q=85',
    ),
    _ShopProduct(
      id: '10',
      name: 'Blue Denim Jeans',
      price: 1199,
      emoji: '👖',
      description: 'Classic blue denim jeans for everyday wear.',
      category: 'MEN',
      imageUrl:
          'https://images.unsplash.com/photo-1542272604-787c3835535d?auto=format&fit=crop&w=700&q=85',
    ),
    _ShopProduct(
      id: '11',
      name: 'Casual Hoodie',
      price: 1499,
      emoji: '🧥',
      description: 'Soft hoodie for a relaxed streetwear look.',
      category: 'MEN',
      imageUrl:
          'https://images.unsplash.com/photo-1556821840-3a63f95609a7?auto=format&fit=crop&w=700&q=85',
    ),
    _ShopProduct(
      id: '12',
      name: 'White Casual Sneakers',
      price: 2199,
      emoji: '👟',
      description: 'Minimal white sneakers that match any outfit.',
      category: 'SHOES',
      imageUrl:
          'https://images.unsplash.com/photo-1495555961986-6d4c1ecb7be3?auto=format&fit=crop&w=700&q=85',
    ),
    _ShopProduct(
      id: '13',
      name: 'Leather Shoulder Bag',
      price: 1699,
      emoji: '👜',
      description: 'Stylish shoulder bag for daily use.',
      category: 'BAGS',
      imageUrl:
          'https://images.unsplash.com/photo-1590874103328-eac38a683ce7?auto=format&fit=crop&w=700&q=85',
    ),
    _ShopProduct(
      id: '14',
      name: 'Classic Wrist Watch',
      price: 1299,
      emoji: '⌚',
      description: 'Classic wristwatch for a smart appearance.',
      category: 'ACCESSORIES',
      imageUrl:
          'https://images.unsplash.com/photo-1524592094714-0f0654e20314?auto=format&fit=crop&w=700&q=85',
    ),
    _ShopProduct(
      id: '15',
      name: 'Women Casual Top',
      price: 799,
      emoji: '👚',
      description: 'Trendy casual top for everyday styling.',
      category: 'WOMEN',
      imageUrl:
          'https://images.unsplash.com/photo-1551163943-3f6a855d1153?auto=format&fit=crop&w=700&q=85',
    ),
    _ShopProduct(
      id: '16',
      name: 'Running Sports Shoes',
      price: 2499,
      emoji: '👟',
      description: 'Lightweight shoes for running and workouts.',
      category: 'SHOES',
      imageUrl:
          'https://images.unsplash.com/photo-1460353581641-37baddab0fa2?auto=format&fit=crop&w=700&q=85',
    ),
    _ShopProduct(
      id: '17',
      name: 'Mini Crossbody Bag',
      price: 899,
      emoji: '👜',
      description: 'Compact crossbody bag for outings.',
      category: 'BAGS',
      imageUrl:
          'https://images.unsplash.com/photo-1548036328-c9fa89d128fa?auto=format&fit=crop&w=700&q=85',
    ),
    _ShopProduct(
      id: '18',
      name: 'Kids Sneakers',
      price: 799,
      emoji: '👟',
      description: 'Comfortable shoes for active kids.',
      category: 'KIDS',
      imageUrl:
          'https://images.unsplash.com/photo-1514989940723-e8e51635b782?auto=format&fit=crop&w=700&q=85',
    ),
    _ShopProduct(
      id: '19',
      name: 'Stylish Baseball Cap',
      price: 399,
      emoji: '🧢',
      description: 'Casual cap to complete your streetwear look.',
      category: 'ACCESSORIES',
      imageUrl:
          'https://images.unsplash.com/photo-1588850561407-ed78c282e89b?auto=format&fit=crop&w=700&q=85',
    ),
    _ShopProduct(
      id: '20',
      name: 'Brown Leather Boots',
      price: 2299,
      emoji: '🥾',
      description: 'Versatile boots for a bold casual style.',
      category: 'SHOES',
      imageUrl:
          'https://images.unsplash.com/photo-1543163521-1bf539c55dd2?auto=format&fit=crop&w=700&q=85',
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Product> get filteredProducts {
    return products.where((product) {
      final matchesCategory =
          selectedCategory == 'ALL' || product.category == selectedCategory;

      final query = searchQuery.trim().toLowerCase();

      final matchesSearch = product.name.toLowerCase().contains(query) ||
          product.category.toLowerCase().contains(query);

      return matchesCategory && matchesSearch;
    }).toList();
  }

  void openProduct(Product product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProductDetailScreen(product: product),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFFFFF9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 16,
        title: const Text(
          'ShopEase',
          style: TextStyle(
            color: shopPink,
            fontSize: 27,
            fontWeight: FontWeight.w900,
            letterSpacing: -1,
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Shopping bag',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const CartScreen(),
                ),
              );
            },
            icon: Badge(
              label: Text('${cart.itemCount}'),
              isLabelVisible: cart.itemCount > 0,
              backgroundColor: shopPink,
              child: const Icon(
                Icons.shopping_bag_outlined,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Search dresses, shoes, bags...',
                    prefixIcon: const Icon(
                      Icons.search,
                      color: shopPink,
                    ),
                    suffixIcon: searchQuery.isNotEmpty
                        ? IconButton(
                            onPressed: () {
                              _searchController.clear();
                              setState(() {
                                searchQuery = '';
                              });
                            },
                            icon: const Icon(Icons.close),
                          )
                        : null,
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 15,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(
                        color: Color(0xFFFFD8E1),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(
                        color: Color(0xFFFFD8E1),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(
                        color: shopPink,
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (searchQuery.isEmpty && selectedCategory == 'ALL')
              SliverToBoxAdapter(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(16, 4, 16, 20),
                  height: 185,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFFF3F6C),
                        Color(0xFFFF8A65),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        right: -12,
                        bottom: -24,
                        child: Icon(
                          Icons.shopping_bag_rounded,
                          size: 170,
                          // ignore: deprecated_member_use
                          color: Colors.white.withOpacity(0.15),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(22),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'BIG FASHION SALE',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 23,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            const SizedBox(height: 7),
                            const Text(
                              'UP TO 50% OFF',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 15),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  selectedCategory = 'ALL';
                                  searchQuery = '';
                                  _searchController.clear();
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: shopPink,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                'SHOP NOW →',
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'SHOP BY CATEGORY',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    Text(
                      'Explore styles',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 48,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 9),
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    final isSelected = selectedCategory == category;

                    return ChoiceChip(
                      label: Text(category),
                      selected: isSelected,
                      onSelected: (_) {
                        setState(() {
                          selectedCategory = category;
                        });
                      },
                      selectedColor: shopPink,
                      backgroundColor: Colors.white,
                      side: BorderSide(
                        color: isSelected ? shopPink : const Color(0xFFE8E0E2),
                      ),
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : Colors.black87,
                        fontWeight: FontWeight.w800,
                        fontSize: 11,
                      ),
                      showCheckmark: false,
                    );
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 14),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        searchQuery.isNotEmpty
                            ? 'SEARCH RESULTS'
                            : 'TRENDING NOW',
                        style: const TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    Text(
                      '${filteredProducts.length} items',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (filteredProducts.isEmpty)
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(35),
                  child: Center(
                    child: Column(
                      children: [
                        Icon(
                          Icons.search_off_rounded,
                          size: 55,
                          color: shopPink,
                        ),
                        SizedBox(height: 12),
                        Text(
                          'No products found',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text('Try another search or category.'),
                      ],
                    ),
                  ),
                ),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 24),
                sliver: SliverLayoutBuilder(
                  builder: (context, constraints) {
                    final width = constraints.crossAxisExtent;

                    final columns = width >= 1000
                        ? 4
                        : width >= 650
                            ? 3
                            : 2;

                    return SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: columns,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.57,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final product = filteredProducts[index];

                          return _ProductCard(
                            product: product,
                            onTap: () => openProduct(product),
                          );
                        },
                        childCount: filteredProducts.length,
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;

  const _ProductCard({
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final wishlist = context.watch<WishlistProvider>();
    final isWishlisted = wishlist.isWishlisted(product);

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    product.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) {
                      return Container(
                        color: const Color(0xFFFFF0F3),
                        alignment: Alignment.center,
                        child: Text(
                          product.emoji,
                          style: const TextStyle(fontSize: 55),
                        ),
                      );
                    },
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) return child;

                      return Container(
                        color: const Color(0xFFFFF0F3),
                        alignment: Alignment.center,
                        child: const CircularProgressIndicator(
                          color: shopPink,
                          strokeWidth: 2,
                        ),
                      );
                    },
                  ),
                  Positioned(
                    top: 8,
                    left: 7,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 7,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        // ignore: deprecated_member_use
                        color: Colors.white.withOpacity(0.95),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Text(
                        'TRENDING',
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w900,
                          color: shopPink,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 4,
                    right: 4,
                    child: Material(
                      // ignore: deprecated_member_use
                      color: Colors.white.withOpacity(0.95),
                      shape: const CircleBorder(),
                      child: IconButton(
                        visualDensity: VisualDensity.compact,
                        constraints: const BoxConstraints(
                          minWidth: 36,
                          minHeight: 36,
                        ),
                        padding: EdgeInsets.zero,
                        iconSize: 20,
                        onPressed: () {
                          wishlist.toggleWishlist(product);

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                isWishlisted
                                    ? 'Removed from wishlist'
                                    : 'Added to wishlist',
                              ),
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        },
                        icon: Icon(
                          isWishlisted ? Icons.favorite : Icons.favorite_border,
                          color: shopPink,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 9, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.category ?? 'Uncategorized',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '₹${product.price.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.star,
                        color: Color(0xFFFFB300),
                        size: 15,
                      ),
                      const Text(
                        ' 4.5',
                        style: TextStyle(fontSize: 11),
                      ),
                    ],
                  ),
                  const SizedBox(height: 9),
                  SizedBox(
                    width: double.infinity,
                    height: 36,
                    child: OutlinedButton(
                      onPressed: () {
                        context.read<CartProvider>().addToCart(product);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '${product.name} added to bag',
                            ),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: shopPink,
                        side: const BorderSide(color: shopPink),
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'ADD TO BAG',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
