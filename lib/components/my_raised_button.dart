import 'package:flutter/material.dart';
class MyRaisedButton extends StatelessWidget{

  MyRaisedButton({this.color, this.title, @required this.onPressed, this.padding = 16});
  final Color color;
  final String title;
  final Function onPressed;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        padding: EdgeInsets.all(padding),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8)),
        color: color,
        textColor: Colors.white,
        child: Text(this.title),
        onPressed: onPressed
    );
  }
}