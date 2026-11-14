import 'package:flutter/material.dart';
import 'package:flutter_gun_2/components/product_card.dart';
import 'package:flutter_gun_2/models/products_model.dart';
import 'package:flutter_gun_2/services/api_services.dart';
import 'package:flutter_gun_2/views/cart_screen.dart';

import 'dart:developer';

import 'package:flutter_gun_2/views/produc_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ApiService apiService = ApiService();

  List<Data> allProducts = [];
  bool isLoading = false;
  String errorMessage = "";

  Set<int> cartIds = {};

  Future<void> loadProducts() async {
    try {
      setState(() {
        isLoading = true;
      });

      final productModel = await apiService.fetchProducts();

      log("Ürünler getirildi");

      setState(() {
        allProducts = productModel.data!;
      });
    } catch (e) {
      setState(() {
        errorMessage = "Failed to load products";
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    loadProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Discover",
                    style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
                  ),

                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CartScreen(
                            allProducts: allProducts,
                            cartId: cartIds,
                          ),
                        ),
                      );
                    },
                    iconSize: 32,
                    icon: Icon(Icons.shopping_bag_outlined),
                  ),
                ],
              ),
              SizedBox(height: 8),

              Text(
                "Find your perfect device.",

                style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
              ),

              SizedBox(height: 14),

              Container(
                decoration: BoxDecoration(
                  color: Color(0xfff5f5f7),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search products",
                    hintStyle: TextStyle(color: Colors.brown.shade300),
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search, color: Colors.brown.shade300),
                    contentPadding: EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),

              SizedBox(height: 16),

              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  "https://wantapi.com/assets/banner.png",
                  height: 80,
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
                ),
              ),

              SizedBox(height: 16),

              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: allProducts.length,
                  itemBuilder: (context, index) {
                    final findProduct = allProducts[index];

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,

                          MaterialPageRoute(
                            builder: (context) => ProdcutDetailScreen(
                              findProduct: findProduct,
                              cartIds: cartIds,
                            ),
                          ),
                        );
                      },

                      child: ProductCard(findProduct: findProduct),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
