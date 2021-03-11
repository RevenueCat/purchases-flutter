import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:magic_weather_flutter/src/model/constant.dart';
import 'dart:io';

class TopBar extends StatelessWidget {
  final String text;

  final TextStyle style;
  final String uniqueHeroTag;
  final Widget child;

  TopBar({
    this.text,
    this.style,
    this.uniqueHeroTag,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (!Platform.isIOS) {
      return Scaffold(
        backgroundColor: kColorPrimary,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: kColorText,
          ),
          backgroundColor: kColorNavigationBar,
          title: Text(
            text,
            style: style,
          ),
        ),
        body: child,
      );
    } else {
      return CupertinoPageScaffold(
        backgroundColor: kColorPrimary,
        navigationBar: CupertinoNavigationBar(
          backgroundColor: kColorNavigationBar,
          heroTag: uniqueHeroTag,
          border: null,
          transitionBetweenRoutes: false,
          middle: Text(
            text,
            style: style,
          ),
        ),
        child: child,
      );
    }
  }
}
