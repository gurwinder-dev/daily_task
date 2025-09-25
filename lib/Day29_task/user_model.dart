
class UserModel {
  final String name;
  bool isOnline;
  bool isTyping;

  UserModel({
    required this.name,
    this.isOnline = true,
    this.isTyping = false,
  });
}
