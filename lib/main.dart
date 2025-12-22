import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/weather/data/datasources/weather_datasources.dart';
import 'features/weather/data/repositaries/weather_repositary_impl.dart';
import 'features/weather/domain/usecases/get_forcast.dart';
import 'features/weather/domain/usecases/get_weather.dart';
import 'features/weather/presentation/bloc/weather_bloc.dart';
import 'features/weather/presentation/pages/weather_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 🔹 Core dependencies
    final dio = Dio();
    final dataSource = WeatherDataSources(dio);
    final repository = WeatherRepositoryImpl(dataSource);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WeatherPulse',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (_) => WeatherBloc(
          getWeather: GetWeather(repository),
          getForecast: GetForecast(repository),
        ),
        child: const WeatherPage(),
      ),
    );
  }
}
