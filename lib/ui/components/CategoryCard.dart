import 'package:blife_test/ui/components/TextTitle.dart';
import 'package:blife_test/utils/colors.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget{
  final TextTitle? text;
  final Color? bg;
  final Function() onTap;

  const CategoryCard({
    Key? key,
    required this.text,
    this.bg,
    required this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: onTap,
      child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      margin: const EdgeInsets.only(right: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: DeepPurpleColor,
      ),
      child: text,
    )
    );
  }
}