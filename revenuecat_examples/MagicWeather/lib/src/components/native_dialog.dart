import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class ShowDialogToDismiss extends StatelessWidget {
  final String content;
  final String title;
  final String buttonText;

  const ShowDialogToDismiss(
      {Key? key,
      required this.title,
      required this.buttonText,
      required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!Platform.isIOS) {
      return AlertDialog(
        title: Text(
          title,
        ),
        content: Text(
          content,
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              buttonText,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    } else {
      return CupertinoAlertDialog(
          title: Text(
            title,
          ),
          content: Text(
            content,
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text(
                buttonText[0].toUpperCase() +
                    buttonText.substring(1).toLowerCase(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ]);
    }
  }
}
