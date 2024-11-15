import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rimstore/viewmodel/product_viewmodel.dart';

class ProductDetailScreen extends StatefulWidget {
  final int productId;
  const ProductDetailScreen({super.key, required this.productId});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  void initState() {
    super.initState();
    // Memanggil fetchProductById() sekali di init state
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProductViewModel>(context, listen: false)
          .fetchProductById(widget.productId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final productViewModel =
        Provider.of<ProductViewModel>(context, listen: false);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Product Detail'),
        ),
        body: Consumer<ProductViewModel>(
          builder: (context, prodcutViewModel, child) {
            if (prodcutViewModel.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (productViewModel.selectedProduct == null) {
              return const Center(
                child: Text('Error: Product not found.'),
              );
            }
            final product = productViewModel.selectedProduct;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.network(
                          product!.image,
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
                          style: const TextStyle(
                              fontSize: 20, color: Colors.green),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(product.description),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
                // const Spacer(),
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[300],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_cart,
                          color: Colors.white,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Add to cart',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                )
                // ElevatedButton(onPressed: () {}, child: Text("Add to cart"),style: ButtonStyle(),)
              ]),
            );
          },
        ));
  }
}
