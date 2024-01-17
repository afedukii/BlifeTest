import 'package:blife_test/ui/components/TextTitle.dart';
import 'package:flutter/material.dart';

class MainButton extends StatelessWidget{
  final TextTitle? text;
  final Color? bg;
  final Function() onTap;
  final double? width;
  final double? height;
  
  const MainButton({
    Key? key,
    required this.text,
    this.bg,
    required this.onTap,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: bg
        ),
        child: text,
      ),
    );
  }
}