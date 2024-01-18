import 'package:blife_test/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:blife_test/ui/components/ToastAlert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShoppingCart{
  SharedPreferencesHelper shadPrefs;
  List<String> cart = [];
  List<List<String>> actualCart = [[]];

  ShoppingCart({
    required this.shadPrefs,
  });

  void saveCart(products, prodIndex,prodcount) async{
    var actualCart = await shadPrefs.getDataList('cart');
    if(actualCart != null){
      var tempItem = [
        products[prodIndex].name,
        '${prodcount * double.parse(products[prodIndex].price)}',
        products[prodIndex].picture
      ];

      actualCart.add('${products[prodIndex].name};${prodcount * double.parse(products[prodIndex].price)};${products[prodIndex].picture}');
      shadPrefs.saveDataList('cart', actualCart);
    }else{
      List<String> temp = [];
      temp.add('${products[prodIndex].name};${prodcount * double.parse(products[prodIndex].price)};${products[prodIndex].picture}');
      shadPrefs.saveDataList('cart', temp);
    }
    ToastAlert().showToastAlert("Producto agregado al carrito", true);
  }

  Future<void> getCart () async{
   var data = await shadPrefs.getDataList('cart');
   if(data != null){
    List<List<String>> tempRes = [[]];
    tempRes.clear();
    for(var item in data!){
      var splitted = item.split(';');
      List<String> tempItem = [];
      for(var i in splitted){
      tempItem.add(i);
      }
      tempRes.add(tempItem);
    }
    actualCart = tempRes;
   }else{
    actualCart = [[]];
   }
  }

  double getTotal (){
    double total = 0;
    if(actualCart[0].isNotEmpty){
      for(var item in actualCart){
        total += double.parse(item[1]);
      }
      return total;
    }else {
      return 0;
    }
  }

  void voidCart(){
    shadPrefs.delData('cart');
  }
}