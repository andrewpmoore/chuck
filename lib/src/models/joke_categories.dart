/// A simple class to represent the list of joke categories
// I've skipped the additional methods here that are in the other models due to the simplicity of the model
class JokeCategories {
  final List<String> categories;

  JokeCategories({required this.categories});

  factory JokeCategories.fromJson(List<dynamic> json) {
    return JokeCategories(categories: List<String>.from(json));
  }
}