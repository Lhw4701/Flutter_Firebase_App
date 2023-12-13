import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final IconData prefixIcon;
  final String labelText;
  final bool obscureText;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.prefixIcon,
    required this.labelText,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(40, 10, 0, 10),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(
            prefixIcon,
            color: Colors.white,
          ),
          labelText: labelText,
          labelStyle: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
class ItemDialog extends StatelessWidget {
  final TextEditingController itemController;
  final TextEditingController priceController;
  final Function(String?, String) onAddItem;

  const ItemDialog({
    Key? key,
    required this.itemController,
    required this.priceController,
    required this.onAddItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            key: const Key("item"),
            controller: itemController,
            decoration: const InputDecoration(labelText: "Item"),
          ),
          TextField(
            key: const Key("price"),
            controller: priceController,
            decoration: const InputDecoration(labelText: "Price"),
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          key: const Key("add"),
          onPressed: () {
            onAddItem(itemController.text, priceController.text);
            Navigator.pop(context);
          },
          child: const Text("Add"),
        ),
      ],
    );
  }
}
class ItemList extends StatelessWidget {
  final List<QueryDocumentSnapshot<Object?>> itemsList;
  final Function(String?) onEditItem;
  final Function(String) onDeleteItem;

  const ItemList({
    Key? key,
    required this.itemsList,
    required this.onEditItem,
    required this.onDeleteItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemsList.length,
      itemBuilder: (context, index) {
        QueryDocumentSnapshot<Object?> document = itemsList[index];
        String docID = document.id;
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        String itemText = data['item'] as String;
        String priceText = data['price'] as String;

        return Container(
          margin: const EdgeInsets.all(30.0),
          padding: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.blueAccent,
          ),
          child: ListTile(
            title: Column(
              children: [
                Text(
                  "Item: $itemText",
                  style: CustomTextStyle.txtweight,
                ),
                Text(
                  "Price: $priceText \$",
                  style: CustomTextStyle.txtweight,
                ),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () => onEditItem(docID),
                  icon: const Icon(Icons.settings),
                ),
                IconButton(
                  onPressed: () => onDeleteItem(docID),
                  icon: const Icon(Icons.delete),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
class CustomTextStyle {
  static const TextStyle txtweight = TextStyle(
    fontWeight: FontWeight.bold,
  );
}
class ItemChecker{
  String item="";
  String price="";
}