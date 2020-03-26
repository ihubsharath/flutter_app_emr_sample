import 'package:flutter/material.dart';

class SearchBox extends StatefulWidget {
  String hintText;

  SearchBox(this.hintText);

  @override
  _SearchBoxState createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.all(Radius.circular(5)),
            border: Border.all(
                width: 1,
                color: Colors.grey.shade400,
                style: BorderStyle.solid)),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Text(
                    widget.hintText,
                    style: TextStyle(
                        color: Colors.grey.shade500,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              Icon(Icons.search),
            ],
          ),
        ),
      ),
    );
  }
}
