import 'dart:convert';

import 'package:blife_test/APInServices/FakeStore/FakeStore.dart';
import 'package:blife_test/APInServices/ShoppingCart/shopcart.dart';
import 'package:blife_test/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:blife_test/models/category.dart';
import 'package:blife_test/models/product.dart';
import 'package:blife_test/models/user.dart';
import 'package:blife_test/ui/components/CategoryCard.dart';
import 'package:blife_test/ui/components/MainButton.dart';
import 'package:blife_test/ui/components/ProductCard.dart';
import 'package:blife_test/ui/components/ProductPicture.dart';
import 'package:blife_test/ui/components/TextTitle.dart';
import 'package:blife_test/ui/components/ToastAlert.dart';
import 'package:blife_test/utils/navigator.dart';
import 'package:blife_test/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User user = User();
  FakeStore fakeStore = FakeStore();
  late ShoppingCart shopCart;

  List<CategoryProds> categories = [];
  List<Products> products = [];

  int prodIndex = 0;
  int prodCount = 1;

  SharedPreferencesHelper shadPrefs = SharedPreferencesHelper();

  CarouselController prodSlideCtrl = CarouselController();

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
                nextScreen(context, shop_cart_route);
              },
            ),
          ],
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15,),
            TextTitle(title: " Teléfono: ${user.phone}", fontSize: 16.0, fontWeight: FontWeight.bold),
            const SizedBox(height: 20,),
            const TextTitle(title: " Categorias", fontSize: 16.0, fontWeight: FontWeight.bold),
            const SizedBox(height: 10,),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 30,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return CategoryCard(
                    text: TextTitle(title: categories[index].name, fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),
                    onTap: () => changeCategory(index),
                    bg: Colors.deepPurple,
                  );
                },
              )
            ),
            const SizedBox(height: 20,),
            const TextTitle(title: " Productos", fontSize: 16.0, fontWeight: FontWeight.bold),
            const SizedBox(height: 10,),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 300,
              // padding: EdgeInsets.all(20),
              alignment: Alignment.center,
              child: CarouselSlider.builder(
                itemCount: products.isEmpty ? 1 : products.length,
                carouselController: prodSlideCtrl,
                itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                  products.isEmpty ? const Text("Vacio")
                  : ProductCard(
                    textName: TextTitle(title: products[itemIndex].name, fontSize: 16.0, fontWeight: FontWeight.normal, color: Colors.white,),
                    textPrice: TextTitle(title: "Precio: \$${products[itemIndex].price}", fontSize: 16.0, fontWeight: FontWeight.normal, color: Colors.white,),
                    image: ProductPicture(image: NetworkImage(products[itemIndex].picture))
                  ),
                options: CarouselOptions(
                  enableInfiniteScroll: false,
                  height: 300.0,
                  onPageChanged: (index, reason) {
                    setState(() {
                      prodIndex = index;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 20,),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 1,
                    child: MainButton(
                      text: const TextTitle(title: "-", fontSize: 22.0, fontWeight: FontWeight.bold, color: Colors.white,), 
                      onTap: _minusProd, width: 100, height: 50, bg: Colors.black,
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    child: MainButton(
                      text: TextTitle(title: "Añadir $prodCount", fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.white,),
                      onTap: _addToCart, width: 100, height: 50, bg: Colors.blueAccent,
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: MainButton(
                      text: const TextTitle(title: "+", fontSize: 22.0, fontWeight: FontWeight.bold, color: Colors.white,), 
                      onTap: _plusProd, width: 100, height: 50, bg: Colors.black,
                    ),
                  )
                ],
              )
            ),
            const SizedBox(height: 10,),
            TextTitle(title: "Sub Total: ${prodCount * double.parse( products.isEmpty ? "0" : products[prodIndex].price)}", fontSize: 16.0, fontWeight: FontWeight.bold),
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

    shopCart = ShoppingCart(shadPrefs: shadPrefs);
  }

  Future<void> _addToCart() async {
    shopCart.saveCart(products, prodIndex,prodCount);
    setState(() {
      prodCount=1;
    });
  }

  void _plusProd(){
    setState(() {
      prodCount++;
    });
  }

  void _minusProd(){
    if(prodCount == 1){
      ToastAlert().showToastAlert("Minimo un producto", false);
    }else{
      setState(() {
        prodCount--;
      });
    }
  }
  void changeCategory(index) async {
    products.clear();
    products = await fakeStore.getProducts(categories[index].name);
    setState(() {
      products;
    });
    prodSlideCtrl.jumpToPage(0);
  }

}