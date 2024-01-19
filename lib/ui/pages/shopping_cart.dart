import 'package:blife_test/APInServices/ShoppingCart/shopcart.dart';
import 'package:blife_test/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:blife_test/ui/components/SlidableCard.dart';
import 'package:blife_test/ui/components/TextTitle.dart';
import 'package:blife_test/utils/Strings/Buttons.dart';
import 'package:blife_test/utils/Strings/Labels.dart';
import 'package:blife_test/utils/Strings/LocalKeys.dart';
import 'package:blife_test/utils/Strings/Titles.dart';
import 'package:blife_test/utils/colors.dart';
import 'package:blife_test/utils/navigator.dart';
import 'package:blife_test/utils/routes.dart';
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
          title: const TextTitle(title: ShopCartTitle, fontSize: 18.0, fontWeight: FontWeight.bold,color: WhiteColor,),
          backgroundColor: DeepPurpleColor,
          iconTheme: const IconThemeData(
            color: WhiteColor,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: Text(shopCart != null && shopCart!.actualCarts[0].isNotEmpty ? OrderPlacedTitle : VoidShopCartTitle),
                content: Text(shopCart != null && shopCart!.actualCarts[0].isNotEmpty ? PurchaseCompleteLabel : AddProductsLabel),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      if(shopCart != null){
                        shopCart!.voidCart();
                      }
                      nextScreen(context, profile_route);},
                    child: const Text(BackHomeLabel),
                  ),
                ],
              ),
            );
          },
          foregroundColor: WhiteColor,
          backgroundColor: DeepPurpleColor,
          child: const Icon(Icons.shopping_cart_checkout),
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
                  TextTitle(title: "$ProductsLabel ${shopCart != null ? shopCart!.actualCarts[0].isNotEmpty ? shopCart!.actualCarts.length : 0 :0}", fontSize: 16.0, fontWeight: FontWeight.bold),
                  TextTitle(title: "$TotalLabel \$${shopCart != null ? shopCart!.getTotal() : 0.0}", fontSize: 16.0, fontWeight: FontWeight.bold),
                ],
              ),
              const SizedBox(height: 10,),
              TextTitle(title:shopCart != null && shopCart!.actualCarts[0].isNotEmpty ? SlideInstructionLabel : VoidShopCartTitle , fontSize: 12.0, fontWeight: FontWeight.normal),
              const SizedBox(height: 10,),
              Expanded(
                child: ListView.builder(
                  itemCount: shopCart != null && shopCart!.actualCarts[0].isNotEmpty ? shopCart!.actualCarts.length : 0 ,
                  itemBuilder: (context, index) {
                    return SlidableCard(item: shopCart!.actualCarts[index], index: index, 
                    onDelete: (){setState(()  {
                      if(shopCart!.actualCarts.length == 1){
                        shopCart!.actualCarts = [[]];
                        shopCart!.voidCart();
                      }else{
                        shopCart!.actualCarts.removeAt(index);
                      }
                      if(shopCart!.actualCarts[0].isNotEmpty){
                        shadPrefs.saveDataList(LocalCartKey, shopCart!.getList());
                      }
                      _getData();
                    });});
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
}