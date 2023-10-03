import 'package:untitled/screens/model/user_dob.dart';
import 'package:untitled/screens/model/user_location.dart';
import 'package:untitled/screens/model/user_name.dart';
import 'package:untitled/screens/model/user_pic.dart';

class User {
  final String gender;
  final String email;
  final String phone;
  final String cell;
  final String nat;
  final UserName name;
  final UserDob dob;
  final UserLocation location;
  final UserPicture picture;
  User({
    required this.gender,
    required this.email,
    required this.phone,
    required this.cell,
    required this.nat,
    required this.name,
    required this.dob,
    required this.location,
    required this.picture,
  });

  factory User.fromMap(Map<String, dynamic> e) {
    final name = UserName.fromMap(e['name']);
    final dob = UserDob.fromMap(e['dob']);
    final picture = UserPicture.fromMap(e['picture']);
    final location = UserLocation.fromMap(e['location']);
    return User(
        picture: picture,
        location: location,
        dob: dob,
        name: name,
        gender: e['gender'],
        email: e['email'],
        phone: e['phone'],
        cell: e['cell'],
        nat: e['nat']);
  }
  String get fullName {
    return '${name.title} ${name.first} ${name.last}';
  }
}
