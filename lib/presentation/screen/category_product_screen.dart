import 'package:category/presentation/screen/product_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/category_bloc.dart';
import '../../bloc/product_bloc.dart';
import '../../data/model/category_model.dart';
import 'category_page.dart';

class CategoryProductScreen extends StatefulWidget {
  const CategoryProductScreen({super.key});

  @override
  CategoryProductScreenState createState() => CategoryProductScreenState();
}

class CategoryProductScreenState extends State<CategoryProductScreen> {
  late CategoryBloc _categoryBloc;
  late ProductBloc _productBloc;
  String? selectedCategoryId;
  Category? selectedCategory;
  int currentPage = 1;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _categoryBloc = context.read<CategoryBloc>();
    _productBloc = context.read<ProductBloc>();
    _scrollController = ScrollController()..addListener(_onScroll);

    _categoryBloc.fetchCategories().then((_) {
      if (_categoryBloc.state.isNotEmpty) {
        setState(() {
          selectedCategory = _categoryBloc.state.first;
          selectedCategoryId = selectedCategory!.id;
        });
        _productBloc.fetchProducts(selectedCategoryId!, currentPage);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      _loadMoreProducts();
    }
  }

  void _onCategorySelected(Category category) {
    setState(() {
      selectedCategory = category;
      selectedCategoryId = category.id;
      currentPage = 1;
    });
    _productBloc.fetchProducts(selectedCategoryId!, currentPage);
  }

  void _loadMoreProducts() {
    setState(() => currentPage++);
    _productBloc.fetchProducts(selectedCategoryId!, currentPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Category & Products")),
      body: Row(
        children: [
          CategoryPage(
            selectedCategoryId: selectedCategoryId,
            onCategorySelected: _onCategorySelected,
          ),
          selectedCategory != null
              ? ProductPage(category: selectedCategory!)
              : const Expanded(child: Center(child: CircularProgressIndicator())),
        ],
      ),
    );
  }
}
