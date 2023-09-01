class BudgetClass {
  final int id;
  final int budgetMonth;
  final int budgetYear;
  final int categoryId;
  final String categoryDescription;
  final String categoryType;
  final double amount;
  final String remark;

  BudgetClass(
      {required this.id,
      required this.budgetMonth,
      required this.budgetYear,
      required this.categoryId,
      required this.categoryDescription,
      required this.categoryType,
      required this.amount,
      required this.remark});
}
