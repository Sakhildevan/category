import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/product_bloc.dart';
import '../../data/model/category_model.dart';
import '../widgets/product_card.dart';

class ProductPage extends StatelessWidget {
  final Category category;

  const ProductPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 5,
      child: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductLoaded) {
            return GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: state.products.length,
              itemBuilder:
                  (context, index) =>
                      ProductCard(product: state.products[index]),
            );
          } else if (state is ProductError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text("No products available"));
          }
        },
      ),
    );
  }
}
