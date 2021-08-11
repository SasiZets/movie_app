import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  final IconData iconData;
  final String text;
  const DrawerTile({Key? key, required this.iconData, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.grey.shade900,
      child: InkWell(
        onTap: () {},
        splashColor: Colors.white.withOpacity(0.6),
        child: ListTile(
          leading: Icon(
            iconData,
            color: Colors.blueGrey,
          ),
          title: Text(
            text,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
