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
      final viewModel = Provider.of<ProductViewModel>(context, listen: false);
      viewModel.fetchCategories();
      viewModel.fetchProducts();
      // Provider.of<ProductViewModel>(context, listen: false).fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: AppBar(
          title: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search",
                    // hintStyle: TextStyle(),
                    prefixIcon: const Icon(Icons.search),
                    border: InputBorder.none,
                    filled: true,
                    // fillColor: Colors.blue[600]?.withOpacity(0.3),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: Color.fromARGB(0, 15, 5, 5)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                ),
              ),
              IconButton(onPressed: () {}, icon: const Icon(Icons.shopping_cart)),
            ],
          ),
          // leading: Icon(Icons.menu),
        ),
      ),
      body: Consumer<ProductViewModel>(
        builder: (context, productViewModel, child) {
          if (productViewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (productViewModel.products.isEmpty) {
            return const Center(child: Text('No products found.'));
          }
          return Column(
            children: [
              SizedBox(height: 40.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: productViewModel.categories.length,
                    itemBuilder: (context, index,) {
                final category = productViewModel.categories[index];
                return Padding(padding: const EdgeInsets.all(8.0),
                child: OutlinedButton(
                  onPressed: () {

                  }, style: ElevatedButton.styleFrom(
                  // backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  )
                ),
                  child: Text(category.name, style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                ),
                );
              }),),
              Expanded(
                child: GridView.builder(
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
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
