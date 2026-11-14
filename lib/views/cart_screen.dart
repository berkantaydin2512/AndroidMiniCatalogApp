import 'package:flutter/material.dart';
import 'package:flutter_gun_2/models/products_model.dart';
import 'package:flutter_gun_2/components/card_tile.dart';
import 'package:flutter_gun_2/views/checkout_screen.dart';

class CartScreen extends StatefulWidget {
  final List<Data> allProducts;
  final Set<int> cartId;

  const new({super.key, required this.allProducts, required this.cartId});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final carPoducts = widget.allProducts
        .where((element) => widget.cartId.contains(element.id))
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Cart"), backgroundColor: Colors.white),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: carPoducts.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.shopping_bag_outlined,
                              size: 64,
                              color: Colors.grey,
                            ),

                            SizedBox(height: 12),

                            Text(
                              "Your cart is empty.",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),

                            Text(
                              "Add items to start shopping",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: carPoducts.length,
                        itemBuilder: (context, index) {
                          final item = carPoducts[index];

                          return MiniCardTile(
                            name: item.name!,
                            tagline: item.tagline!,
                            price: item.price!,
                            imageUrl: item.image!,

                            onRemove: () {
                              setState(() {
                                widget.cartId.remove(item.id);
                              });
                            },
                          );
                        },
                      ),
              ),

              SizedBox(height: 14),

              ElevatedButton(
                onPressed: carPoducts.isEmpty
                    ? null
                    : () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CheckoutScreen(products: carPoducts),
                          ),
                        );
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  minimumSize: const Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Checkout',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
