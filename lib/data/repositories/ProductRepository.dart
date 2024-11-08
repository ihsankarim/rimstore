import 'package:rimstore/data/models/cart.dart';
import 'package:rimstore/data/models/category.dart';
import 'package:rimstore/data/models/product.dart';
import 'package:rimstore/data/services/ProductApiService.dart';

class ProductRepository {
  final ProductApiService _productApiService = ProductApiService();

  Future<List<Product>> getProducts({int? limit}) async {
    return await _productApiService.fetchProducts(limit: limit);
  }

  Future<Product> getProductById(int id) async {
    return await _productApiService.fetchProductById(id);
  }

  Future<List<Category>> getCategories() async {
    return await _productApiService.fetchCategories();
  }

  Future<List<Product>> getProductsByCategory(String category) async {
    return await _productApiService.fetchProductsByCategory(category);
  }

  Future<Cart> getCartByUserId(int userId) async {
    return await _productApiService.fetchCartByUserId(userId);
  }

  Future<Product> addProduct(Product product) async {
    return await _productApiService.addProduct(product);
  }
}
