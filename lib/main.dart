import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rimstore/data/repositories/ProductRepository.dart';
import 'package:rimstore/view/screens/product_detail_screen.dart';
import 'package:rimstore/view/screens/product_list_screen.dart';
import 'package:rimstore/viewmodel/product_viewmodel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => ProductRepository()),
        ChangeNotifierProvider(
            create: (context) => ProductViewModel(
                Provider.of<ProductRepository>(context, listen: false)))
      ],
      child: MaterialApp(
        title: 'Product List',
        theme: ThemeData(primarySwatch: Colors.blue),
        routes: {
          '/': (context) => const ProductListScreen(),
          '/detail': (context) => ProductDetailScreen(
              productId: ModalRoute.of(context)!.settings.arguments as int),
        },
        // home: const ProductListScreen(),
      ),
    );
  }
}
