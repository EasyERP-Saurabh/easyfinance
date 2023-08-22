class TransactionClass {
  final int id;
  final DateTime transactionDate;
  final int categoryId;
  final String categoryDescription;
  final String categoryType;
  final int accountId;
  final String accountDescription;
  final String accountType;
  final double amount;
  final String remark;

  TransactionClass(
      {required this.id,
      required this.transactionDate,
      required this.categoryId,
      required this.categoryDescription,
      required this.categoryType,
      required this.accountId,
      required this.accountDescription,
      required this.accountType,
      required this.amount,
      required this.remark});
}
