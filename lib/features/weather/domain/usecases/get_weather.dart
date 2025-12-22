import 'package:weatherpulse/features/weather/domain/repositaries/weather_repositary.dart';

class GetWeather {
  final WeatherRepository repository;

  GetWeather(this.repository);

  Future<dynamic> call(String city) async {
    return await repository.getWeather(city);
  }
}
