import 'package:flutter/material.dart';
import '/widget/list_item_tile.dart';
import 'model/item.dart';
import 'widget/add_item_form.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Item> _shopItems = <Item>[];
  /* Item(
      name: "Item 5",
      unitPrice: 12,
      quantity: 2,
    ),
    Item(
      name: "Item 2",
      unitPrice: 1,
      quantity: 20,
    ), */

  void addItem(Item item, int? index) {
    setState(() {
      //EDIT
      if (index != null) {
        _shopItems[index] = item;
      }
      //ADD
      else {
        _shopItems.add(item);
      }
      Navigator.of(context).pop();
    });
  }

  void _sortItems() {
    _shopItems.sort((a, b) {
      if (a.isChecked) {
        return 1;
      } else if (b.isChecked) {
        return -1;
      } else {
        return compareAlphabethically(a, b);
      }
    });
  }

  int compareAlphabethically(Item a, Item b) {
    return a.name.compareTo(b.name);
  }

  void showBottomSheet({Item? item, int? index}) {
    showModalBottomSheet(
      context: context,
      builder: (context) => BottomSheet(
        builder: (_) {
          return SizedBox(
            height: 370,
            child: AddItemForm(
              newItemAdded: (item, idx) => addItem(item, index),
              item: item,
            ),
          );
        },
        onClosing: () {},
      ),
    );
  }

  void deleteitem(int index) {
    setState(() {
      _shopItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    _sortItems();
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: const Text(
            "Shopping List",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
            ),
          ),
        ),
        body: Column(
          children: [
            _shopItems.isNotEmpty
                ? Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 3,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        "Tap an Item to Edit it, Long Press to Delete",
                        style: TextStyle(
                          fontSize: 12,
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
                  )
                : Container(),
            Expanded(
              child: _shopItems.isNotEmpty
                  ? Container(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: ListView.separated(
                        itemBuilder: (context, index) => ListItemTile(
                          item: _shopItems[index],
                          onChanged: (value) {
                            setState(() {
                              _shopItems[index].isChecked = value!;
                            });
                          },
                          editItem: () => showBottomSheet(
                            item: _shopItems[index],
                            index: index,
                          ),
                          deleteItem: () => deleteitem(index),
                        ),
                        separatorBuilder: (context, index) {
                          return const Divider(thickness: 1.7);
                        },
                        itemCount: _shopItems.length,
                      ),
                    )
                  : const Center(
                      child: Text("There's nothing on your list yet...",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black54,
                            fontStyle: FontStyle.italic,
                          )),
                    ),
            ),
            _shopItems.isNotEmpty
                ? SizedBox(
                    height: 35,
                    child: Text(
                      "TOTAL: \$${getTotalItemCost().toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : Container(),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(10),
              child: GestureDetector(
                onTap: () {
                  showBottomSheet();
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Center(
                      child: Text(
                    "Add An Item",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  )),
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ));
  }

  double getTotalItemCost() {
    double total = 0.0;
    for (var item in _shopItems) {
      if (!item.isChecked) {
        total += item.total;
      }
    }

    return total;
  }
}
