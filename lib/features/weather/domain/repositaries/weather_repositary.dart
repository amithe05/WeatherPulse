import 'package:weatherpulse/features/weather/domain/entities/forcast.dart';

abstract class WeatherRepository {
  Future<dynamic> getWeather(String city);
  Future<List<Forecast>> getForecast(String city);
}
