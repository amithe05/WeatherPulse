import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/forcast.dart';
import '../bloc/weather_bloc.dart';
import '../bloc/weather_event.dart';
import '../bloc/weather_state.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final TextEditingController _cityController = TextEditingController();

  void _searchWeather() {
    final city = _cityController.text.trim();
    if (city.isNotEmpty) {
      context.read<WeatherBloc>().add(FetchWeather(city));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('WeatherPulse'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildSearchField(),
            const SizedBox(height: 16),
            Expanded(child: _buildWeatherContent()),
          ],
        ),
      ),
    );
  }

  // 🔍 Search Field
  Widget _buildSearchField() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _cityController,
            decoration: const InputDecoration(
              hintText: 'Enter city name',
              border: OutlineInputBorder(),
            ),
            onSubmitted: (_) => _searchWeather(),
          ),
        ),
        const SizedBox(width: 8),
        IconButton(icon: const Icon(Icons.search), onPressed: _searchWeather),
      ],
    );
  }

  // 🔄 State-based UI
  Widget _buildWeatherContent() {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        if (state is WeatherInitial) {
          return const Center(child: Text('Search for a city to see weather'));
        }

        if (state is WeatherLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is WeatherLoaded) {
          return _buildWeatherAndForecast(state);
        }

        if (state is WeatherError) {
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        return const SizedBox();
      },
    );
  }

  // 🌤️ Current Weather + Forecast Section
  Widget _buildWeatherAndForecast(WeatherLoaded state) {
    final weather = state.weather;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  weather.cityName,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Image.network(
                  'https://openweathermap.org/img/wn/${weather.icon}@2x.png',
                ),
                const SizedBox(height: 8),
                Text(
                  '${weather.temperature.toStringAsFixed(1)} °C',
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(weather.description.toUpperCase()),
                const SizedBox(height: 6),
                Text('Feels like: ${weather.feelsLike.toStringAsFixed(1)} °C'),
                Text('Humidity: ${weather.humidity}%'),
                Text('Wind: ${weather.windSpeed} m/s'),
              ],
            ),
          ),
        ),

        const SizedBox(height: 16),

        // 📅 Forecast Header
        const Text(
          '5-Day Forecast',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 8),

        // 📅 Forecast List
        Expanded(child: _buildForecast(state.forecast)),
      ],
    );
  }

  // 📅 Forecast List Widget
  Widget _buildForecast(List<Forecast> forecast) {
    return ListView.separated(
      itemCount: forecast.length,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (context, index) {
        final day = forecast[index];
        return ListTile(
          leading: Image.network(
            'https://openweathermap.org/img/wn/${day.icon}@2x.png',
          ),
          title: Text('${day.temperature.toStringAsFixed(1)} °C'),
          subtitle: Text(day.description),
          trailing: Text('${day.date.day}/${day.date.month}'),
        );
      },
    );
  }
}
