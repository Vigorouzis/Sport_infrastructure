class User{
  final String uid;
  final String login;
  final String email;
  final int age;
  final String password;

  User({this.uid, this.login, this.email, this.age, this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uid: json['uid'],
      login: json['login'],
      email: json['email'],
      age: json['age'],
      password: json['password'],
    );
  }
}
