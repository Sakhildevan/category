import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String id;
  final String title;
  final String image;
  final bool isSelected;

  Category({required this.id, required this.title, required this.image, required this.isSelected});

  @override
  List<Object?> get props => [id, title, image, isSelected];
}