

class ProductModel{
  dynamic id;
  dynamic title;
  dynamic price;
  dynamic description;
  dynamic category;
  dynamic image;
  Rating? rating;
  ProductModel.fromjson(Map<String,dynamic>json){
    id = json['id'];
    title = json['title'];
    price = json['price'];
    description = json['description'];
    category = json['category'];
    image = json['image'];
    rating = Rating.fromjson(json['rating']);
  }
  Map<String,dynamic>tojson(){
    return{
  'id' :id ,
  'title':title ,
  'price':price ,
  'description':description,
  'category':category,
  'image':image,
   'rating':rating!.toMap(),
  };
}
}
class Rating{
  dynamic rate;
  dynamic count;
  Rating.fromjson(Map<String,dynamic>json){
    rate = json['rate'];
    count = json['count'];
  }
  Map<String,dynamic>toMap(){
    final data=<String,dynamic>{};

      data['rate']=rate;
      data['count']=count;
      return data;
  }


}