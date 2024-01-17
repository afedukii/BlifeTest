import 'dart:convert';

import 'package:blife_test/API%20Services/RandomUser/RandomUser.dart';
import 'package:blife_test/ui/components/TextInputForm.dart';
import 'package:blife_test/ui/components/TextTitle.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:indexed/indexed.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  @override
  void initState(){
    test();
    super.initState();
  }

  @override
  Widget build(context){
    return Material(
      child: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const TextTitle(title: "Blife Test App",color: Colors.deepPurple, fontSize: 25.0, fontWeight: FontWeight.bold),
                TextInputForm(controller: _emailCtrl, inputType: TextInputType.emailAddress, hintText: 'Email:',),
                TextInputForm(controller: _passCtrl, inputType: TextInputType.visiblePassword, hintText: 'Password:',),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
              height: 60,
              width: 200,
              padding: EdgeInsets.symmetric(vertical: 10),
              color: Colors.deepPurple,
              alignment: Alignment.center,
              child: const TextTitle(title: "Ingresar", fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white,),
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(10),
              alignment: Alignment.bottomLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextTitle(title: "Test Email: *****", fontSize: 14.0, fontWeight: FontWeight.w400),
                  TextTitle(title: "Test Password: *****", fontSize: 14.0, fontWeight: FontWeight.w400),
                ],
              )
            ),
          )
        ],
      ),
      ),
    );
  }

  Future<void> test() async{
    RandomUser tempUser = RandomUser();
    // var response = await http.get(Uri.parse('https://fakestoreapi.com/users/2'));
    // print(response.body);

    // response = await http.post( Uri.parse('https://fakestoreapi.com/auth/login'),
    //   headers: <String, String>{
    //     'Content-Type': 'application/json; charset=UTF-8',
    //   },
    //   body: jsonEncode(<String, String>{
    //     'username': "mor_2314",
    //     'password': "83r5^"
    //   }),
    // );
    // print(response.body);
  }
}