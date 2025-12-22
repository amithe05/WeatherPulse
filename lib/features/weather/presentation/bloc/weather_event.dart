import 'package:weatherpulse/features/weather/domain/entities/forcast.dart';
import 'package:weatherpulse/features/weather/presentation/bloc/weather_state.dart';

abstract class WeatherEvent {}

class FetchWeather extends WeatherEvent {
  final String city;
  FetchWeather(this.city);
}

class ForecastLoaded extends WeatherState {
  final List<Forecast> forecast;
  ForecastLoaded(this.forecast);
}
