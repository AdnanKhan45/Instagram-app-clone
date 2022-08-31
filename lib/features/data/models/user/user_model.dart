import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone_app/features/domain/entities/user/user_entity.dart';

class UserModel extends UserEntity {
  final String? uid;
  final String? username;
  final String? name;
  final String? bio;
  final String? website;
  final String? email;
  final String? profileUrl;
  final List? followers;
  final List? following;
  final num? totalFollowers;
  final num? totalFollowing;
  final num? totalPosts;

  UserModel({
    this.uid,
    this.username,
    this.name,
    this.bio,
    this.website,
    this.email,
    this.profileUrl,
    this.followers,
    this.following,
    this.totalFollowers,
    this.totalFollowing,
    this.totalPosts,
  }) : super(
    uid: uid,
    totalFollowing: totalFollowing,
    followers: followers,
    totalFollowers: totalFollowers,
    username: username,
    profileUrl: profileUrl,
    website: website,
    following: following,
    bio: bio,
    name: name,
    email: email,
    totalPosts: totalPosts,
  );

  factory UserModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return UserModel(
      email: snapshot['email'],
      name: snapshot['name'],
      bio: snapshot['bio'],
      username: snapshot['username'],
      totalFollowers: snapshot['totalFollowers'],
      totalFollowing: snapshot['totalFollowing'],
      totalPosts: snapshot['totalPosts'],
      uid: snapshot['uid'],
      website: snapshot['website'],
      profileUrl: snapshot['profileUrl'],
      followers: List.from(snap.get("followers")),
      following: List.from(snap.get("following")),
    );
  }

  Map<String, dynamic> toJson() => {
    "uid": uid,
    "email": email,
    "name": name,
    "username": username,
    "totalFollowers": totalFollowers,
    "totalFollowing": totalFollowing,
    "totalPosts": totalPosts,
    "website": website,
    "bio": bio,
    "profileUrl": profileUrl,
    "followers": followers,
    "following": following,
  };
}
