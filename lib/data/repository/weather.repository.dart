import 'dart:convert';
import 'dart:developer';

import 'package:weather_app_using_bloc/data/data_provider/weather_data.provider.dart';
import 'package:weather_app_using_bloc/model/weather.model.dart';

class WeatherRepository {
  final WeatherDataProvider weatherDataProvider;

  WeatherRepository(this.weatherDataProvider);

  Future<WeatherModel> getCurrentWeather() async {
    try {
      String cityName = 'London';
      final weatherData = await weatherDataProvider.getCurrentWeather(cityName);

      final data = jsonDecode(weatherData);
      log(name: "Result", data.toString());
      log(name: "Result", data.runtimeType.toString());
      if (data['cod'] != '200') {
        throw 'An unexpected error occurred';
      }

      return WeatherModel.fromJson(data);
    } catch (e, stackTrace) {
      log("Error", error: e.toString(), stackTrace: stackTrace);
      throw e.toString();
    }
  }
}
