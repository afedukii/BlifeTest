import 'dart:convert';

import 'package:http/http.dart' as http;
class RandomUser {
  
  RandomUser(){
    getRandomUser();
  }

  Future<void> getRandomUser() async{
    var response = await http.get(Uri.parse('https://randomuser.me/api/?inc=name.title,login,picture,phone'));
    var convert = jsonDecode(response.body);
    print(response.body);
    //obtener con movimiento de json [tag padre][tag hijo][tag nieto]
  }
}