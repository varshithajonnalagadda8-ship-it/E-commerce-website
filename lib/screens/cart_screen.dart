import 'package:flutter/material.dart';

class CartStore {
  static final List<Map<String, dynamic>> items = [];

  static void addItem(Map<String, dynamic> product) {
    final existingIndex = items.indexWhere(
      (item) => item['name'] == product['name'],
    );

    if (existingIndex != -1) {
      items[existingIndex]['quantity'] =
          (items[existingIndex]['quantity'] ?? 1) + 1;
    } else {
      final newProduct = Map<String, dynamic>.from(product);
      newProduct['quantity'] = 1;
      items.add(newProduct);
    }
  }

  static void increaseQuantity(int index) {
    items[index]['quantity'] = (items[index]['quantity'] ?? 1) + 1;
  }

  static void decreaseQuantity(int index) {
    final currentQuantity = items[index]['quantity'] ?? 1;

    if (currentQuantity > 1) {
      items[index]['quantity'] = currentQuantity - 1;
    } else {
      items.removeAt(index);
    }
  }

  static void removeItem(int index) {
    items.removeAt(index);
  }

  static int get totalItems {
    int total = 0;

    for (final item in items) {
      total += item['quantity'] as int;
    }

    return total;
  }

  static int get subtotal {
    int total = 0;

    for (final item in items) {
      total += (item['price'] as int) * (item['quantity'] as int);
    }

    return total;
  }

  static int get deliveryCharge {
    if (items.isEmpty) {
      return 0;
    }

    if (subtotal >= 499) {
      return 0;
    }

    return 49;
  }

  static int get total {
    return subtotal + deliveryCharge;
  }
}

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final cartItems = CartStore.items;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F6),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFF282C3F),
          ),
        ),
        title: const Text(
          'Shopping Bag',
          style: TextStyle(
            color: Color(0xFF282C3F),
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Center(
              child: Text(
                '${CartStore.totalItems} Items',
                style: const TextStyle(
                  color: Color(0xFF696E79),
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
      body: cartItems.isEmpty
          ? _buildEmptyCart()
          : LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth >= 900) {
                  return _buildDesktopCart();
                }

                return _buildMobileCart();
              },
            ),
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                color: const Color(0xFFFFE8EE),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.shopping_bag_outlined,
                size: 55,
                color: Color(0xFFFF3F6C),
              ),
            ),
            const SizedBox(height: 25),
            const Text(
              'Your Bag is Empty',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: Color(0xFF282C3F),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Looks like you haven\'t added\nanything to your bag yet.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                height: 1.5,
                color: Color(0xFF696E79),
              ),
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF3F6C),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 35,
                  vertical: 15,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: const Text(
                'CONTINUE SHOPPING',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopCart() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(30),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 7,
            child: _buildCartItems(),
          ),
          const SizedBox(width: 25),
          Expanded(
            flex: 4,
            child: _buildPriceDetails(),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileCart() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(18),
      child: Column(
        children: [
          _buildCartItems(),
          const SizedBox(height: 20),
          _buildPriceDetails(),
        ],
      ),
    );
  }

  Widget _buildCartItems() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 15,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            '${CartStore.totalItems} ITEM${CartStore.totalItems == 1 ? '' : 'S'} IN YOUR BAG',
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: Color(0xFF282C3F),
            ),
          ),
        ),
        const SizedBox(height: 12),
        ...List.generate(
          CartStore.items.length,
          (index) {
            return _buildCartItem(
              CartStore.items[index],
              index,
            );
          },
        ),
      ],
    );
  }

  Widget _buildCartItem(
    Map<String, dynamic> product,
    int index,
  ) {
    final quantity = product['quantity'] as int;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.network(
              product['imageUrl'],
              width: 110,
              height: 135,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 110,
                  height: 135,
                  color: const Color(0xFFF5F5F6),
                  child: const Icon(
                    Icons.image_not_supported,
                    color: Colors.grey,
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product['brand'],
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                              color: Color(
                                0xFF282C3F,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            product['name'],
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(
                                0xFF696E79,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        CartStore.removeItem(
                          index,
                        );
                        refresh();
                      },
                      icon: const Icon(
                        Icons.close,
                        size: 19,
                        color: Color(
                          0xFF696E79,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Text(
                      '₹${product['price']}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: Color(
                          0xFF282C3F,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '₹${product['oldPrice']}',
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(
                          0xFF94969F,
                        ),
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      product['discount'],
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: Color(
                          0xFF03A685,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    const Text(
                      'Quantity',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(
                          0xFF696E79,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      height: 34,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(
                            0xFFD4D5D9,
                          ),
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(
                              minWidth: 34,
                            ),
                            onPressed: () {
                              CartStore.decreaseQuantity(
                                index,
                              );
                              refresh();
                            },
                            icon: const Icon(
                              Icons.remove,
                              size: 15,
                            ),
                          ),
                          Container(
                            width: 32,
                            alignment: Alignment.center,
                            child: Text(
                              '$quantity',
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(
                              minWidth: 34,
                            ),
                            onPressed: () {
                              CartStore.increaseQuantity(
                                index,
                              );
                              refresh();
                            },
                            icon: const Icon(
                              Icons.add,
                              size: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceDetails() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'PRICE DETAILS',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: Color(0xFF282C3F),
            ),
          ),
          const SizedBox(height: 18),
          _priceRow(
            'Total MRP',
            '₹${CartStore.subtotal}',
          ),
          const SizedBox(height: 12),
          _priceRow(
            'Discount',
            '₹0',
            valueColor: const Color(0xFF03A685),
          ),
          const SizedBox(height: 12),
          _priceRow(
            'Delivery Charges',
            CartStore.deliveryCharge == 0
                ? 'FREE'
                : '₹${CartStore.deliveryCharge}',
            valueColor: const Color(0xFF03A685),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(
              vertical: 18,
            ),
            child: Divider(
              color: Color(0xFFEAEAEC),
            ),
          ),
          _priceRow(
            'Total Amount',
            '₹${CartStore.total}',
            bold: true,
          ),
          const SizedBox(height: 18),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFE8F5E9),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              CartStore.deliveryCharge == 0
                  ? '🎉 You got FREE delivery!'
                  : 'Add ₹${499 - CartStore.subtotal} more for FREE delivery',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF388E3C),
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                _showCheckoutMessage();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(
                  0xFFFF3F6C,
                ),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    5,
                  ),
                ),
              ),
              child: const Text(
                'PROCEED TO CHECKOUT',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _priceRow(
    String title,
    String value, {
    Color? valueColor,
    bool bold = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: bold ? 15 : 13,
            fontWeight: bold ? FontWeight.w800 : FontWeight.w500,
            color: const Color(0xFF282C3F),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: bold ? 17 : 13,
            fontWeight: bold ? FontWeight.w800 : FontWeight.w600,
            color: valueColor ?? const Color(0xFF282C3F),
          ),
        ),
      ],
    );
  }

  void _showCheckoutMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Checkout',
            style: TextStyle(
              fontWeight: FontWeight.w800,
            ),
          ),
          content: Text(
            'Your order total is ₹${CartStore.total}.\n\nCheckout and payment will be added in the next step.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'OK',
                style: TextStyle(
                  color: Color(0xFFFF3F6C),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
