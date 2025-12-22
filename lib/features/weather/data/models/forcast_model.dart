import 'package:weatherpulse/features/weather/domain/entities/forcast.dart';

class ForecastModel extends Forecast {
  ForecastModel({
    required super.date,
    required super.temperature,
    required super.description,
    required super.icon,
  });

  factory ForecastModel.fromJson(Map<String, dynamic> json) {
    return ForecastModel(
      date: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
      temperature: (json['main']['temp'] as num) - 273.15,
      description: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
    );
  }
}
