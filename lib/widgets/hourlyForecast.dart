import 'package:flutter/material.dart';
import 'package:weather_clock/provider/weatherProvider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../screens/hourlyWeatherScreen.dart';
import '../helper/utils.dart';

class HourlyForecast extends StatelessWidget {
  Widget hourlyWidget(dynamic weather, BuildContext context,WeatherProvider wprovider) {
    DateTime currentTime = weather.date;
    var imsi = currentTime.toUtc().add(Duration(seconds: wprovider.weather.timezone) );
    final hours = DateFormat.Hm().format(imsi);

    return Container(
      height: 130,
      padding: const EdgeInsets.all(5.0),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    hours,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  MapString.mapStringToIcon(
                    context,
                    '${weather.condition}',
                    45,
                  ),
                  Container(
                    width: 80,
                    child: Text(
                      "${weather.dailyTemp.toStringAsFixed(1)}°C",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Next 3 Hours',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              /********************
              TextButton(
                child: Text(
                  'Next 24 Hours',
                  style: TextStyle(color: Colors.blue),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(HourlyScreen.routeName);
                },
              ),
              ******************/
            ],
          ),
        ),
        SizedBox(height: 5),
        Consumer<WeatherProvider>(builder: (context, weatherProv, _) {
          return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: weatherProv.hourlyWeather
                  .map((item) => hourlyWidget(item, context,weatherProv))
                  .toList());
        }),
      ],
    );
  }
}
