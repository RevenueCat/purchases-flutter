import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:magic_weather_flutter/src/model/styles.dart';
import 'package:magic_weather_flutter/src/views/home.dart';

class MagicWeatherFlutter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      localizationsDelegates: [
        DefaultMaterialLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      theme: CupertinoThemeData(
        barBackgroundColor: kColorBar,
        primaryColor: kColorText,
        textTheme: CupertinoTextThemeData(
          primaryColor: kColorText,
        ),
      ),
      home: AppContainer(),
    );
  }
}
