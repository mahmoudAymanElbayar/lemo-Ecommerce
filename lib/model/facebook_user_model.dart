
class FaceBookUserModel {
  FaceBookUserModel({
    required this.name,
    required this.email,
    required this.picture,
    required this.id,
  });
  late final String name;
  late final String email;
  late final Picture picture;
  late final String id;

  FaceBookUserModel.fromJson(Map<String, dynamic> json){
    name = json['name'];
    email = json['email'];
    picture = Picture.fromJson(json['picture']);
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['email'] = email;
    _data['picture'] = picture.toJson();
    _data['id'] = id;
    return _data;
  }
}

class Picture {
  Picture({
    required this.data,
  });
  late final Data data;

  Picture.fromJson(Map<String, dynamic> json){
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.height,
    required this.url,
    required this.width,
  });
  late final int height;
  late final String url;
  late final int width;

  Data.fromJson(Map<String, dynamic> json){
    height = json['height'];
    url = json['url'];
    width = json['width'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['height'] = height;
    _data['url'] = url;
    _data['width'] = width;
    return _data;
  }
}