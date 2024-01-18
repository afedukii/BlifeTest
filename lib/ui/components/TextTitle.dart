import 'package:flutter/material.dart';

class TextTitle extends StatelessWidget {
  final String? title;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;

  const TextTitle({
    Key? key,
    required this.title,
    this.color,
    required this.fontSize,
    required this.fontWeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Text(
      title!,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}