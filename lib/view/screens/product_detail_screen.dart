import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rimstore/data/models/product.dart';
import 'package:rimstore/viewmodel/product_viewmodel.dart';

class ProductDetailScreen extends StatelessWidget {
  final int productId;
  const ProductDetailScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    final productViewModel =
        Provider.of<ProductViewModel>(context, listen: false);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Product Detail'),
        ),
        body: FutureBuilder<Product>(
          future: productViewModel.fetchProductById(productId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }
            final product = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(children: [
                Image.network(
                  product.image,
                  height: 200,
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  product.title,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  '\$${product.price}',
                  style: const TextStyle(fontSize: 20, color: Colors.green),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(product.description),
              ]),
            );
          },
        ));
  }
}
