import 'package:weatherpulse/features/weather/domain/entities/forcast.dart';
import 'package:weatherpulse/features/weather/domain/entities/weather.dart';

abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final Weather weather;
  final List<Forecast> forecast;

  WeatherLoaded({required this.weather, required this.forecast});
}

class WeatherError extends WeatherState {
  final String message;
  WeatherError(this.message);
}
