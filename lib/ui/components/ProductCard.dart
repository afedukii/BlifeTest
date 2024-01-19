import 'package:blife_test/ui/components/ProductPicture.dart';
import 'package:blife_test/ui/components/TextTitle.dart';
import 'package:blife_test/utils/colors.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget{
  final TextTitle textName;
  final TextTitle textPrice;
  final ProductPicture image;

  const ProductCard({
    Key? key,
    required this.textName,
    required this.textPrice,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Container(
      width:300,
      height: 250,
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: BlueGreyColor,
            offset: Offset(
              5.0,
              0.0,
            ),
            blurRadius: 5.0,
            spreadRadius: 2.0,
          ),
        ],
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          image,
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              textName,
              const SizedBox(height: 20,),
              textPrice
            ],
          )
        ],
      )
    );
  }
}