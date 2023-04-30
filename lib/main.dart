import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'screens/hourlyWeatherScreen.dart';
import './provider/weatherProvider.dart';
import 'screens/weeklyWeatherScreen.dart';
import 'screens/homeScreen.dart';
import 'mytheme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(
    MyApp(),
  );
}
class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  MyTheme currentTheme = MyTheme();

  @override
  void initState(){
    super.initState();
    currentTheme.addListener(() {
      setState((){

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WeatherProvider(),
      child: MaterialApp(
        title: 'Flutter Weather',
        debugShowCheckedModeBanner: false,
        /**************
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(
              color: Colors.blue,
            ),
            elevation: 0,
          ),
          scaffoldBackgroundColor: Colors.white,
          primaryColor: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: Colors.white),
        ),
        ****************/
        theme: ThemeData.light().copyWith(
          appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(
              color: Colors.blue,
            ),
            elevation: 0,
            titleTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue,
              fontSize:10,
            ),
          ),
          scaffoldBackgroundColor:Colors.white,
          primaryColor: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          colorScheme:
          ColorScheme.fromSwatch().copyWith(secondary: Colors.white),
        ), // Provide light theme.
        darkTheme: ThemeData.dark().copyWith(
          appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(
              color: Colors.blue,
            ),
            elevation: 0,
          ),
          scaffoldBackgroundColor:Colors.black45,
          primaryColor: Colors.blue,
          //visualDensity: VisualDensity.adaptivePlatformDensity,
          colorScheme:
          ColorScheme.fromSwatch().copyWith(secondary: Colors.black45),
        ), // Provide dark theme.
        themeMode: currentTheme.currentTheme(), //to follow the system theme
        home: HomeScreen(currentTheme:currentTheme),
        routes: {
          WeeklyScreen.routeName: (myCtx) => WeeklyScreen(),
          HourlyScreen.routeName: (myCtx) => HourlyScreen(),
        },
      ),
    );
  }
}
