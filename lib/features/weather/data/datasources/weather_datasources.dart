import 'package:dio/dio.dart';
import 'package:weatherpulse/core/constants/app_constants.dart';

class WeatherDataSources {
  final Dio dio;

  WeatherDataSources(this.dio);

  Future<Response> fetchweatherData(String city) async {
    try {
      final response = await dio.get(
        'https://api.openweathermap.org/data/2.5/weather',
        queryParameters: {'q': city, 'appid': ApiConstants.apiKey},
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<dynamic>> getForecastByCity(String city) async {
    final response = await dio.get(
      '${ApiConstants.baseUrl}/forecast',
      queryParameters: {'q': city, 'appid': ApiConstants.apiKey},
    );
    return response.data['list'];
  }
}
