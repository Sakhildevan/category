import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../data/model/product_model.dart';
import '../data/repository/product_repository.dart';

// Define Product States
abstract class ProductState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> products;
  ProductLoaded(this.products);

  @override
  List<Object?> get props => [products];
}

class ProductError extends ProductState {
  final String message;
  ProductError(this.message);

  @override
  List<Object?> get props => [message];
}

// BLoC Implementation
class ProductBloc extends Cubit<ProductState> {
  final ProductRepository repository;

  ProductBloc(this.repository) : super(ProductInitial());

  Future<void> fetchProducts(String categoryId, int page) async {
    try {
      emit(ProductLoading());
      final products = await repository.fetchProducts(categoryId, page);
      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductError('Error fetching products: $e'));
    }
  }
}
