import 'package:flutter/material.dart';
import 'package:weather_app_using_bloc/weather.screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather app using Flutter Bloc',
      theme: ThemeData.dark(),
      home: WeatherScreen(),
    );
  }
}
