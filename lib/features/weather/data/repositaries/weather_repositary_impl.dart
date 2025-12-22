import 'package:weatherpulse/features/weather/data/datasources/weather_datasources.dart';
import 'package:weatherpulse/features/weather/data/models/forcast_model.dart';
import 'package:weatherpulse/features/weather/data/models/weather_datamodel.dart';
import 'package:weatherpulse/features/weather/domain/entities/forcast.dart';
import 'package:weatherpulse/features/weather/domain/entities/weather.dart';
import 'package:weatherpulse/features/weather/domain/repositaries/weather_repositary.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherDataSources dataSource;

  WeatherRepositoryImpl(this.dataSource);

  @override
  Future<Weather> getWeather(String city) async {
    final response = await dataSource.fetchweatherData(city);
    if (response.statusCode == 200) {
      final data = response.data;
      print(data);
      return WeatherModel.fromJson(data);
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  @override
  Future<List<Forecast>> getForecast(String city) async {
    final list = await dataSource.getForecastByCity(city);

    final Map<String, Forecast> dailyForecast = {};

    for (final item in list) {
      final String dateText = item['dt_txt'];

      final String dayKey = dateText.split(' ')[0];

      if (!dailyForecast.containsKey(dayKey)) {
        dailyForecast[dayKey] = ForecastModel.fromJson(item);
      }
    }

    final result = dailyForecast.values.take(5).toList();

    return result;
  }
}
