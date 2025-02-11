import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../model/category_model.dart';
import '../model/product_model.dart';

class ProductRepository {
  final Dio _dio = Dio();

  Future<List<Category>> fetchCategories() async {
    final response = await _dio.get(
      'https://alpha.bytesdelivery.com/api/v3/product/category-products/123/null/1',
    );
    return (response.data['data']['categories'] as List)
        .map(
          (e) => Category(
            id: e['_id'],
            title: e['title'],
            image: e['image'],
            isSelected: e['isSelected'],
          ),
        )
        .toList();
  }

  Future<List<Product>> fetchProducts(String categoryId, int page) async {
    final response = await _dio.get(
      '${dotenv.env['API_BASE_URL']}/product/category-products/123/$categoryId/$page',
    );
    return (response.data['data']['products'] as List)
        .map(
          (e) => Product(
            id: e['_id'],
            title: e['title'],
            price: e['price'].toDouble(),
            discountPrice: e['discountPrice'].toDouble(),
            image: e['image'][0]['url'],
            status: e['status'],
          ),
        )
        .toList();
  }
}
