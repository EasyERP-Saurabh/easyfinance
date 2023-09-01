class Api {
  static const _host = "www.ieasyerp.com";
  static var login = Uri.https(_host, '/api.easyfinance/login.php');

  //Category
  static var categoriesList =
      Uri.https(_host, '/api.easyfinance/categories/list.php');
  static var categoryRead =
      Uri.https(_host, '/api.easyfinance/categories/read.php');
  static var categoryInsert =
      Uri.https(_host, '/api.easyfinance/categories/insert.php');
  static var categoryUpdate =
      Uri.https(_host, '/api.easyfinance/categories/update.php');
  static var categoryDelete =
      Uri.https(_host, '/api.easyfinance/categories/delete.php');

  //Account
  static var accountsList =
      Uri.https(_host, '/api.easyfinance/accounts/list.php');
  static var accountRead =
      Uri.https(_host, '/api.easyfinance/accounts/read.php');
  static var accountInsert =
      Uri.https(_host, '/api.easyfinance/accounts/insert.php');
  static var accountUpdate =
      Uri.https(_host, '/api.easyfinance/accounts/update.php');
  static var accountDelete =
      Uri.https(_host, '/api.easyfinance/accounts/delete.php');

  //Transaction
  static var transactionsList =
      Uri.https(_host, '/api.easyfinance/transactions/list.php');
  static var transactionRead =
      Uri.https(_host, '/api.easyfinance/transactions/read.php');
  static var transactionInsert =
      Uri.https(_host, '/api.easyfinance/transactions/insert.php');
  static var transactionUpdate =
      Uri.https(_host, '/api.easyfinance/transactions/update.php');
  static var transactionDelete =
      Uri.https(_host, '/api.easyfinance/transactions/delete.php');

  //Budget
  static var budgetList = Uri.https(_host, '/api.easyfinance/budget/list.php');
  static var budgetRead = Uri.https(_host, '/api.easyfinance/budget/read.php');
  static var budgetInsert =
      Uri.https(_host, '/api.easyfinance/budget/insert.php');
  static var budgetUpdate =
      Uri.https(_host, '/api.easyfinance/budget/update.php');
  static var budgetDelete =
      Uri.https(_host, '/api.easyfinance/budget/delete.php');

  static Map<String, String> headers = {'Content-Type': 'application/json'};
}
