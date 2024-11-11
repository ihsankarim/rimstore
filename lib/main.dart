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

  static const Color primaryColor = Color(0xFFC6E7FF);
  static const Color secondaryColor = Color(0xFFD4F6FF);
  static const Color backgroundColor = Color(0xFFFBFBFB);
  static const Color accentColor = Color(0xFFFFDDAE);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => ProductRepository()),
        ChangeNotifierProvider(
          create: (context) => ProductViewModel(
            Provider.of<ProductRepository>(context, listen: false),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Rim store',
        theme: ThemeData(
           colorScheme: ColorScheme(
          primary: primaryColor,
          primaryContainer: primaryColor.withOpacity(0.8),
          secondary: secondaryColor,
          secondaryContainer: secondaryColor.withOpacity(0.8),
          surface: backgroundColor,
          background: backgroundColor,
          error: Colors.red, // warna untuk error (opsional)
          onPrimary: Colors.black, // warna teks di atas primary
          onSecondary: Colors.black, // warna teks di atas secondary
          onSurface: Colors.black, // warna teks di atas surface
          onBackground: Colors.black, // warna teks di atas background
          onError: Colors.white, // warna teks di atas error
          brightness: Brightness.light, // untuk tema terang
        ),
        scaffoldBackgroundColor: backgroundColor, // Background utama aplikasi
        appBarTheme: AppBarTheme(
          backgroundColor: primaryColor,
          foregroundColor: Colors.black, // warna teks di AppBar
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: accentColor, // Warna tombol default
          textTheme: ButtonTextTheme.primary,
        ),
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.black), // Warna teks default
          bodyText2: TextStyle(color: Colors.black87),
        ),
        ),
        routes: {
          '/': (context) => const ProductListScreen(),
          '/detail': (context) => ProductDetailScreen(
              productId: ModalRoute.of(context)!.settings.arguments as int),
        },
      ),
    );
  }
}
