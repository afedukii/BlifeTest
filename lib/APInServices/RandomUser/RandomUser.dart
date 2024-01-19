import 'dart:convert';

import 'package:blife_test/utils/Strings/UrlAddress.dart';
import 'package:http/http.dart' as http;
class RandomUser {
  var data;
  String name;
  String username;
  String password;
  String phone;

  RandomUser({
    this.name = "",
    this.username = "",
    this.password = "",
    this.phone = ""
  });

  Future<void> genRandomUser() async{
    var response = await http.get(Uri.parse(RandomUserSpecUrl));
    var convert = jsonDecode(response.body);
    data = convert;
    name = convert['results'][0]['name']['first'] + ' ' +  convert['results'][0]['name']['last'];
    username = convert['results'][0]['login']['username'];
    password = convert['results'][0]['login']['password'];
    phone = convert['results'][0]['phone'];
  }
}