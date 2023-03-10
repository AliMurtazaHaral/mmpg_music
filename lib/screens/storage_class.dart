import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;

class Storage {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  Future<void> uploadFileImage(String? path, String? fileN) async {
    String? filePath = path;
    String? fileName = fileN;
    File file = File(filePath!);
    try {
      await storage.ref('music/images/$fileName').putFile(file);
    } on firebase_core.FirebaseException catch (e) {
      print(e);
    }
  }

  Future<void> uploadFileAudio(String? path, String? fileN) async {
    String? filePath = path;
    String? fileName = fileN;
    File file = File(filePath!);
    try {
      await storage.ref('music/audio/$fileName').putFile(file);
    } on firebase_core.FirebaseException catch (e) {
      print(e);
    }
  }

  Future<firebase_storage.ListResult> listFiles() async {
    firebase_storage.ListResult result =
        await storage.ref('music/audio').listAll();
    return result;
  }
}
