import 'package:todo_list_sqf_lite/model/category.dart';
import 'package:todo_list_sqf_lite/repositories/repository.dart';

class CategoryService{

  late Repository _repository;

  CategoryService(){
    _repository = Repository();
  }

  saveCategory(Category category) async {
    return await _repository.insertData('categories', category.categoryMap());
  }
}