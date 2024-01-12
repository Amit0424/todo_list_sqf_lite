class Category{
  late int id;
  late String name;
  late String description;

  categoryMap(){
    final mapping = <String, dynamic>{};
    mapping['id'] = id;
    mapping['name'] = name;
    mapping['description'] = description;

    return mapping;
  }
}