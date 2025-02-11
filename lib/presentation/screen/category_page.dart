import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../bloc/category_bloc.dart';
import '../../data/model/category_model.dart';

class CategoryPage extends StatelessWidget {
  final String? selectedCategoryId;
  final Function(Category) onCategorySelected;

  const CategoryPage({
    super.key,
    required this.selectedCategoryId,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: BlocBuilder<CategoryBloc, List<Category>>(
        builder: (context, categories) {
          if (categories.isEmpty)
            return const Center(child: CircularProgressIndicator());
          return ListView.builder(
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return GestureDetector(
                onTap: () => onCategorySelected(category),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color:
                        category.id == selectedCategoryId
                            ? Colors.green.shade100
                            : Colors.white,
                    border: Border(
                      bottom: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                  child: Column(
                    children: [
                      CachedNetworkImage(
                        imageUrl: category.image,
                        height: 40,
                        width: 40,
                        placeholder:
                            (context, url) => const CircularProgressIndicator(),
                        errorWidget:
                            (context, url, error) => const Icon(Icons.error),
                      ),
                      Text(category.title),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
