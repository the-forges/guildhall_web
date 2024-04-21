class Profile {
  Profile();

  Profile.fromJson(Map<String, dynamic> data) {
    id = data['id'];
    displayName = data['display_name'];
  }

  late String id;
  String? displayName;

  toJson() => {
    'id': id,
    'display_name': displayName
  };
}