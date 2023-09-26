import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<Product> products = [
    Product(name: 'Product 1', price: 10),
    Product(name: 'Product 2', price: 20),
    Product(name: 'Product 3', price: 30),
    // Add more products as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              int totalProductsBought = products
                  .map((product) => product.count)
                  .reduce((a, b) => a + b);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartPage(totalProductsBought: totalProductsBought),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(products[index].name),
            subtitle: Text('\$${products[index].price.toStringAsFixed(2)}'),
            trailing: BuyButton(
              product: products[index],
              onBuy: () {
                setState(() {
                  products[index].incrementCount();
                  if (products[index].count == 5) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Congratulations!'),
                          content: Text('You\'ve bought 5 ${products[index].name}!'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                });
              },
            ),
          );
        },
      ),
    );
  }
}

class Product {
  final String name;
  final double price;
  int count = 0;

  Product({required this.name, required this.price});

  void incrementCount() {
    count++;
  }
}

class BuyButton extends StatelessWidget {
  final Product product;
  final VoidCallback onBuy;

  BuyButton({required this.product, required this.onBuy});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onBuy,
      child: Text('Buy Now (${product.count})'),
    );
  }
}

class CartPage extends StatelessWidget {
  final int totalProductsBought;

  CartPage({required this.totalProductsBought});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart Page'),
      ),
      body: Center(
        child: Text('Total Products Bought: $totalProductsBought'),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProductList(),
    );
  }
}
