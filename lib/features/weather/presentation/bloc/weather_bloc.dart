import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_weather.dart';
import '../../domain/usecases/get_forcast.dart';
import 'weather_event.dart';
import 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetWeather getWeather;
  final GetForecast getForecast;

  WeatherBloc({required this.getWeather, required this.getForecast})
    : super(WeatherInitial()) {
    on<FetchWeather>(_onFetchWeather);
  }

  Future<void> _onFetchWeather(
    FetchWeather event,
    Emitter<WeatherState> emit,
  ) async {
    emit(WeatherLoading());
    try {
      final weather = await getWeather(event.city);
      final forecast = await getForecast(event.city);

      emit(WeatherLoaded(weather: weather, forecast: forecast));
    } catch (e) {
      emit(WeatherError('Unable to fetch weather data'));
    }
  }
}
