import 'package:flutter/material.dart';
import '../model/item.dart';

class ListItemTile extends StatelessWidget {
  const ListItemTile({
    Key? key,
    required this.item,
    required this.onChanged,
    required this.editItem,
    required this.deleteItem,
  }) : super(key: key);
  final Item item;
  final void Function(bool? value)? onChanged;
  final void Function() editItem;
  final void Function() deleteItem;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: editItem,
      onLongPress: deleteItem,
      leading: Checkbox(
        value: item.isChecked,
        onChanged: onChanged,
      ),
      title: Text(
        item.name,
        style: TextStyle(
          fontSize: 18,
          decoration:
              item.isChecked ? TextDecoration.lineThrough : TextDecoration.none,
        ),
      ),
      subtitle: Text("x${item.quantity}"),
      trailing: Column(
        children: [
          Text("Unit Price: \$${item.unitPrice}"),
          Text(
            "Total: \$${(item.unitPrice * item.quantity).toStringAsFixed(2)}",
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
