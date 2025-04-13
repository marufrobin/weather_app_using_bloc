// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class WeatherModel {
  /*
  * final data = snapshot.data!;

          final currentWeatherData = data['list'][0];

          final currentTemp = currentWeatherData['main']['temp'];
          final currentSky = currentWeatherData['weather'][0]['main'];
          final currentPressure = currentWeatherData['main']['pressure'];
          final currentWindSpeed = currentWeatherData['wind']['speed'];
          final currentHumidity = currentWeatherData['main']['humidity'];
          *
          *  final hourlyForecast =data data['list'][index + 1];
                      final hourlySky =
                          data['list'][index + 1]['weather'][0]['main'];
                      final hourlyTemp =
                          hourlyForecast['main']['temp'].toString();
                      final time = DateTime.parse(hourlyForecast['dt_txt']);
  * */

  final double currentTemp;
  final String currentSky;
  final double currentPressure;
  final double currentWindSpeed;
  final double currentHumidity;
  // final String hourlyForecast;
  // final String hourlySky;
  // final double hourlyTemp;
  // final DateTime time;
  final List<HourlyWeatherModel> hourlyForecast;

  WeatherModel({
    required this.currentTemp,
    required this.currentSky,
    required this.currentPressure,
    required this.currentWindSpeed,
    required this.currentHumidity,
    required this.hourlyForecast,
  });

  WeatherModel copyWith({
    double? currentTemp,
    String? currentSky,
    double? currentPressure,
    double? currentWindSpeed,
    double? currentHumidity,
    List<HourlyWeatherModel>? hourlyForecast,
  }) {
    return WeatherModel(
      currentTemp: currentTemp ?? this.currentTemp,
      currentSky: currentSky ?? this.currentSky,
      currentPressure: currentPressure ?? this.currentPressure,
      currentWindSpeed: currentWindSpeed ?? this.currentWindSpeed,
      currentHumidity: currentHumidity ?? this.currentHumidity,
      hourlyForecast: hourlyForecast ?? this.hourlyForecast,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'currentTemp': currentTemp,
      'currentSky': currentSky,
      'currentPressure': currentPressure,
      'currentWindSpeed': currentWindSpeed,
      'currentHumidity': currentHumidity,
      'hourlyForecast': hourlyForecast.map((x) => x.toMap()).toList(),
    };
  }

  factory WeatherModel.fromMap(Map<String, dynamic> map) {
    final currentWeatherData = map['list'][0];
    final hourlyList = (map['list'] as List).skip(1).take(8).toList();

    //  final hourlyForecast =data data['list'][index + 1];
    // final hourlySky =
    // data['list'][index + 1]['weather'][0]['main'];
    // final hourlyTemp =
    // hourlyForecast['main']['temp'].toString();
    // final time = DateTime.parse(hourlyForecast['dt_txt']);

    return WeatherModel(
      currentTemp: currentWeatherData['main']['temp'] as double,
      currentSky: currentWeatherData['weather'][0]['main'] as String,
      currentPressure: double.parse(
        currentWeatherData['main']['pressure'].toString(),
      ),
      currentWindSpeed: double.parse(
        currentWeatherData['wind']['speed'].toString(),
      ),
      currentHumidity: double.parse(
        currentWeatherData['main']['humidity'].toString(),
      ),
      hourlyForecast:
          hourlyList.map((item) => HourlyWeatherModel.fromMap(item)).toList(),
    );
  }

  String toJson() => json.encode(toMap());

  // factory WeatherModel.fromJson(String source) =>
  //     WeatherModel.fromMap(json.decode(source) as Map<String, dynamic>);
  factory WeatherModel.fromJson(Map<String, dynamic> source) =>
      WeatherModel.fromMap(source); // ✅ This is all you need

  @override
  String toString() {
    return ' currentTemp: $currentTemp, currentSky: $currentSky, currentPressure: $currentPressure, currentWindSpeed: $currentWindSpeed, currentHumidity: $currentHumidity,hourlyForecast: $hourlyForecast )';
  }

  @override
  bool operator ==(covariant WeatherModel other) {
    if (identical(this, other)) return true;

    return other.currentTemp == currentTemp &&
        other.currentSky == currentSky &&
        other.currentPressure == currentPressure &&
        other.currentWindSpeed == currentWindSpeed &&
        other.currentHumidity == currentHumidity &&
        other.hourlyForecast == hourlyForecast;
  }

  @override
  int get hashCode {
    return currentTemp.hashCode ^
        currentSky.hashCode ^
        currentPressure.hashCode ^
        currentWindSpeed.hashCode ^
        currentHumidity.hashCode ^
        hourlyForecast.hashCode;
  }
}

class HourlyWeatherModel {
  final DateTime time;
  final String sky;
  final double temperature;

  HourlyWeatherModel({
    required this.time,
    required this.sky,
    required this.temperature,
  });

  factory HourlyWeatherModel.fromMap(Map<String, dynamic> map) {
    return HourlyWeatherModel(
      time: DateTime.parse(map['dt_txt']),
      sky: map['weather'][0]['main'],
      temperature: (map['main']['temp'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'time': time.toIso8601String(),
      'sky': sky,
      'temperature': temperature,
    };
  }

  @override
  String toString() =>
      'HourlyWeatherModel(time: $time, sky: $sky, temperature: $temperature)';
}
