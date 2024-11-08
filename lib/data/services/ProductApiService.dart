import 'dart:convert';

import 'package:rimstore/data/models/cart.dart';
import 'package:rimstore/data/models/category.dart';
import 'package:rimstore/data/models/product.dart';
import 'package:rimstore/data/services/ApiClient.dart';

class ProductApiService {
  final ApiClient _apiClient = ApiClient();

  Future<List<Product>> fetchProducts({int? limit}) async {
    String endpoint = '/products';
    if (limit != null) {
      endpoint += '?limit=$limit';
    }
    final response = await _apiClient.get(endpoint);
    return (jsonDecode(response.body) as List)
        .map((data) => Product.fromJson(data))
        .toList();
  }

  Future<Product> fetchProductById(int id) async {
    final response = await _apiClient.get('/products/$id');
    return Product.fromJson(jsonDecode(response.body));
  }

  Future<List<Category>> fetchCategories() async {
    final response = await _apiClient.get('/products/categories');
    return (jsonDecode(response.body) as List)
        .map((name) => Category.fromJson(name))
        .toList();
  }

  Future<List<Product>> fetchProductsByCategory(String category) async {
    final response = await _apiClient.get('/products/category/$category');
    return (jsonDecode(response.body) as List)
        .map((data) => Product.fromJson(data))
        .toList();
  }

  Future<Cart> fetchCartByUserId(int userId) async {
    final response = await _apiClient.get('/carts?userId=$userId');
    return Cart.fromJson(jsonDecode(response.body)[0]);
  }

  Future<Product> addProduct(Product product) async {
    final response = await _apiClient.post('/products', {
      'title': product.title,
      'price': product.price,
      'description': product.description,
      'image': product.image,
      'category': product.category
    });
    return Product.fromJson(jsonDecode(response.body));
  }
}
