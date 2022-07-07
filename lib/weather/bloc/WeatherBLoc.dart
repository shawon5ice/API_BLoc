import 'package:api_bloc/weather/model/WeatherModel.dart';
import 'package:api_bloc/weather/repository/WeatherRepository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherRepository weatherRepo;

  WeatherBloc(this.weatherRepo) : super(this.weatherRepo);

  WeatherState get initialState => WeatherIsNotSearchedYet();

  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is FeatchWeather) {
      yield WeatherIsLoading();

      try {
        WeatherModel weather = await weatherRepo.getWeather(event._city);
        yield WeatherIsLoaded(weather);
      } catch (_) {
        print(_);
        yield WeatherIsNotLoaded();
      }
    } else if (event is ResetWeather) {
      yield WeatherIsNotSearchedYet();
    }
  }
}

class WeatherEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FeatchWeather extends WeatherEvent {
  final _city;
  FeatchWeather(this._city);

  @override
  List<Object?> get props => [_city];
}

class ResetWeather extends WeatherEvent {}

class WeatherState extends Equatable {
  @override
  List<Object?> get props => [];
}

class WeatherIsNotSearchedYet extends WeatherState {}

class WeatherIsLoading extends WeatherState {}

class WeatherIsLoaded extends WeatherState {
    final _weather;
    WeatherIsLoaded(this._weather);

    @override
    List<Object?> get props => [_weather];
}

class WeatherIsNotLoaded extends WeatherState {}
