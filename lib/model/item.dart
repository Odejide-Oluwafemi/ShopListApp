class Item {
  final String name;
  final int quantity;
  final double unitPrice;
  double get total => quantity * unitPrice;
  bool isChecked;

  Item({
    required this.name,
    required this.unitPrice,
    this.quantity = 1,
    this.isChecked = false,
  });
}
