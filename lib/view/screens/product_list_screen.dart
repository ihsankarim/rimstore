import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rimstore/view/widgets/product_card.dart';
import 'package:rimstore/viewmodel/product_viewmodel.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch products saat widget pertama kali diinisialisasi
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProductViewModel>(context, listen: false).fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
      ),
      body: Consumer<ProductViewModel>(
        builder: (context, productViewModel, child) {
          if (productViewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (productViewModel.products.isEmpty) {
            return const Center(child: Text('No products found.'));
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
