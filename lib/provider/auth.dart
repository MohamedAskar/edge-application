import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String role;

  User(
      {@required this.name,
      @required this.email,
      @required this.id,
      @required this.role});
}

class Auth with ChangeNotifier {
  String _jwtToken;
  String _userID;
  String userName;
  String email;
  bool isAdmin;
  List<User> _users;

  List<User> get users {
    return [..._users];
  }

  String get userID {
    return _userID;
  }

  bool get isAuth {
    return false;
  }

  static const URL = 'https://evening-cliffs-75470.herokuapp.com';

  Future<void> getAllUsers() async {
    final url = '$URL/api/v1/users';
    final response = await http.get(Uri.parse(url));

    List<User> loadedUsers = [];

    try {
      final data = json.decode(response.body) as Map<String, dynamic>;
      final List<dynamic> users = data['data']['users'];

      users.forEach((user) {
        loadedUsers.add(User(
            name: user['name'],
            email: user['email'],
            id: user['_id'],
            role: user['role']));
      });
      _users = loadedUsers;
    } catch (e) {
      throw e;
    }
    notifyListeners();
  }

  Future<void> getUserData() async {
    final url = '$URL/api/v1/users/getuser?_id=$_userID';
    try {
      final response = await http.get(
        Uri.parse(url),
      );

      print(response.body);

      final data = json.decode(response.body) as Map<String, dynamic>;
      userName = data['data'][0]['name'];
      print(userName);
      email = data['data'][0]['email'];
      print(email);
    } catch (e) {
      throw e;
    }

    notifyListeners();
  }

  Future<void> _authenticate(
      {String name,
      @required String email,
      @required String password,
      @required String urlSegment}) async {
    final url = '$URL/api/v1/users/$urlSegment';
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map<String, String> data = {};

    if (name != null) {
      data = {
        "name": name,
        "email": email.trim(),
        "password": password,
        "passwordConfirm": password
      };
    } else {
      data = {
        "email": email.trim(),
        "password": password,
      };
    }

    String body = json.encode(data);

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      final responseData = json.decode(response.body);
      print(responseData);
      if (responseData['status'] == 'fail') {
        throw HttpException(responseData['message']);
      } else {
        _userID = JwtDecoder.decode(responseData['token'])['id'];
        _jwtToken = responseData['token'];
        isAdmin = (responseData['role'] == 'admin') ? true : false;
        print('isAdmin: $isAdmin');
        print(responseData);
        print(JwtDecoder.decode(responseData['token']));
        print(JwtDecoder.isExpired(responseData['token']));
        print(JwtDecoder.getExpirationDate(responseData['token'])
            .toIso8601String());
        print(JwtDecoder.getRemainingTime(responseData['token']).inHours);
      }
      _autoLogout();
      notifyListeners();
      sharedPreferences.setString('jwt', _jwtToken);
      sharedPreferences.setBool('isAdmin', isAdmin);
    } catch (e) {
      throw e;
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
    isAdmin = sharedPreferences.getBool('isAdmin');

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
    isAdmin = null;
    notifyListeners();
    sharedPreferences.clear();
  }

  void _autoLogout() async {
    if (JwtDecoder.isExpired(_jwtToken)) {
      logout();
    }
  }
}
