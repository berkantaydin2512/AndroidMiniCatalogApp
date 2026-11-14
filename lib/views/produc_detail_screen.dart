import 'package:flutter/material.dart';
import 'package:flutter_gun_2/models/products_model.dart';

class ProdcutDetailScreen extends StatefulWidget {
  final Data findProduct;
  final Set<int> cartIds;

  const new({super.key, 
  required this.findProduct, 
  required this.cartIds});

  @override
  State<ProdcutDetailScreen> createState() => _ProdcutDetailScreenState();
}

class _ProdcutDetailScreenState extends State<ProdcutDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Back"), backgroundColor: Colors.white),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
          
            children: [
              Image.network(
                widget.findProduct.image!,
                height: 350,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
          
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                          widget.findProduct.name!,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 28,
                            ),
                        ),
                    
                        SizedBox(height: 2),
                    
                    Text(
                          widget.findProduct.tagline!,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade600,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                    
                    SizedBox(height: 10),
                    
                        Text(
                          "Description",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                    
                        SizedBox(height: 4),
                    
                        Text(
                          widget.findProduct.description!,
                          style: TextStyle(height: 1.5, color: Colors.grey.shade800),
                          textAlign: TextAlign.justify,
                        ),
                    
                        SizedBox(height: 10),
                    
                        Text(
                          widget.findProduct.price!,
                          style: TextStyle(fontSize: 22, color: Colors.blue.shade800),
                        ),
                         SizedBox(height: 10),
          
                          ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      minimumSize: Size(double.infinity, 55),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
          
                    onPressed: () {
                      setState(() {
                        widget.cartIds.add(widget.findProduct.id!);
                      });
          
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                          "Added to cart!"
                        ),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.green,
                        margin: EdgeInsets.only(
                          bottom: 80,
                          left: 20,
                          right: 20,
                        ),)
                      );
                    },
          
                    child: Text(
                      "Buy Now",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                  
          
          
                  ],
                ),
              ),
          
                 
          
                 
                ],
              
            
          ),
        ),
      ),
    );
  }
}
