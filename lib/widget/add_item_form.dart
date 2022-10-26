import 'package:flutter/material.dart';
import '../model/item.dart';

class AddItemForm extends StatefulWidget {
  final void Function(Item, int?) newItemAdded;
  final Item? item;
  final int? index;
  const AddItemForm(
      {Key? key, required this.newItemAdded, this.item, this.index})
      : super(key: key);
  _AddItemFormState createState() => _AddItemFormState();
}

class _AddItemFormState extends State<AddItemForm> {
  final _formKey = GlobalKey<FormState>();

  String? name;
  int? quantity;
  double? unitPrice;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 3,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  widget.item != null ? "Edit Item" : "Create New Item",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    height: 3,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            TextFormField(
              initialValue: widget.item != null ? widget.item!.name : "",
              validator: validateName,
              decoration: InputDecoration(
                hintText: "Enter the Name of the Item",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                label: Text("Name"),
              ),
              onSaved: (newValue) {
                name = newValue;
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              initialValue:
                  widget.item != null ? widget.item!.unitPrice.toString() : "",
              validator: validatePrice,
              decoration: InputDecoration(
                hintText: "Enter the Unit Price",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                label: Text("Unit Price"),
              ),
              onSaved: (newValue) {
                unitPrice = double.parse(newValue.toString());
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              initialValue:
                  widget.item != null ? widget.item!.quantity.toString() : "1",
              validator: validateQuantity,
              decoration: InputDecoration(
                hintText: "Enter the Quantity to be bought",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                label: Text("Quantity"),
              ),
              onSaved: (newValue) {
                quantity = int.parse(newValue.toString());
              },
            ),
            Expanded(child: const SizedBox(height: 15)),
            GestureDetector(
              onTap: onFormSubmit,
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                    child: Text(
                  widget.item != null ? "Save Changes" : "Add Item",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                )),
              ),
            ),
            /* ElevatedButton(
              child: Center(
                  child: Text(
                "ADD TO LIST",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),
              )),
              onPressed: onFormSubmit,
            ), */
          ],
        ),
      ),
    );
  }

  String? validateName(String? value) {
    if (value!.isEmpty) {
      return "Enter a Name";
    }
    return null;
  }

  String? validateQuantity(String? value) {
    RegExp reg = RegExp(r"^[0-9]+$");
    if (reg.hasMatch(value.toString()) && double.parse(value.toString()) > 0) {
      return null;
    }
    return "Invalid Quantity";
  }

  String? validatePrice(String? value) {
    RegExp reg = RegExp(r"^[1-9]\d*(\.\d+)?$");
    if (reg.hasMatch(value.toString()) && double.parse(value.toString()) > 0) {
      return null;
    }
    return "Invalid Price";
  }

  void onFormSubmit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      Item newItem = Item(
        name: name.toString(),
        unitPrice: unitPrice!,
        quantity: quantity!,
        isChecked: widget.item != null ? widget.item!.isChecked : false,
      );

      widget.newItemAdded(newItem, widget.index);
    }
  }
}
