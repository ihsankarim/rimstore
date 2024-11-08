import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rimstore/view/widgets/product_cart.dart';
import 'package:rimstore/viewmodel/product_viewmodel.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productViewModel =
        Provider.of<ProductViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
      ),
      body: FutureBuilder(
        future: productViewModel.fetchProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2 / 3,
            ),
            itemCount: productViewModel.products.length,
            itemBuilder: (context, index) {
              final product = productViewModel.products[index];
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/detail',
                      arguments: product.id);
                },
                child: ProductCard(product: product),
              );
            },
          );
        },
      ),
    );
  }
}
