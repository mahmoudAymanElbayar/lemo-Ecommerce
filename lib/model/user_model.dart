// {
// "name": "Open Graph Test User",
// "email": "open_jygexjs_user@tfbnw.net",
// "picture": {
// "data": {
// "height": 126,
// "url": "https://scontent.fuio21-1.fna.fbcdn.net/v/t1.30497-1/s200x200/84628273_176159830277856_972693363922829312_n.jpg",
// "width": 200
// }
// },
// "id": "136742241592917"
// }
class UserModel{
  String? name;
  String? email;
  String? image;
  String? uId;
  UserModel(this.name,this.email,this.image,this.uId);
  UserModel.fromjson(Map <String,dynamic>json){
    name = json['name'];
    email = json['email'];
    image = json['image'];
    uId = json['uId'];
  }
  Map<String,dynamic>toMap(){
    return{
      'name':name,
      'email':email,
      'uId':uId,
      'image':image,
    };
  }
}