import 'category.dart';

class CategoryOperations {
  CategoryOperations._() {}
  static List<Category> getCategories() {
    return <Category>[
      Category('Top Songs A',
          'https://i.scdn.co/image/ab67706c0000da84f71afded6326f0b319311eb9'),
      Category('Top Songs B',
          'https://i.scdn.co/image/ab67706c0000da84f71afded6326f0b319311eb9'),
      Category('Top Songs C',
          'https://i.scdn.co/image/ab67706c0000da84f71afded6326f0b319311eb9'),
      Category('Top Songs D',
          'https://i.scdn.co/image/ab67706c0000da84f71afded6326f0b319311eb9'),
    ];
  }
}
