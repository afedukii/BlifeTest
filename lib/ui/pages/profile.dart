import 'dart:convert';

import 'package:blife_test/API%20Services/FakeStore/FakeStore.dart';
import 'package:blife_test/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:blife_test/models/category.dart';
import 'package:blife_test/models/product.dart';
import 'package:blife_test/models/user.dart';
import 'package:blife_test/ui/components/MainButton.dart';
import 'package:blife_test/ui/components/TextTitle.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User user = User();
  FakeStore fakeStore = FakeStore();
  List<CategoryProds> categories = [];
  List<Products> products = [];

  List<String> templist = ['1','2','3','1','2','3','1','2','3','1','2','3','1','2','3'];
  List<String> tempProds = ['a','b','a','b','a','b'];

  SharedPreferencesHelper shadPrefs = SharedPreferencesHelper();

  @override
  void initState() {
    _getUserData();
    super.initState();
  }

  @override
  Widget build(context){
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: TextTitle(title: "Hola! ${user.name}", fontSize: 18.0, fontWeight: FontWeight.bold,color: Colors.white,),
          backgroundColor: Colors.deepPurple,
          actions: [
            IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('This is a snackbar')));
              },
            ),
          ],
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextTitle(title: " Teléfono: ${user.phone}", fontSize: 16.0, fontWeight: FontWeight.bold),
            SizedBox(height: 20,),
            TextTitle(title: " Categorias", fontSize: 16.0, fontWeight: FontWeight.bold),
            SizedBox(height: 10,),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 30,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Category(index);
                },
              )
            ),
            SizedBox(height: 20,),
            TextTitle(title: " Productos", fontSize: 16.0, fontWeight: FontWeight.bold),
            SizedBox(height: 10,),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 300,
              child: PageView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return ProductCard(index);
                },
              ),
            ),
          ],
        ),
      )
    );
  }

  void _getUserData() async{
    await shadPrefs.SharedPrefsInit();
    
    user.name = (await shadPrefs.getData('name'))!;
    user.username = (await shadPrefs.getData('username'))!;
    user.password = (await shadPrefs.getData('password'))!;
    user.phone = (await shadPrefs.getData('phone'))!;

    categories = await fakeStore.getCategories();
    products = await fakeStore.getProducts(categories[0].name);
    setState(() {
      user;
      products;
    });
  }

  Widget Category(index)=>GestureDetector(
    onTap: () async {
      products.clear();
      products = await fakeStore.getProducts(categories[index].name);
      setState(() {
        products;
      });
    },
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      margin: EdgeInsets.only(right: 10),
      color: Colors.deepPurple,
      child: TextTitle(title: categories[index].name, fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),
    )
  );

  Widget ProductCard(index)=>Container(
    width:200,
    height: 250,
    margin: EdgeInsets.symmetric(horizontal: 20),
    color: Colors.red,
    child: TextTitle(title: products[index].name, fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),
  );
}