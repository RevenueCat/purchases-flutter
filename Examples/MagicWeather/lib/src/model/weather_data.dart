import 'package:flutter/material.dart';
import 'dart:math';

import 'package:magic_weather_flutter/src/model/styles.dart';

enum TemperatureUnit { f, c }
enum Environment {
  mercury,
  venus,
  earth,
  mars,
  jupiter,
  saturn,
  uranus,
  neptune,
  pluto
}

class WeatherData {
  String emoji;
  Color weatherColor;
  String temperature;
  TemperatureUnit unit;
  Environment environment;

  WeatherData(
      {this.emoji,
      this.weatherColor,
      this.temperature,
      this.unit,
      this.environment});

  static WeatherData testCold = WeatherData(
      emoji: "🥶",
      weatherColor: kWeatherReallyCold,
      temperature: "14",
      unit: TemperatureUnit.f,
      environment: Environment.earth);

  static generateData() {
    final int min = -20;
    final int max = 120;
    final int randomTemperature = min + (Random().nextInt(max - min));

    String temperature = randomTemperature.toString();
    String emoji = "🥶";
    Color weatherColor = kWeatherReallyCold;

    if (randomTemperature < 0) {
      emoji = "🥶";
      weatherColor = kWeatherReallyCold;
    } else if (randomTemperature < 32) {
      emoji = "❄️";
      weatherColor = kWeatherCold;
    } else if (randomTemperature < 60) {
      emoji = "☁️";
      weatherColor = kWeatherCloudy;
    } else if (randomTemperature < 90) {
      emoji = "🌤";
      weatherColor = kWeatherSunny;
    } else if (randomTemperature < 129) {
      emoji = "🥵";
      weatherColor = kWeatherHot;
    } else {
      emoji = "☄️";
      weatherColor = kWeatherReallyHot;
    }

    return WeatherData(
        emoji: emoji,
        weatherColor: weatherColor,
        temperature: temperature,
        unit: TemperatureUnit.f,
        environment: Environment.earth);
  }
}
