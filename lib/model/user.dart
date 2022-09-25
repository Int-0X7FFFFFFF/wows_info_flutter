class User {
  late int id;
  late String name;

  User(this.id, this.name);

  bool initUser(int targetId) {
    id = targetId;
    return false;
  }

  int get getId => id;

  String get getName => name;
}
