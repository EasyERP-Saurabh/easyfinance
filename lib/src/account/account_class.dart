class AccountClass {
  final int id;
  final String description;
  final String accountType;

  AccountClass(
      {required this.id, required this.description, required this.accountType});
}

enum AccountType {
  cash,
  bank,
  credit,
}

extension AccountTypeExtension on AccountType {
  String get value => switch (this) {
        AccountType.cash => 'C',
        AccountType.bank => 'B',
        AccountType.credit => 'R'
      };
  String get label => switch (this) {
        AccountType.cash => 'Cash',
        AccountType.bank => 'Bank',
        AccountType.credit => 'Credit'
      };
}

AccountType? getAccountType(String value) => switch (value) {
      'C' => AccountType.cash,
      'B' => AccountType.bank,
      'R' => AccountType.credit,
      _ => null
    };
