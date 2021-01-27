class User {
  String name;
  String login;
  String password;
  String singUpDate;

  User();

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        login = json['login'],
        password = json['password'],
        singUpDate = json['singUpDate'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'login': login,
        'password': password,
        'singUpDate': singUpDate
      };
}
