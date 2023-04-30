import 'package:flutter/cupertino.dart';
import 'package:supercharged/supercharged.dart';

class DailyWeather with ChangeNotifier {
  final dynamic dailyTemp;
  final String? condition;
  late final DateTime? date;
  final String? precip;
  final int? uvi;
  final String? timezone_string;
  DailyWeather({
    this.dailyTemp,
    this.condition,
    this.date,
    this.precip,
    this.uvi,
    this.timezone_string
  });

  factory DailyWeather.fromJson(Map<String, dynamic> json) {
    final precipData = json['daily'][0]['pop'];
    final calcPrecip = precipData * 100;
    final precipitation = calcPrecip.toStringAsFixed(0);
    return DailyWeather(
      precip: precipitation,
      uvi: (json['daily'][0]['uvi']).toInt(),
      timezone_string: json['timezone'],
    );
  }

  static DailyWeather fromDailyJson(dynamic json) {
    return DailyWeather(
      dailyTemp: json['temp']['day'],
      condition: json['weather'][0]['main'],
      date: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000, isUtc: true),
      //date: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000, isUtc: true).add(Duration(hours: ( json['timezone'].toInt()/3600 ))),
      //date: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000, isUtc: true)
      //.add(Duration( seconds:  json['timezone'].toString().toInt() ?? 0  )),
      timezone_string: json['timezone'],
    );
  }

//      var timezone_var = (widget.weatherProv.weather.timezone/3600).toInt();
//       dateTime = DateTime.now().toUtc().add(Duration(hours: timezone_var));

  //DateTime.now().toUtc().add(Duration(hours: ( (json['timezone']).toInit() /3600) ))

  static DailyWeather fromHourlyJson(dynamic json) {
    return DailyWeather(
      dailyTemp: json['temp'],
      condition: json['weather'][0]['main'],
      date: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
      //.add(Duration( seconds:  json['timezone'].toString().toInt() ?? 0  )),
      //date: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
      timezone_string: json['timezone'],
    );
  }
}
