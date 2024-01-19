import 'dart:convert';
import 'package:blife_test/models/category.dart';
import 'package:blife_test/models/product.dart';
import 'package:blife_test/utils/Strings/UrlAddress.dart';
import 'package:http/http.dart' as http;

class FakeStore{
  FakeStore();

  Future<List<CategoryProds>> getCategories() async{
    var response = await http.get(Uri.parse(FakeStoreCategoriesUrl));
    var convert = jsonDecode(response.body);
    List<CategoryProds> cats = [];
    for (var item in convert) {
      CategoryProds tempcat = CategoryProds();
      tempcat.name = item.toString();
      cats.add(tempcat);
    }
    return cats;
  }
  Future<List<Products>> getProducts(String cat) async{
    var response = await http.get(Uri.parse("$FakeStoreProdByCategoryUrl$cat"));
    var convert = jsonDecode(response.body);
    List<Products> temp = [];
    for (var item in convert) {
      Products tempProd = Products();
      tempProd.fromMap(item);
      temp.add(tempProd);
    }
    return temp;
  }
}