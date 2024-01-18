import 'dart:convert';

import 'package:http/http.dart' as http;
class RandomUser {
  var data;
  String name;
  String username;
  String password;
  String phone;
  String picture;

  RandomUser({
    this.name = "",
    this.username = "",
    this.password = "",
    this.phone = "",
    this.picture = ""
  });

  Future<void> genRandomUser() async{
    var response = await http.get(Uri.parse('https://randomuser.me/api/?inc=name,login,picture,phone'));
    var convert = jsonDecode(response.body);
    data = convert;
    name = convert['results'][0]['name']['first'] + ' ' +  convert['results'][0]['name']['last'];
    username = convert['results'][0]['login']['username'];
    password = convert['results'][0]['login']['password'];
    phone = convert['results'][0]['phone'];
    picture = convert['results'][0]['picture']['medium'];
  }
}