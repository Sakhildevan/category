import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/model/category_model.dart';
import '../data/repository/product_repository.dart';

class CategoryBloc extends Cubit<List<Category>> {
  final ProductRepository repository;
  CategoryBloc(this.repository) : super([]);

  Future<void> fetchCategories() async {
    try {
      final categories = await repository.fetchCategories();
      emit(categories);
    } catch (e) {
      print('Error fetching categories: $e');
    }
  }
}
