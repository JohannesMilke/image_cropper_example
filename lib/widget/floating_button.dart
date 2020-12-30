import 'package:flutter/material.dart';

class FloatingButtonWidget extends StatelessWidget {
  final VoidCallback onClicked;

  const FloatingButtonWidget({
    Key key,
    @required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 2, color: Theme.of(context).accentColor),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Icon(Icons.add, color: Theme.of(context).accentColor),
        onPressed: onClicked,
      );
}
