import 'package:flutter/material.dart';
import 'package:weather_clock/provider/weatherProvider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../helper/utils.dart';
import '../digitalclock.dart';
import '../trace.dart';

class MainWeather extends StatelessWidget {
  final TextStyle _style1 = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16,
  );
  final TextStyle _style2 = TextStyle(
    fontWeight: FontWeight.w400,
    color: Colors.grey[700],
    fontSize: 14,
  );

  @override
  Widget build(BuildContext context) {

    return Consumer<WeatherProvider>(builder: (context, weatherProv, _) {

      List<int> temp = [];
      for( int m=0;m<weatherProv.hourly24Weather.length;m++)
      {
        temp.add(weatherProv.hourly24Weather.elementAt(m).dailyTemp.toInt());
      }
      var maximumNumber =
      temp.reduce((value, element) => value > element ? value : element);
      var minimumNumber =
      temp.reduce((value, element) => value < element ? value : element);

      Trace.maxTemp = maximumNumber;
      Trace.minTemp = minimumNumber;

      return Container(
        padding: const EdgeInsets.fromLTRB(25, 15, 25, 5),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('${weatherProv.weather.country}', style: _style1),
                Icon(Icons.location_on_outlined),
                Text('${weatherProv.weather.cityName}', style: _style1),
              ],
            ),
            const SizedBox(height: 5.0),
            //const SizedBox(height:20.0),
            Container(
              child:DigitalClock(weatherProv:weatherProv),
            ),
            //const SizedBox(height: 25.0),
            //Text(
            //  DateFormat.yMMMEd().add_jm().format(DateTime.now()),
            //  style: _style2,
            //),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MapString.mapStringToIcon(
                  context,
                  '${weatherProv.weather.currently}',
                  45,
                ),
                const SizedBox(width: 16.0),
                Text(
                  '${weatherProv.weather.temp.toStringAsFixed(0)}°C',
                  style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Text(
              //'Max ${weatherProv.weather.tempMax.toStringAsFixed(0)}°/ min ${weatherProv.weather.tempMin.toStringAsFixed(0)}° Feels like ${weatherProv.weather.feelsLike.toStringAsFixed(0)}°',
              'Max ${maximumNumber}°/ min ${minimumNumber}° Feels like ${weatherProv.weather.feelsLike.toStringAsFixed(0)}°',
              style: _style1.copyWith(fontSize: 16),
            ),
            const SizedBox(height: 5.0),
            Text(
              toBeginningOfSentenceCase('${weatherProv.weather.description}') ??
                  '',
              style: _style1.copyWith(fontSize: 16),
            ),
          ],
        ),
      );
    });
  }
}
