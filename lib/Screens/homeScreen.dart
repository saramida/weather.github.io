import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'dart:io' show Platform;

import '../provider/weatherProvider.dart';
import '../trace.dart';
import '../widgets/WeatherInfo.dart';
import '../widgets/fadeIn.dart';
import '../widgets/hourlyForecast.dart';
import '../widgets/locationError.dart';
import '../widgets/mainWeather.dart';
import '../widgets/requestError.dart';
import '../screens/hourlyWeatherScreen.dart';
import '../widgets/searchBar.dart' as srch;
import '../widgets/weatherDetail.dart';
import '../widgets/sevenDayForecast.dart';
import '../mytheme.dart';
import '../trace.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class HomeScreen extends StatefulWidget {
  final MyTheme currentTheme;
  HomeScreen({Key? key,required this.currentTheme}) : super(key: key);
  static const routeName = '/homeScreen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController _pageController = PageController();
  bool _isLoading = false;
  bool _isChecked = false;
  String _myipstr =  "0.0.0.0";

  String androidTestId = 'ca-app-pub-3940256099942544/6300978111';
  String androidTestId2 = 'ca-app-pub-3940256099942544/6300978111';
  String androidTestId3 = 'ca-app-pub-3940256099942544/6300978111';

  BannerAd? bannerAd;
  BannerAd? bannerAd2;
  BannerAd? bannerAd3;
  bool _isLoaded = false;
  bool _isLoaded2 = false;
  bool _isLoaded3 = false;



  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadAd();
    _loadAd2();
    _loadAd3();
  }

  Future<void> _loadAd() async {
    // Get an AnchoredAdaptiveBannerAdSize before loading the ad.
    final AnchoredAdaptiveBannerAdSize? size =
    await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
        MediaQuery.of(context).size.width.truncate());

    if (size == null) {
      print('Unable to get height of anchored banner.');
      return;
    }

    bannerAd = BannerAd(
      // TODO: replace these test ad units with your own ad unit.
      adUnitId:androidTestId,
      size: size,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          print('$ad loaded: ${ad.responseInfo}');
          setState(() {
            // When the ad is loaded, get the ad size and use it to set
            // the height of the ad container.
            bannerAd = ad as BannerAd;
            _isLoaded = true;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('Anchored adaptive banner failedToLoad: $error');
          ad.dispose();
        },
      ),
    );
    return bannerAd!.load();
  }

  Future<void> _loadAd2() async {
    // Get an AnchoredAdaptiveBannerAdSize before loading the ad.
    final AnchoredAdaptiveBannerAdSize? size =
    await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
        MediaQuery.of(context).size.width.truncate());

    if (size == null) {
      print('Unable to get height of anchored banner.');
      return;
    }

    bannerAd2 = BannerAd(
      // TODO: replace these test ad units with your own ad unit.
      adUnitId:androidTestId2,
      size: size,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          print('$ad loaded: ${ad.responseInfo}');
          setState(() {
            // When the ad is loaded, get the ad size and use it to set
            // the height of the ad container.
            bannerAd2 = ad as BannerAd;
            _isLoaded2 = true;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('Anchored adaptive banner failedToLoad: $error');
          ad.dispose();
        },
      ),
    );
    return bannerAd2!.load();
  }

  Future<void> _loadAd3() async {
    // Get an AnchoredAdaptiveBannerAdSize before loading the ad.
    final AnchoredAdaptiveBannerAdSize? size =
    await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
        MediaQuery.of(context).size.width.truncate());

    if (size == null) {
      print('Unable to get height of anchored banner.');
      return;
    }

    bannerAd3 = BannerAd(
      // TODO: replace these test ad units with your own ad unit.
      adUnitId:androidTestId3,
      size: size,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          print('$ad loaded: ${ad.responseInfo}');
          setState(() {
            // When the ad is loaded, get the ad size and use it to set
            // the height of the ad container.
            bannerAd3 = ad as BannerAd;
            _isLoaded3 = true;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('Anchored adaptive banner failedToLoad: $error');
          ad.dispose();
        },
      ),
    );
    return bannerAd3!.load();
  }

  void _myip() async{
    var response = await http.get(Uri.parse("https://ipapi.co/ip/"));
    setState(() {
      _myipstr = response.body;
    });
  }

  Future<void> _mylocation() async{
    var response = await http.get(Uri.parse("https://ipapi.co/ip/"));
    setState(() {
      _myipstr = response.body;
    });
    var response2 = await http.get(Uri.parse("https://ipapi.co/"+response.body+"/latlong/"));
    double latitude = double.parse(response2.body.split(",")[0]);
    double longitude = double.parse(response2.body.split(",")[1]);

    var weatherProv = Provider.of<WeatherProvider>(context, listen: false);
    await weatherProv.getCurrentWeather(new LatLng(latitude,longitude));
    await weatherProv.getDailyWeather(new LatLng(latitude,longitude));
    //var response3 = await http.get(Uri.parse("https://ipapi.co/"+response.body+"/city/"));
    //weatherProv.searchWeatherWithLocation(weatherProv.weather!.cityName);

  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  void dispose() {
    bannerAd?.dispose();
    bannerAd2?.dispose();
    bannerAd3?.dispose();
    super.dispose();
    _pageController.dispose();
  }



  Future<void> _getData() async {
    _isLoading = true;
    try {
      if (Platform.isWindows) {
        _mylocation();
      } else {
        _myip();
        final weatherData = Provider.of<WeatherProvider>(
            context, listen: false);
        weatherData.getWeatherData();
      }
    }catch(e){
      _myip();
      final weatherData = Provider.of<WeatherProvider>(
          context, listen: false);
      weatherData.getWeatherData();
    }
    _isLoading = false;
  }

  Future<void> _refreshData(BuildContext context) async {
    try{
      if(Platform.isWindows) {
        _mylocation();
      }else {
        _myip();
        await Provider.of<WeatherProvider>(context, listen: false)
            .getWeatherData(isRefresh: true);
      }
    }catch(e){
      _myip();
      final weatherData = Provider.of<WeatherProvider>(
          context, listen: false);
      weatherData.getWeatherData();
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeContext = Theme.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Consumer<WeatherProvider>(
          builder: (context, weatherProv, _) {
            if (weatherProv.isLocationError) {
              //return LocationError();
            }
            //if (weatherProv.isRequestError) {
              //return RequestError();
            //}
            return Column(
              children: [
                if (bannerAd != null && _isLoaded)
                  Container(
                    color: Colors.orange.shade50,
                    width: bannerAd!.size.width.toDouble(),
                    height: bannerAd!.size.height.toDouble(),
                    child: AdWidget(ad: bannerAd!),
                  ),
                srch.SearchBar(),
                Container(
                  width: 300,
                  margin: const EdgeInsets.all(0.0),
                  padding: const EdgeInsets.all(0.0),
                  child:Center(
                    child:Row(
                      children: [
                        /**************
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.indigo,
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                          ),
                          child:Switch(
                              value: _isChecked,
                              onChanged: (value) {
                                _isChecked = value;
                                widget.currentTheme.switchTheme();
                              }),
                        ),
                        **************/
                        /**************
                            ElevatedButton.icon( onPressed: () { // Respond to button press

                            _getData();

                            },
                            //style: ElevatedButton.styleFrom( // background backgroundColor: Colors.blueGrey,
                            // foreground ) foregroundColor: Colors.white,
                            //),
                            icon: Icon(Icons.my_location_rounded, size: 20),
                            label: Text("Curr. Location"),
                            ),
                            //var response = await http.get(Uri.parse("https://ipapi.co/ip/"));
                            SizedBox(width:5),

                        ElevatedButton.icon( onPressed: () { // Respond to button press

                          _mylocation();

                        },
                          //style: ElevatedButton.styleFrom(  // background, backgroundColor: Colors.blueGrey,
                          // foreground ) foregroundColor: Colors.white,
                          //),
                          icon: Icon(Icons.phone_iphone, size: 20),
                          label: Text(_myipstr),
                        ),
                         **********/
                        /**************/
                        Container(
                          //margin: const EdgeInsets.all(2.0),
                          //padding: const EdgeInsets.all(2.0),
                          //decoration: BoxDecoration(
                          //  //color: Colors.blueAccent,
                          //  borderRadius: BorderRadius.all(
                          //    Radius.circular(8.0),
                          //  ),
                          //),
                          width:300,
                          height:30,
                          child:TextButton.icon(     // <-- TextButton
                            onPressed: () {
                              _mylocation();
                              },
                            //onRefresh: () async => _refreshData(context),
                            icon: Icon(
                              Icons.my_location,
                              size: 16.0,
                              color:Colors.blueAccent,
                            ),
                            label: Text('[IPAddress] ${this._myipstr}',
                              style: TextStyle(fontSize: 12,color:Colors.black),
                            ),
                          ),
                        ),
                        /**************/
                      ],
                    ),
                  ),
                ),
                Center(
                  child: SmoothPageIndicator(
                    controller: _pageController,
                    //count: 2,
                    count: 3,
                    effect: ExpandingDotsEffect(
                      activeDotColor: themeContext.primaryColor,
                      dotHeight: 6,
                      dotWidth: 6,
                    ),
                  ),
                ),
                _isLoading || weatherProv.isLoading
                    ? Expanded(
                        child: Center(
                          child: CircularProgressIndicator(
                            backgroundColor: themeContext.primaryColor,
                            color: Colors.white,
                          ),
                        ),
                      )
                    : Expanded(
                        child: PageView(
                          physics: BouncingScrollPhysics(),
                          controller: _pageController,
                          children: [

                            // First Page of the Page View
                            RefreshIndicator(
                              onRefresh: () async => _refreshData(context),
                              child: ListView(
                                padding: const EdgeInsets.all(0),
                                shrinkWrap: true,
                                children: [
                                  FadeIn(
                                    curve: Curves.easeIn,
                                    duration: Duration(milliseconds: 250),
                                    child: MainWeather(),
                                  ),
                                  FadeIn(
                                    curve: Curves.easeIn,
                                    duration: Duration(milliseconds: 500),
                                    child: WeatherInfo(),
                                  ),
                                  FadeIn(
                                    curve: Curves.easeIn,
                                    duration: Duration(milliseconds: 750),
                                    child:Column(
                                      children: [
                                        if (bannerAd != null && _isLoaded)
                                        Container(
                                              child:Container(
                                                color: Colors.orange.shade50,
                                                width: bannerAd2!.size.width.toDouble(),
                                                height: bannerAd2!.size.height.toDouble(),
                                                child: AdWidget(ad: bannerAd2!),
                                              ),
                                        ),
                                        SizedBox(height:8),
                                        HourlyForecast(),
                                      ],

                                    ),
                                    //child: HourlyForecast(),
                                  ),
                                  //HourlyScreen(),//HourlyScreen(),
                                ],
                              ),
                            ),
                            // Second Page of the Page View
                            /***********************/
                            Center(
                              child:Container(
                                padding: const EdgeInsets.all(5.0),
                                margin: const EdgeInsets.all(5.0),
                                decoration: const BoxDecoration(
                                  color: Color(0xFFffffff),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 1.0, // soften the shadow
                                      spreadRadius: 1.0, //extend the shadow
                                      offset: Offset(
                                        1.0, // Move to right 5  horizontally
                                        1.0, // Move to bottom 5 Vertically
                                      ),
                                    )
                                  ],
                                ),

                                child: HourlyScreen(),
                              ),
                            ),
                            /***********************/
                            ListView(
                              padding: const EdgeInsets.all(10),
                              children: [
                                FadeIn(
                                  curve: Curves.easeIn,
                                  duration: Duration(milliseconds: 250),
                                  child: SevenDayForecast(),
                                ),
                                const SizedBox(height: 16.0),
                                FadeIn(
                                  curve: Curves.easeIn,
                                  duration: Duration(milliseconds: 500),
                                  child: WeatherDetail(),
                                ),
                              ],
                            ),

                          ],
                        ),
                      ),






              ],
            );
          },
        ),
      ),
    );
  }
}
