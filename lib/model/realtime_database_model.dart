import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseModel {
  //Firebase.Auth.FirebaseUser user;
  late final dref = FirebaseDatabase.instance.reference();
  late DatabaseReference databaseReference;
  final FirebaseAuth auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
  String? releaseTitle;
  String? releaseLabel;
  String? title;
  String? copyrightHolder;
  String? upc;
  String? genre;
  String? primaryArtist;
  String? trackTitle;
  String? parentalAdvistory;
  String? copyrightHolder5;
  String? isrc;
  String? primaryArtist5;
  String? role;
  String? writer;
  String? imageReference;
  String? audioReference;
  String? lyrics;
  void s1(String title, String storage) {
    releaseTitle = title;
    imageReference = storage;
    setData1();
  }

  void s2(String audio) {
    audioReference = audio;
    setData2();
  }

  void s3(String pArtist) {
    primaryArtist = pArtist;
    setData3();
  }

  void s4(
      String title, String label, String copyright, String upc, String genre) {
    this.title = title;
    releaseLabel = label;
    copyrightHolder = copyright;
    this.upc = upc;
    this.genre = genre;
    setData4();
  }

  void s5(String tTitle, String pAdvistory, String copyright, String isrc,
      String pArtist, String role, String writer) {
    this.trackTitle = tTitle;
    parentalAdvistory = pAdvistory;
    copyrightHolder5 = copyright;
    this.isrc = isrc;
    primaryArtist5 = pArtist;
    this.role = role;
    this.writer = writer;
    setData5();
  }

  void addLyrics(String lyrics) {
    this.lyrics = lyrics;
    setDataL();
  }

  setData1() {
    dref.child(user!.uid.toString()).update({
      "releaseTitle": releaseTitle,
      "imageReference": imageReference,
    });
  }

  setData2() {
    dref.child(user!.uid.toString()).update({"audioReference": audioReference});
  }

  setData3() {
    dref.child(user!.uid.toString()).update({
      "primaryArtist": primaryArtist,
    });
  }

  setData4() {
    dref.child(user!.uid.toString()).update({
      "title": title,
      "releaseLabel": releaseLabel,
      "copyrightHolder": copyrightHolder,
      "UPC": upc,
      "genre": genre,
    });
  }

  setData5() {
    dref.child(user!.uid.toString()).update({
      "trackTitle": trackTitle,
      "parentalAdvistory": parentalAdvistory,
      "copyrightHolder5": copyrightHolder5,
      "isrc": isrc,
      "primaryArtist5": primaryArtist5,
      "role": role,
      "writer": writer,
    });
  }

  setDataL() {
    dref.child(user!.uid.toString()).update({
      "lyrics": lyrics,
    });
  }
}
