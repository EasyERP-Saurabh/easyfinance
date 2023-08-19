class TransactionClass {
  final int id;
  final DateTime transactionDate;
  final int categoryId;
  final int accountId;
  final double amount;
  final String remark;

  TransactionClass(
      {required this.id,
      required this.transactionDate,
      required this.categoryId,
      required this.accountId,
      required this.amount,
      required this.remark});
}
