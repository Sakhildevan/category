import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import '../../data/model/product_model.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: CachedNetworkImage(
              imageUrl: product.image,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder:
                  (context, url) => Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(color: Colors.white),
                  ),
              errorWidget:
                  (context, url, error) =>
                      Image.asset("assets/image/No_Image.jpg"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "₹${product.discountPrice}",
                  style: const TextStyle(color: Colors.green),
                ),
                Text(
                  "₹${product.price}",
                  style: const TextStyle(
                    decoration: TextDecoration.lineThrough,
                    color: Colors.grey,
                  ),
                ),
                ElevatedButton(
                  onPressed: product.status ? () {} : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        product.status ? Colors.green : Colors.grey,
                  ),
                  child: Text(product.status ? "ADD" : "Unavailable"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
