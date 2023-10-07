import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class CartItem {
  String productName;
  String options;
  int quantity;
  int price;
  String imageAsset;

  CartItem({
    required this.productName,
    required this.options,
    required this.quantity,
    required this.price,
    required this.imageAsset,
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<CartItem> cartItems = [
    CartItem(
      productName: "Pullover",
      options: "Color: Grey  Size: L",
      quantity: 1,
      price: 40,
      imageAsset: 'assets/pullover.png',
    ),
    CartItem(
      productName: "T-Shirt",
      options: "Color: Black  Size: M",
      quantity: 1,
      price: 35,
      imageAsset: 'assets/tshirt.png',
    ),
    CartItem(
      productName: "Sport Dress",
      options: "Color: Blue  Size: XL",
      quantity: 1,
      price: 50,
      imageAsset: 'assets/jersey.png',
    ),
  ];

  int calculateTotalAmount() {
    int totalAmount = 0;
    for (var item in cartItems) {
      totalAmount += item.quantity * item.price;
    }
    return totalAmount;
  }

  void increaseQuantity(int index) {
    setState(() {
      cartItems[index].quantity++;
    });
  }

  void decreaseQuantity(int index) {
    setState(() {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity--;
      }
    });
  }

  void checkout() {
    // Show a congratulatory Snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Congratulations! Your order has been placed.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 24,
          ),
          AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    // Add your search functionality here
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              "My Bag",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final cartItem = cartItems[index];
                return CartBox(
                  productName: cartItem.productName,
                  options: cartItem.options,
                  price: cartItem.price,
                  quantity: cartItem.quantity,
                  imageAsset: cartItem.imageAsset,
                  increaseQuantity: () => increaseQuantity(index),
                  decreaseQuantity: () => decreaseQuantity(index),
                );
              },
            ),
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total amount:",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  "\$${calculateTotalAmount()}",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Container(
            width: double.infinity,
            color: Colors.red,
            child: TextButton(
              onPressed: checkout,
              child: Text(
                "CHECK OUT",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CartBox extends StatelessWidget {
  final String productName;
  final String options;
  final int price;
  final int quantity;
  final String imageAsset;
  final VoidCallback increaseQuantity;
  final VoidCallback decreaseQuantity;

  CartBox({
    required this.productName,
    required this.options,
    required this.price,
    required this.quantity,
    required this.imageAsset,
    required this.increaseQuantity,
    required this.decreaseQuantity,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Image.asset(
            imageAsset,
            width: 80,
            height: 80,
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  options,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: decreaseQuantity,
                        ),
                        Text(
                          "$quantity",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: increaseQuantity,
                        ),
                      ],
                    ),
                    Text(
                      "\$$price",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
