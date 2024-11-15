import 'package:flutter/material.dart';
import 'package:rimstore/data/models/cart.dart';
import 'package:rimstore/data/models/category.dart';
import 'package:rimstore/data/models/product.dart';
import 'package:rimstore/data/repositories/ProductRepository.dart';

class ProductViewModel extends ChangeNotifier {
  final ProductRepository _productRepository;

  ProductViewModel(this._productRepository);

  List<Product> _products = [];
  Product? _selectedProduct;
  bool _isLoading = false;
  List<Category> _categories = [];
  Cart? _cart;

  List<Product> get products => _products;
  Product? get selectedProduct => _selectedProduct;
  bool get isLoading => _isLoading;
  List<Category> get categories => _categories;
  Cart? get cart => _cart;


  Future<void> fetchProducts() async {
    _isLoading = true;
    notifyListeners();

    try {
      _products = await _productRepository.getProducts();
    } catch (e) {
      print('Error fetching products: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<Product> fetchProductById(int productId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _selectedProduct = await _productRepository.getProductById(productId);
      return _selectedProduct!;
    } catch (e) {
      print('Error fetching product by ID: $e');
      throw Exception('Failed to load product');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchCategories() async {
    _isLoading = true;
    notifyListeners();
    try {
      _categories = await _productRepository.getCategories();
    } catch(e) {
      print('Error fetching category');
      throw Exception('failed fetching category');
    }
  }
}
