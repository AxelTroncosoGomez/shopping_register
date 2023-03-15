import 'package:flutter/material.dart';

void main() => runApp(
    const MyApp()
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Shopping Cart',
      home: ShoppingCart(),
    );
  }
}

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({super.key});

  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  List<Product> products = [];

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.pink[800],
          hintColor: Colors.blue[800],
        ),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Compras del super'),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.calculate),
                onPressed: () {
                  final totalSpend = _calculateTotalSpend();
                  final snackBar = SnackBar(
                    content: Text('Valor total: \$$totalSpend'),
                    duration: const Duration(seconds: 2),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
              )
            ],
          ),
          body: Column(
            children: <Widget>[
              _buildTableHeader(),
              Expanded(child: _buildTableBody()),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              setState(() {
                products.add(Product());
              });
            },
            child: const Icon(Icons.add),
          ),
        )
    );
  }

  Widget _buildTableHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8
      ),
      decoration: BoxDecoration(
        color: Colors.blue[800],
      ),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(
              left: 20.0,
              right: 20.0,
            ),
            child: const Text(
              "Producto",
              style: TextStyle(
                  fontSize: 16.0,
                  color: Color.fromARGB(238,244,240,255)
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              left: 55.0,
              right: 30.0,
            ),
            child: const Text(
              "Cantidad",
              style: TextStyle(
                  fontSize: 16.0,
                  color: Color.fromARGB(238,244,240,255)
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              left: 50.0,
            ),
            child: const Text(
              "Precio",
              style: TextStyle(
                  fontSize: 16.0,
                  color: Color.fromARGB(238,244,240,255)
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableBody() {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        return Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                maxLines: null,
                style: const TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
                textAlignVertical: TextAlignVertical.center,
                onChanged: (value) => products[index].name = value,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue, // set the color of the border
                      width: 0.5, // set the width of the border
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: TextField(
                maxLines: null,
                style: const TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
                textAlignVertical: TextAlignVertical.center,
                keyboardType: TextInputType.number,
                onChanged: (value) =>
                products[index].amount = int.tryParse(value) ?? 1,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue, // set the color of the border
                      width: 0.5, // set the width of the border
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: TextField(
                maxLines: null,
                style: const TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
                textAlignVertical: TextAlignVertical.center,
                keyboardType: TextInputType.number,
                onChanged: (value) =>
                products[index].price = double.tryParse(value) ?? 0,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue, // set the color of the border
                      width: 0.5, // set the width of the border
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  double _calculateTotalSpend() {
    double total = 0.0;
    for (var product in products) {
      total += product.amount * product.price;
    }
    return total;
  }
}

class Product {
  String name = '';
  int amount = 0;
  double price = 0.0;
}
