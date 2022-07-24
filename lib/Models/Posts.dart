
// Custom Post Class

import 'package:cloud_firestore/cloud_firestore.dart';

class Post{

  late final  String? author_uid;
  late final String? author;
  late final String? title;
  late final String? detail;
  dynamic profilepic;
  late final String? Username;
  late final DateTime? Timeposted;
  late final String? imageurl;
  late final String? ppurl;
  late final String? Name;
  late final String? imageUrl;
  late final String postuid;
  late final List likes;
  late final List posturl;

  Post({ required this.author_uid,
    required this.postuid,
    this.profilepic,
    required  this.detail,
    required this.author,
    this.title,
    required  this.Timeposted,
    this.imageurl,
    this.ppurl,
    required this.posturl,
    this.imageUrl
  });

  Map<String,dynamic> toJson()=>{

    "author uid":author_uid,
    "author":author,
    "title":title,
    "Post Time":Timeposted,
    "profilepic":ppurl,
    "Post Url":posturl,
    "Imageurl":imageUrl,
    "Post Uid":postuid,
    "detail":detail,
  };

  static Post? FromSnap(DocumentSnapshot snap){
    var snapshot= snap.data() as Map<String,dynamic>;
    Post? Post12=Post(
        detail: snapshot['detail'],
        author_uid: snapshot['author uid'],
        author: snapshot['author'],
        Timeposted: snapshot['Post Time'],
        ppurl: snapshot['profilepic'],
        posturl: snapshot['Post url'],
        imageUrl: snapshot['Imageurl'],
        postuid: snapshot['Post Uid']
    );

    return Post12;






  }
}