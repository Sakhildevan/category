import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String title;
  final double price;
  final double discountPrice;
  final String image;
  final bool status;

  Product({required this.id, required this.title, required this.price, required this.discountPrice, required this.image, required this.status});

  @override
  List<Object?> get props => [id, title, price, discountPrice, image, status];
}