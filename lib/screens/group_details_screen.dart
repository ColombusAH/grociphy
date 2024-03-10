import 'package:flutter/material.dart';
import 'package:flutter_first_app/models/group.dart';
import 'package:flutter_first_app/models/product_in_list.dart'; // Define your group model based on the JSON

class GroupDetailsScreen extends StatefulWidget {
  final Group group;

  GroupDetailsScreen({required this.group});

  @override
  State<GroupDetailsScreen> createState() => _GroupDetailsScreenState();
}

class _GroupDetailsScreenState extends State<GroupDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.group.name),
      ),
      body: ListView.builder(
        itemCount: widget.group.products
            .length, // Assuming 'products' is a list of product categories
        itemBuilder: (context, index) {
          final category = widget.group.products[index].category;
          final products = widget.group.products;
          return ExpansionTile(
            initiallyExpanded: true,
            title: Text(category.name,
                style: TextStyle(fontWeight: FontWeight.bold)),
            children: products.map<Widget>((product) {
              return ListTile(
                title: Text(product.name),
                subtitle: Text(product.description),
                trailing: ProductInteractionButtons(product: product),
                // Additional UI elements for interaction
              );
            }).toList(),
          );
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // Logic to add a new product
      //   },
      //   child: Icon(Icons.add),
      // ),
      floatingActionButton: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            bottom: 80,
            right: 15,
            child: FloatingActionButton(
              onPressed: () {
                // Logic to navigate to the cart
              },
              child: Icon(Icons.shopping_cart),
            ),
          ),
          Positioned(
            bottom: 15,
            right: 15,
            child: FloatingActionButton(
              onPressed: () {
                // Logic to add a new product
              },
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}

class ProductInteractionButtons extends StatelessWidget {
  final ProductInList product;

  ProductInteractionButtons({required this.product});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(Icons.remove),
          onPressed: () {
            // Decrease product quantity
          },
        ),
        Text('${product.quantity}'),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            // Increase product quantity
          },
        ),
        IconButton(
          icon: Icon(Icons.check_circle_outline),
          onPressed: () {
            // Mark the product as acquired
          },
        ),
      ],
    );
  }
}
