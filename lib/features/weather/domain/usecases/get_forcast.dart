import 'package:weatherpulse/features/weather/domain/entities/forcast.dart';
import 'package:weatherpulse/features/weather/domain/repositaries/weather_repositary.dart';

class GetForecast {
  final WeatherRepository repository;

  GetForecast(this.repository);

  Future<List<Forecast>> call(String city) {
    return repository.getForecast(city);
  }
}
