class Category{
  int? id;
  String? name;
  String? description;

  categoryMap(){
    final mapping = <String, dynamic>{};
    mapping['id'] = id;
    mapping['name'] = name;
    mapping['description'] = description;

    return mapping;
  }
}