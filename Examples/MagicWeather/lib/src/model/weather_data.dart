import 'package:flutter/material.dart';
import 'dart:math';

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
      weatherColor: Color.fromRGBO(3, 75, 132, 1),
      temperature: "14",
      unit: TemperatureUnit.f,
      environment: Environment.earth);

  static generateData() {
    final int min = -20;
    final int max = 120;
    final int randomTemperature = min + (Random().nextInt(max - min));

    String temperature = randomTemperature.toString();
    String emoji = "🥶";
    Color weatherColor = Color.fromRGBO(3, 75, 132, 1);

    if (randomTemperature < 0) {
      emoji = "🥶";
      weatherColor = Color.fromRGBO(3, 75, 132, 1);
    } else if (randomTemperature < 32) {
      emoji = "❄️";
      weatherColor = Color.fromRGBO(0, 39, 96, 1);
    } else if (randomTemperature < 60) {
      emoji = "☁️";
      weatherColor = Color.fromRGBO(51, 0, 58, 1);
    } else if (randomTemperature < 90) {
      emoji = "🌤";
      weatherColor = Color.fromRGBO(212, 70, 62, 1);
    } else if (randomTemperature < 129) {
      emoji = "🥵";
      weatherColor = Color.fromRGBO(181, 0, 58, 1);
    } else {
      emoji = "☄️";
      weatherColor = Color.fromRGBO(204, 0, 58, 1);
    }

    return WeatherData(
        emoji: emoji,
        weatherColor: weatherColor,
        temperature: temperature,
        unit: TemperatureUnit.f,
        environment: Environment.earth);
  }
}
