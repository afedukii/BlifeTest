import 'package:blife_test/APInServices/ShoppingCart/shopcart.dart';
import 'package:blife_test/ui/components/TextTitle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SlidableCard extends StatelessWidget{
  final List<String> item;
  final int index;
  final Function() onDelete;
  const SlidableCard({
    Key? key,
    required this.item,
    required this.index,
    required this.onDelete,
  }) : super(key: key);
  @override
  Widget build(BuildContext context){
    return Slidable(
      
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            flex: 1,
            onPressed:(context) {
              onDelete();
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Eliminar',
          ),
        ],
      ),
      child: Container(
        height: 100,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: Colors.black))
        ),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                image: DecorationImage(image: NetworkImage(item[2]),
                fit: BoxFit.contain),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  child: Container(
                    height: 10,
                    width: MediaQuery.of(context).size.width*.7,
                    padding: EdgeInsets.only(right: 13.0),
                    alignment: Alignment.centerLeft,
                    child: TextTitle(title: "${item[0]}", fontSize: 12.0, fontWeight: FontWeight.normal),
                  ),
                ),
                TextTitle(title: "Sub total: \$${item[1]}", fontSize: 12.0, fontWeight: FontWeight.normal)
              ],
            )
          ],
        ),
      ),
      
    );
  }
}