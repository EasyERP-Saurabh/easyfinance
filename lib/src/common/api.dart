class Api {
  static const _host = "www.ieasyerp.com";
  static var login = Uri.https(_host, '/api.easyfinance/login.php');
  static var categoriesList =
      Uri.https(_host, '/api.easyfinance/categories/list.php');
  static var categoryRead =
      Uri.https(_host, '/api.easyfinance/categories/read.php');
  static var categoryInsert =
      Uri.https(_host, '/api.easyfinance/categories/insert.php');
  static var categoryUpdate =
      Uri.https(_host, '/api.easyfinance/categories/update.php');

  static Map<String, String> headers = {'Content-Type': 'application/json'};
}
