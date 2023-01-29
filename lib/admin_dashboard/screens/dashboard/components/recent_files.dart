import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:music_app/admin_dashboard/models/RecentFile.dart';
import 'package:music_app/screens/storage_class.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../../constants.dart';

class RecentFiles extends StatelessWidget {
  const RecentFiles({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: const BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Uploads",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(
            width: double.infinity,
            child: DataTable2(
              columnSpacing: defaultPadding,
              minWidth: 600,
              columns: const [
                DataColumn(
                  label: Text("File Name"),
                ),
              ],
              rows: [],
            ),
          ),
          FutureBuilder(
              future: storage.listFiles(),
              builder: (BuildContext context,
                  AsyncSnapshot<firebase_storage.ListResult> snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  return Container(
                    padding: const EdgeInsets.all(20),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.items.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                snapshot.data!.items[index].name,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Divider(
                              height: 1,
                              color: Colors.grey,
                            ),
                            const SizedBox(height: 10),
                          ],
                        );
                      },
                    ),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting ||
                    !snapshot.hasData) {
                  return const CircularProgressIndicator();
                }
                return Container();
              }),
        ],
      ),
    );
  }
}

DataRow recentFileDataRow(RecentFile fileInfo) {
  return DataRow(
    cells: [
      DataCell(
        Row(
          children: [
            SvgPicture.asset(
              fileInfo.icon!,
              height: 30,
              width: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(fileInfo.title!),
            ),
          ],
        ),
      ),
      DataCell(Text(fileInfo.date!)),
      DataCell(Text(fileInfo.size!)),
    ],
  );
}
