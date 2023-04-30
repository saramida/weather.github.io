import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:supercharged/supercharged.dart';

import '../helper/utils.dart';
import '../provider/weatherProvider.dart';
import '../trace.dart';

class HourlyScreen extends StatelessWidget {
  static const routeName = '/hourlyScreen';

  Widget dailyWidget(dynamic weather, BuildContext context,WeatherProvider wprovider) {

    DateTime time2 = weather.date;
    var time= time2.toUtc().add(Duration(seconds: wprovider.weather.timezone));
    final hours = DateFormat.Hm().format( time );

    //final time = weather.date;
    //final hours = DateFormat.Hm().format(time);
    double? curtemp = weather.dailyTemp.toStringAsFixed(1).toString().toDouble();
    var ret = (curtemp!.toInt() - Trace.minTemp) / (Trace.maxTemp- Trace.minTemp) + 0.4;
    const varcolor = Colors.blue;
    if( curtemp <= 0 ){
      //varcolor = Colors.redAccent;
    }


    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
      child: Material(
        elevation: 5,
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                hours,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(width:10),
              Container(
                  padding: const EdgeInsets.all(5.0),
                  margin: const EdgeInsets.all(5.0),
                  width:(80*ret).toDouble(),
                  decoration: const BoxDecoration(
                    color: varcolor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 2.0, // soften the shadow
                        spreadRadius: 2.0, //extend the shadow
                        offset: Offset(
                          0.0, // Move to right 5  horizontally
                          0.0, // Move to bottom 5 Vertically
                        ),
                      )
                    ],
                  ),
                ),
              Spacer(),

              Text(
                '${weather.dailyTemp.toStringAsFixed(1)}°',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(width: 16.0),
              MapString.mapStringToIcon(context, weather.condition, 20),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final weatherData = Provider.of<WeatherProvider>(context);
    final mediaQuery = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: Colors.transparent,
          title: Text(
            'Next 24 Hours',
            style: TextStyle(color: Colors.black,fontSize:16.0),
          ),
        ),
        body: Container(
          height: mediaQuery.size.height,
          width: mediaQuery.size.width,
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: weatherData.hourly24Weather
                .map((item) => dailyWidget(item, context,weatherData))
                .toList(),
          ),
        ),
      ),
    );
  }
}
