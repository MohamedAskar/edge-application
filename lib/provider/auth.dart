import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String _jwtToken;
  String _userID;

  final dio = Dio();

  String get userID {
    return _userID;
  }

  bool get isAuth {
    return false;
  }

  // String get token {

  //   if (JwtDecoder.getExpirationDate(_jwtToken) != null &&
  //       JwtDecoder.getExpirationDate(_jwtToken).isAfter(DateTime.now()) &&
  //       _jwtToken != null) {
  //     return _jwtToken;
  //   }
  //   return null;
  // }

  Future<void> _authenticate(
      {String name,
      @required String email,
      @required String password,
      @required String urlSegment}) async {
    final url =
        'https://evening-falls-32097.herokuapp.com/api/v1/users/$urlSegment';
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    Map body = {
      "name": name,
      "email": email.trim(),
      "password": password,
      "passwordConfirm": password
    };

    try {
      final response = await dio.post(url, data: json.encode(body));

      if (response.data['status'] != 'success') {
        throw PlatformException(message: response.data['message'], code: '404');
      } else {
        _userID = JwtDecoder.decode(response.data['token'])['id'];
        _jwtToken = response.data['token'];
        print(response.data);
        print(JwtDecoder.decode(response.data['token']));
        print(JwtDecoder.isExpired(response.data['token']));
        print(JwtDecoder.getExpirationDate(response.data['token'])
            .toIso8601String());
        print(JwtDecoder.getRemainingTime(response.data['token']).inHours);
      }
      _autoLogout();
      notifyListeners();
      sharedPreferences.setString('jwt', response.data['token']);
    } catch (e) {
      print(e);
    }
  }

  Future<void> signup({
    @required String name,
    @required String email,
    @required String password,
  }) async {
    return _authenticate(
      name: name,
      email: email,
      password: password,
      urlSegment: 'signup',
    );
  }

  Future<void> login({
    @required String email,
    @required String password,
  }) async {
    return _authenticate(
      email: email,
      password: password,
      urlSegment: 'login',
    );
  }

  Future<bool> tryAutologin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    if (!sharedPreferences.containsKey('jwt')) {
      return false;
    }

    _jwtToken = sharedPreferences.getString('jwt');

    if (JwtDecoder.isExpired(_jwtToken)) {
      return false;
    }
    _userID = JwtDecoder.decode(_jwtToken)['id'];

    notifyListeners();
    _autoLogout();
    return true;
  }

  void logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    _jwtToken = null;
    _userID = null;
    notifyListeners();
    sharedPreferences.clear();
  }

  void _autoLogout() async {
    if (JwtDecoder.isExpired(_jwtToken)) {
      logout();
    }
  }
}
