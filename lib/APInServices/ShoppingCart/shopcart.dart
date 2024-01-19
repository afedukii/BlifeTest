import 'package:blife_test/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:blife_test/ui/components/ToastAlert.dart';
import 'package:blife_test/utils/Strings/Alerts.dart';
import 'package:blife_test/utils/Strings/LocalKeys.dart';

class ShoppingCart{
  SharedPreferencesHelper shadPrefs;
  List<String> cart = [];
  List<List<String>> actualCarts = [[]];

  ShoppingCart({
    required this.shadPrefs,
  });

  void saveCart(products, prodIndex,prodcount) async{
    var actualCart = await shadPrefs.getDataList(LocalCartKey);
    if(actualCart != null){
      actualCart.add('${products[prodIndex].name};${prodcount * double.parse(products[prodIndex].price)};${products[prodIndex].picture}');
      shadPrefs.saveDataList(LocalCartKey, actualCart);
    }else{
      List<String> temp = [];
      temp.add('${products[prodIndex].name};${prodcount * double.parse(products[prodIndex].price)};${products[prodIndex].picture}');
      shadPrefs.saveDataList(LocalCartKey, temp);
    }
    ToastAlert().showToastAlert(ProdAddedToCartAlert, true);
  }

  Future<void> getCart () async{
   var data = await shadPrefs.getDataList(LocalCartKey);
   if(data != null){
    List<List<String>> tempRes = [[]];
    tempRes.clear();
    for(var item in data){
      var splitted = item.split(';');
      List<String> tempItem = [];
      for(var i in splitted){
      tempItem.add(i);
      }
      tempRes.add(tempItem);
    }
    actualCarts = tempRes;
   }else{
    actualCarts = [[]];
   }
  }

  double getTotal (){
    double total = 0;
    if(actualCarts[0].isNotEmpty){
      for(var item in actualCarts){
        total += double.parse(item[1]);
      }
      return total;
    }else {
      return 0;
    }
  }

  void voidCart(){
    shadPrefs.delData(LocalCartKey);
  }


  List<String> getList(){
    List<String> temp = [];
    for(var item in actualCarts){
      temp.add('${item[0]};${item[1]};${item[2]}');
    }
    return temp;
  }
}