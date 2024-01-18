
import 'package:flutter/material.dart';

class ProductPicture extends StatelessWidget{
  final NetworkImage image;

  const ProductPicture({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        image: DecorationImage(image: image,
        fit: BoxFit.contain),
      ),
    );
  }
}