import 'package:flutter/material.dart';

class SideBarButton extends StatefulWidget {
  String buttonText;
  int itemindex;

  SideBarButton(this.buttonText, this.itemindex);

  @override
  _SideBarButtonState createState() => _SideBarButtonState();
}

class _SideBarButtonState extends State<SideBarButton> {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {},
      child: Padding(
        padding: const EdgeInsets.only(top: 15, bottom: 15),
        child: Text(
          widget.buttonText,
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
