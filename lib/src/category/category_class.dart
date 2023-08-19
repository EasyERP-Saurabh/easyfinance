class CategoryClass {
  final int id;
  final String description;
  final String categoryType;

  CategoryClass(
      {required this.id,
      required this.description,
      required this.categoryType});
}

enum CategoryType {
  income,
  expenditure,
}

extension CategoryTypeExtension on CategoryType {
  String get value => switch (this) {
        CategoryType.income => 'I',
        CategoryType.expenditure => 'E'
      };
}

CategoryType? getCategoryType(String value) => switch (value) {
      'I' => CategoryType.income,
      'E' => CategoryType.expenditure,
      _ => null
    };
