import '../models/product.dart';

final Map<String, List<Product>> dummyProducts = {
  'home_decor': [
    Product(
      id: 'h1',
      name: 'Cushion',
      price: 20.0,
      imageUrl: 'https://via.placeholder.com/150',
    ),
    Product(
      id: 'h2',
      name: 'Lamp',
      price: 35.5,
      imageUrl: 'https://via.placeholder.com/150',
    ),
  ],
  'electronics': [
    Product(
      id: 'e1',
      name: 'Smart TV',
      price: 500.0,
      imageUrl: 'https://via.placeholder.com/150',
    ),
    Product(
      id: 'e2',
      name: 'Bluetooth Speaker',
      price: 80.0,
      imageUrl: 'https://via.placeholder.com/150',
    ),
  ],
};
