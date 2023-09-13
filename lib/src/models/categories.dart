/// A simple class to represent the list of joke categories
// I've skipped the additional methods here that are in the other models due to the simplicity of the model
class Categories {
  final List<String> categories;

  Categories({required this.categories});

  factory Categories.fromJson(List<dynamic> json) {
    return Categories(categories: List<String>.from(json));
  }
}