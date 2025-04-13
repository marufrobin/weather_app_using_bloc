import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_app_using_bloc/model/weather.model.dart';

import '../data/repository/weather.repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc(this.weatherRepository) : super(WeatherInitial()) {
    on<WeatherFetched>(_onFetchWeather);
  }

  Future<void> _onFetchWeather(
    WeatherFetched event,
    Emitter<WeatherState> emit,
  ) async {
    emit(WeatherLoading());
    try {
      final weather = await weatherRepository.getCurrentWeather();
      emit(WeatherSuccess(weatherModel: weather));
    } catch (e, stackTrace) {
      log(error: e, stackTrace: stackTrace, 'Error fetching weather data');
      emit(WeatherFailure(e.toString()));
    }
  }
}
