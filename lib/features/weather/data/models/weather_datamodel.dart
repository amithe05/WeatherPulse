import '../../domain/entities/weather.dart';

class WeatherModel extends Weather {
  WeatherModel({
    required super.cityName,
    required super.temperature,
    required super.feelsLike,
    required super.description,
    required super.icon,
    required super.humidity,
    required super.windSpeed,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['name'],
      temperature: _kelvinToCelsius(json['main']['temp']),
      feelsLike: _kelvinToCelsius(json['main']['feels_like']),
      description: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
      humidity: json['main']['humidity'],
      windSpeed: (json['wind']['speed'] as num).toDouble(),
    );
  }

  static double _kelvinToCelsius(num temp) {
    return temp - 273.15;
  }
}
