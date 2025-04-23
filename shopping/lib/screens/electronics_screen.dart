import 'package:flutter/material.dart';
import '../data/dummy_data.dart';

class ElectronicsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final products = dummyProducts['electronics']!;
    return Scaffold(
      appBar: AppBar(title: Text('Electronics')),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder:
            (ctx, i) => ListTile(
              leading: Image.network(products[i].imageUrl, width: 50),
              title: Text(products[i].name),
              subtitle: Text('\$${products[i].price}'),
            ),
      ),
    );
  }
}
