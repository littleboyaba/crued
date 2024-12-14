import 'package:crued/models/product.dart';
import 'package:crued/ui/screens/update_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.product});

  final Product product;

  Future<void> _deleteProduct(String productId) async {
    final url = Uri.parse('https://crud.teamrabbil.com/api/v1/DeleteProduct/$productId');

    print('API Endpoint URL: $url');
    print('Product ID: $productId');

    final response = await http.delete(url);

    if (response.statusCode == 200) {
      print('Product deleted successfully');
    } else {
      print('Error deleting product: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        product.image ?? '',
        width: 40,
      ),
      title: Text(product.productName ?? 'Unknown'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Product Code: ${product.productCode ?? 'Unknown'}'),
          Text('Quantity: ${product.quantity ?? 'Unknown'}'),
          Text('Price: ${product.unitPrice ?? 'Unknown'}'),
          Text('Total Price: ${product.totalPrice ?? 'Unknown'}'),
        ],
      ),
      trailing: Wrap(
        children: [
          IconButton(
            onPressed: () {
              _deleteProduct(product.id!);
            },
            icon: const Icon(Icons.delete),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                UpdateProductScreen.name,
                arguments: product,
              );
            },
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
    );
  }
}