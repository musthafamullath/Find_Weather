import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_response_model.dart';
import 'package:weather_app/secrets/api.dart';
import 'package:http/http.dart' as http;

class WeatherServiceProvider extends ChangeNotifier {
  WeatherModel? _weather;
  WeatherModel? get weather => _weather;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _error = "";
  String get error => _error;

  Future<void> fetchWeatherDataByCity(String city) async {
    _isLoading = true;
    _error = "";

    try {
      final apiUrl =
          "${APIEndPoint().cityUrl}$city${APIEndPoint().appId}${APIEndPoint().apiKey}${APIEndPoint().unit}";

     
      
      final response = await http.get(Uri.parse(apiUrl));
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
       
        _weather = WeatherModel.fromJson(data);
       
        notifyListeners();
      } else {
        _error = "Failed to load data";
      }
    } catch (e) {
      _error = "Failed to load data $e";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
