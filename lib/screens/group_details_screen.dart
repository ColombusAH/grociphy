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
  List<ProductInList> products = [];
  List<ProductInList> grabbedProducts = [];

  @override
  void initState() {
    super.initState();
    // Initialize availableProducts with widget.group.products
    products = List.from(widget.group.products);
  }

  void moveProductToGrabbed(ProductInList product) {
    if (!grabbedProducts.contains(product)) {
      setState(() {
        grabbedProducts.add(product);
        products.removeWhere((p) => p.name == product.name);
      });
    }
  }

  void moveProductToAvailable(ProductInList product) {
    if (!products.contains(product)) {
      setState(() {
        products.add(product);
        grabbedProducts.removeWhere((p) => p.name == product.name);
      });
    }
  }

  Widget buildDraggableProductItem(ProductInList product,
      {required Function(ProductInList) onDragged}) {
    return Draggable<ProductInList>(
      data: product,
      feedback: Card(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 150, maxHeight: 60),
          child: ListTile(
            title: Text(product.name),
          ),
        ),
      ),
      childWhenDragging: Opacity(
        opacity: 0.5,
        child: ListTile(
          title: Text(product.name),
          subtitle: Text(product.description),
        ),
      ),
      onDragCompleted: () => onDragged(product),
      child: ListTile(
        title: Text(product.name),
        subtitle: Text(product.description),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.group.name),
      ),
      body: Row(
        children: [
          // 'Available Products' Column
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Products',
                      style: Theme.of(context).textTheme.headline6),
                ),
                Expanded(
                  child: DragTarget<ProductInList>(
                    onAccept: moveProductToAvailable,
                    builder: (context, candidateData, rejectedData) {
                      return ListView.builder(
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return buildDraggableProductItem(product,
                              onDragged: moveProductToGrabbed);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          // 'Grabbed Products' Column
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Grabbed',
                      style: Theme.of(context).textTheme.headline6),
                ),
                Expanded(
                  child: DragTarget<ProductInList>(
                    onAccept: moveProductToGrabbed,
                    builder: (context, candidateData, rejectedData) {
                      return ListView.builder(
                        itemCount: grabbedProducts.length,
                        itemBuilder: (context, index) {
                          final product = grabbedProducts[index];
                          return buildDraggableProductItem(product,
                              onDragged: moveProductToAvailable);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Stack(
        children: [
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
