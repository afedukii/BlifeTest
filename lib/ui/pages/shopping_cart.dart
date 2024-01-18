import 'package:blife_test/APInServices/ShoppingCart/shopcart.dart';
import 'package:blife_test/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:blife_test/ui/components/SlidableCard.dart';
import 'package:blife_test/ui/components/TextTitle.dart';
import 'package:flutter/material.dart';

class ShopCartPage extends StatefulWidget {
  const ShopCartPage({Key? key}) : super(key: key);
  @override
  State<ShopCartPage> createState() => _ShopCartPageState();
}

class _ShopCartPageState extends State<ShopCartPage> {
  SharedPreferencesHelper shadPrefs = SharedPreferencesHelper();
  ShoppingCart? shopCart;
  
  List<String> tempTexts = ['000','000','000'];

  @override
  void initState() {
    _initData();
    super.initState();
  }

  @override
  Widget build(context){
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: const TextTitle(title: "Carrito", fontSize: 18.0, fontWeight: FontWeight.bold,color: Colors.white,),
          backgroundColor: Colors.deepPurple,
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if(shopCart != null){
              shopCart!.voidCart();
            }
          },
          foregroundColor: Colors.white,
          backgroundColor: Colors.deepPurple,
          child: const Icon(Icons.paid),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextTitle(title: "Productos: ${shopCart != null ? shopCart!.actualCart[0].isNotEmpty ? shopCart!.actualCart.length : 0 :0}", fontSize: 16.0, fontWeight: FontWeight.bold),
                  TextTitle(title: "Total: \$${shopCart != null ? shopCart!.getTotal() : 0.0}", fontSize: 16.0, fontWeight: FontWeight.bold),
                ],
              ),
               TextTitle(title:shopCart != null ? shopCart!.actualCart.isNotEmpty ? "Desliza para eliminar del carrito" : 'Tu carrito esta vacío' :'vacio' , fontSize: 12.0, fontWeight: FontWeight.normal),
              Expanded(
                child: ListView.builder(
                  itemCount: shopCart != null && shopCart!.actualCart[0].isNotEmpty ? shopCart!.actualCart.length : 0 ,
                  itemBuilder: (context, index) {
                    return SlidableCard(item: shopCart!.actualCart[index], onPressed: dismissItem);
                  },
                ),
              )
            ],
          ),
        )
      ),
    );
  }

  Future<void> _initData () async {
    await shadPrefs.SharedPrefsInit();
    setState(() {
      shopCart = ShoppingCart(shadPrefs: shadPrefs);
    });
    
    _getData();
  }
  Future<void> _getData () async {
    await shopCart!.getCart();
  }

  void dismissItem(context){

  }
}