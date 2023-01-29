import 'package:flutter/material.dart';
import 'package:music_app/screens/storage_class.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../constants.dart';

class CloudStorageInfo {
  final String? svgSrc, title, totalStorage;
  final int? numOfFiles, percentage;
  final Color? color;

  CloudStorageInfo({
    this.svgSrc,
    this.title,
    this.totalStorage,
    this.numOfFiles,
    this.percentage,
    this.color,
  });
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<int?> listAudio() async {
    firebase_storage.ListResult result =
        await storage.ref('music/audio').listAll();
    for (var ref in result.items) {
      totalAudio = totalAudio! + 1;
    }
    return totalAudio;
  }

  Future<int?> listImg() async {
    firebase_storage.ListResult result =
        await storage.ref('music/images').listAll();
    for (var ref in result.items) {
      totalImg = totalImg! + 1;
    }
    return totalImg;
  }
}

int? totalImg = 0;
int? totalAudio = 0;
int? totalStorage = 0;
int? totalUser = 0;
CloudStorageInfo cloudStorageInfo = CloudStorageInfo();
Future<int?> totalAudio1 = cloudStorageInfo.listImg();
Future<int?> totalAudio2 = cloudStorageInfo.listAudio();
List demoMyFiles = [
  CloudStorageInfo(
    title: "Total Songs",
    numOfFiles: totalAudio,
    svgSrc: "assets/icons/google_drive.svg",
    totalStorage: "2.9GB",
    color: const Color(0xFFFFA113),
    percentage: totalAudio,
  ),
  CloudStorageInfo(
    title: "Total Users",
    numOfFiles: totalUser,
    svgSrc: "assets/icons/google_drive.svg",
    totalStorage: "2.9GB",
    color: const Color(0xFFFFA113),
    percentage: totalUser,
  ),
  CloudStorageInfo(
    title: "Total Storage",
    numOfFiles: totalStorage,
    svgSrc: "assets/icons/one_drive.svg",
    totalStorage: "1GB",
    color: const Color(0xFFA4CDFF),
    percentage: totalStorage,
  ),
  CloudStorageInfo(
    title: "total Images",
    numOfFiles: totalImg,
    svgSrc: "assets/icons/drop_box.svg",
    totalStorage: "7.3GB",
    color: const Color(0xFF007EE5),
    percentage: totalImg,
  ),
];
