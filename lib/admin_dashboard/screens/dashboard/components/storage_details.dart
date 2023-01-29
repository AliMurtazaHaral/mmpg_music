import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../../constants.dart';
import 'chart.dart';
import 'storage_info_card.dart';

class StorageDetails extends StatefulWidget {
  const StorageDetails({Key? key}) : super(key: key);

  @override
  _StorageDetailsState createState() => _StorageDetailsState();
}

class _StorageDetailsState extends State<StorageDetails> {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  int? totalImg = 0;
  int? totalAudio = 0;
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

  @override
  void initState() {
    super.initState();
    listImg();
    listAudio();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Storage Details",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: defaultPadding),
          Chart(),
          StorageInfoCard(
            svgSrc: "assets/icons/Documents.svg",
            title: "Audio Files",
            amountOfFiles: "1.3GB",
            numOfFiles: totalAudio,
          ),
          StorageInfoCard(
            svgSrc: "assets/icons/media.svg",
            title: "Image Files",
            amountOfFiles: "15.3GB",
            numOfFiles: totalImg,
          ),
        ],
      ),
    );
  }
}
