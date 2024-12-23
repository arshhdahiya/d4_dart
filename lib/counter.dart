import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'profile.dart';
import 'main.dart';

class Counter extends ChangeNotifier {
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  set selectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  void nav(BuildContext context, int index) {
    selectedIndex = index;
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MyApp()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProfileScreen()),
        );
        break;
    }
  }

  String _name = "";
  String get name => _name;

  String _homeLocation = "";
  String get homeLocation => _homeLocation;

  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    _name = prefs.getString('name') ?? "";
    _homeLocation = prefs.getString('homeLocation') ?? "";
    notifyListeners();
    print('Loaded user data: name=$_name, homeLocation=$_homeLocation');
  }

  Future<void> saveName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    _name = name;
    await prefs.setString('name', name);
    notifyListeners();
  }

  Future<void> saveHomeLocation(String homeLocation) async {
    final prefs = await SharedPreferences.getInstance();
    _homeLocation = homeLocation;
    await prefs.setString('homeLocation', homeLocation);
    notifyListeners();
    await fetchData();
  }
  String? _image;
  String? get image => _image;
  double? _temperature;
  double? get temperature => _temperature;
  double? _feelslike;
  double? get feelslike => _feelslike;
  String? _conditionText;
  String? get conditionText =>  _conditionText;
  double? _humidity;
  double? get humidity => _humidity;
  double? _raininmm;
  double? get raininmm => _raininmm;
  String? _sunrise;
  String? get sunrise => _sunrise;
  double? _windspeed;
  double? get windspeed => _windspeed;
  String? _sunset;
  String? get sunset => _sunset;

  // Future<void> keepfetching() async{
  //   Timer(const Duration(minutes: 0), fetchData);
  // }

  Future<void> fetchData() async {
    const String apiKey = 'e1bb4ab806e9433ca4194717242006';
    // print('Fetching data for home location: $_homeLocation');
    final response = await http.get(Uri.parse('http://api.weatherapi.com/v1/forecast.json?key=$apiKey&q=$_homeLocation&days=4&aqi=no&alerts=no'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      // print('JSON response received: $jsonResponse');
      _image = jsonResponse['current']['condition']['icon'] ?? "";
      _temperature = jsonResponse['current']['temp_c']?.toDouble();
      _feelslike = jsonResponse['current']['feelslike_c']?.toDouble() ?? 0.0;
      _conditionText = jsonResponse['current']['condition']['text'] ?? "";
      _humidity = jsonResponse['current']['humidity']?.toDouble() ?? 0.0;
      _raininmm = jsonResponse['current']['precip_mm']?.toDouble() ?? 0.0;
      _sunrise = jsonResponse['forecast']['forecastday'][0]['astro']['sunrise'] ?? "";
      _windspeed = jsonResponse['current']['wind_mph']?.toDouble() ?? 0.0;
      _sunset = jsonResponse['forecast']['forecastday'][0]['astro']['sunset'] ?? "";
      notifyListeners();
    } else {
      print('Failed to fetch data: ${response.statusCode}');
    }
  }
}


