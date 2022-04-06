abstract class BaseModel {
  String? id;

  Map<String, dynamic>  toMap();

  BaseModel? fromMap(Map<String, dynamic> map);
}
