class Products{
  int id;
  String name;
  String price;
  String category;
  String description;
  String picture;
  Products({
    this.id = 0,
    this.name = "",
    this.price = "",
    this.category = "",
    this.description = "",
    this.picture = "",
  });
  void fromMap(map){
    id = map['id'];
    name = map['title'];
    price = map['price'].toString();
    category = map['category'];
    description = map['description'];
    picture = map['image'];
  }
}