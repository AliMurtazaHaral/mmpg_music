import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_app/screens/paypal_connection_page.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class EarningPage extends StatefulWidget {
  const EarningPage({Key? key}) : super(key: key);

  @override
  _EarningPageState createState() => _EarningPageState();
}

class _EarningPageState extends State<EarningPage> {
  String url = "";
  int totalMoney = 0;
  int toUSD = 0;
  final _formKey = GlobalKey<FormState>();
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  List<charts.Series<Sales, int>> _seriesLineData =
      <charts.Series<Sales, int>>[];
  List<charts.Series<Sales, int>> _seriesLineData1 =
      <charts.Series<Sales, int>>[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  getImg() async {
    final ref = firebase_storage.FirebaseStorage.instance
        .ref('music/images/')
        .child('bgimg.jpg');
    url = await ref.getDownloadURL();
    print("This is url ${url}");
  }

  late Map<String, double> dataMap = {
    loggedInUser.country1Name.toString():
        double.parse(loggedInUser.country1.toString()),
    loggedInUser.country2Name.toString():
        double.parse(loggedInUser.country2.toString()),
    loggedInUser.country3Name.toString():
        double.parse(loggedInUser.country3.toString()),
    loggedInUser.country4Name.toString():
        double.parse(loggedInUser.country4.toString()),
    loggedInUser.country5Name.toString():
        double.parse(loggedInUser.country5.toString()),
  };

  @override
  Widget build(BuildContext context) {
    var linesalesdata = [
      Sales(1, int.parse(loggedInUser.jan.toString())),
      Sales(2, int.parse(loggedInUser.feb.toString())),
      Sales(3, int.parse(loggedInUser.mar.toString())),
      Sales(4, int.parse(loggedInUser.april.toString())),
      Sales(5, int.parse(loggedInUser.may.toString())),
      Sales(6, int.parse(loggedInUser.june.toString())),
      Sales(7, int.parse(loggedInUser.jul.toString())),
      Sales(8, int.parse(loggedInUser.aug.toString())),
      Sales(9, int.parse(loggedInUser.sep.toString())),
      Sales(10, int.parse(loggedInUser.oct.toString())),
      Sales(11, int.parse(loggedInUser.nov.toString())),
      Sales(12, int.parse(loggedInUser.dec.toString())),
    ];
    var linesalesdata1 = [
      Sales(1, int.parse(loggedInUser.jan1.toString())),
      Sales(2, int.parse(loggedInUser.feb1.toString())),
      Sales(3, int.parse(loggedInUser.mar1.toString())),
      Sales(4, int.parse(loggedInUser.april1.toString())),
      Sales(5, int.parse(loggedInUser.may1.toString())),
      Sales(6, int.parse(loggedInUser.june1.toString())),
      Sales(7, int.parse(loggedInUser.jul1.toString())),
      Sales(8, int.parse(loggedInUser.aug1.toString())),
      Sales(9, int.parse(loggedInUser.sep1.toString())),
      Sales(10, int.parse(loggedInUser.oct1.toString())),
      Sales(11, int.parse(loggedInUser.nov1.toString())),
      Sales(12, int.parse(loggedInUser.dec1.toString())),
    ];
    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) =>
            charts.ColorUtil.fromDartColor(const Color(0xff990099)),
        id: 'Air Pollution',
        data: linesalesdata,
        domainFn: (Sales sales, _) => sales.yearval,
        measureFn: (Sales sales, _) => sales.salesval,
      ),
    );
    _seriesLineData1.add(
      charts.Series(
        colorFn: (__, _) =>
            charts.ColorUtil.fromDartColor(const Color(0xff990099)),
        id: 'Air Pollution',
        data: linesalesdata1,
        domainFn: (Sales sales, _) => sales.yearval,
        measureFn: (Sales sales, _) => sales.salesval,
      ),
    );
    List<double> list1 = [
      double.parse(loggedInUser.country1.toString()),
      double.parse(loggedInUser.country2.toString()),
      double.parse(loggedInUser.country3.toString()),
      double.parse(loggedInUser.country4.toString()),
      double.parse(loggedInUser.country5.toString())
    ];
    String c1 = "", c2 = "", c3 = "", c4 = "", c5 = "";
    list1.sort();
    if (double.parse(loggedInUser.country1.toString()) == list1[4]) {
      c1 = loggedInUser.country1Name.toString();
    }
    if (double.parse(loggedInUser.country1.toString()) == list1[3]) {
      c2 = loggedInUser.country1Name.toString();
    }
    if (double.parse(loggedInUser.country1.toString()) == list1[2]) {
      c3 = loggedInUser.country1Name.toString();
    }
    if (double.parse(loggedInUser.country1.toString()) == list1[1]) {
      c4 = loggedInUser.country1Name.toString();
    }
    if (double.parse(loggedInUser.country1.toString()) == list1[0]) {
      c5 = loggedInUser.country1Name.toString();
    }
    if (double.parse(loggedInUser.country2.toString()) == list1[4]) {
      c1 = loggedInUser.country2Name.toString();
    }
    if (double.parse(loggedInUser.country2.toString()) == list1[3]) {
      c2 = loggedInUser.country2Name.toString();
    }
    if (double.parse(loggedInUser.country2.toString()) == list1[2]) {
      c3 = loggedInUser.country2Name.toString();
    }
    if (double.parse(loggedInUser.country2.toString()) == list1[1]) {
      c4 = loggedInUser.country1Name.toString();
    }
    if (double.parse(loggedInUser.country2.toString()) == list1[0]) {
      c5 = loggedInUser.country2Name.toString();
    }
    if (double.parse(loggedInUser.country3.toString()) == list1[4]) {
      c1 = loggedInUser.country3Name.toString();
    }
    if (double.parse(loggedInUser.country3.toString()) == list1[3]) {
      c2 = loggedInUser.country3Name.toString();
    }
    if (double.parse(loggedInUser.country3.toString()) == list1[2]) {
      c3 = loggedInUser.country3Name.toString();
    }
    if (double.parse(loggedInUser.country3.toString()) == list1[1]) {
      c4 = loggedInUser.country3Name.toString();
    }
    if (double.parse(loggedInUser.country3.toString()) == list1[0]) {
      c5 = loggedInUser.country3Name.toString();
    }
    if (double.parse(loggedInUser.country4.toString()) == list1[4]) {
      c1 = loggedInUser.country4Name.toString();
    }
    if (double.parse(loggedInUser.country4.toString()) == list1[3]) {
      c2 = loggedInUser.country4Name.toString();
    }
    if (double.parse(loggedInUser.country4.toString()) == list1[2]) {
      c3 = loggedInUser.country4Name.toString();
    }
    if (double.parse(loggedInUser.country4.toString()) == list1[1]) {
      c4 = loggedInUser.country4Name.toString();
    }
    if (double.parse(loggedInUser.country4.toString()) == list1[0]) {
      c5 = loggedInUser.country4Name.toString();
    }
    if (double.parse(loggedInUser.country5.toString()) == list1[4]) {
      c1 = loggedInUser.country5Name.toString();
    }
    if (double.parse(loggedInUser.country5.toString()) == list1[3]) {
      c2 = loggedInUser.country5Name.toString();
    }
    if (double.parse(loggedInUser.country5.toString()) == list1[2]) {
      c3 = loggedInUser.country5Name.toString();
    }
    if (double.parse(loggedInUser.country5.toString()) == list1[1]) {
      c4 = loggedInUser.country5Name.toString();
    }
    if (double.parse(loggedInUser.country5.toString()) == list1[0]) {
      c5 = loggedInUser.country5Name.toString();
    }

    final List<ChartData> chartData = [
      ChartData(c1, list1[4], Color(0xFFff5656)),
      ChartData(c2, list1[3], Color(0xFFd91664)),
      ChartData(c3, list1[2], Color(0xFF9f006e)),
      ChartData(c4, list1[1], Color(0xFF62006e)),
      ChartData(c5, list1[0], Color(0xFF000062)),
    ];
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Center(
          child: Column(
            children: [
              Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.93,
                  decoration: const BoxDecoration(
                    color: Color(0xFF161616),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Align(
                        alignment: Alignment.center,
                        child: Text(
                          '    ',
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      const Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Statistics',
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      Image.asset(
                        "assets/square.PNG",
                        width: 40,
                        height: 40,
                      ),
                    ],
                  )),
              const SizedBox(
                height: 30,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.93,
                height: 200,
                decoration: const BoxDecoration(
                  color: Color(0xFF161616),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "  Royalties Balance",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: Color(0xFFf9f5ef)),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              "  £",
                              style: const TextStyle(
                                  color: Color(0xFFf9f5ef),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            " ${loggedInUser.earning}",
                            style: const TextStyle(
                                color: Color(0xFFf9f5ef),
                                fontWeight: FontWeight.normal,
                                fontSize: 35),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 8,
                        ),
                        Image.asset(
                          "assets/t.PNG",
                          height: 30,
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "minimum payout threshold £50",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.normal,
                                fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "   USD ${double.parse(loggedInUser.earning.toString()) * 1.32}",
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const PayoutPage(),
                                ),
                              );
                            },
                            child: Image.asset(
                              "assets/arrowNext.PNG",
                              height: 40,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Image.asset(
                "assets/socialMedia.PNG",
                width: MediaQuery.of(context).size.width * 0.99,
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                  width: MediaQuery.of(context).size.width * 0.93,
                  height: 500,
                  decoration: const BoxDecoration(
                    color: Color(0xFF161616),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0),
                    ),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: charts.LineChart(
                          _seriesLineData,
                          animate: true,
                          //behaviors: [new charts.SeriesLegend()],
                          defaultRenderer:
                              charts.LineRendererConfig(includeArea: true),
                          animationDuration: const Duration(seconds: 5),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Image.asset(
                        "assets/streams.PNG",
                        width: 170,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  )),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Image.asset(
                    "assets/y.PNG",
                    width: 170,
                  ),
                ),
              ),
              Container(
                  width: MediaQuery.of(context).size.width * 0.93,
                  height: 500,
                  decoration: const BoxDecoration(
                    color: Color(0xFF161616),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0),
                    ),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: charts.LineChart(
                          _seriesLineData1,
                          animate: true,
                          //behaviors: [new charts.SeriesLegend()],
                          defaultRenderer:
                              charts.LineRendererConfig(includeArea: true),
                          animationDuration: const Duration(seconds: 5),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Image.asset(
                        "assets/views.PNG",
                        width: 170,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  )),
              const SizedBox(
                height: 30,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "         Top Service",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.93,
                decoration: const BoxDecoration(
                  color: Color(0xFF161616),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              "assets/spotify.png",
                              width: 40,
                              height: 30,
                            ),
                            const Text(
                              "Spotify",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        OutlinedButton(
                          onPressed: () {},
                          child: Text('£ ${loggedInUser.spotify}',
                              style: const TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      height: 1,
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              "assets/youtube.png",
                              width: 40,
                              height: 30,
                            ),
                            const Text(
                              " Youtube",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        OutlinedButton(
                          onPressed: () {},
                          child: Text('£ ${loggedInUser.youtube}',
                              style: const TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      height: 1,
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              "assets/apple.png",
                              width: 40,
                              height: 30,
                            ),
                            const Text(
                              " Music",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        OutlinedButton(
                          onPressed: () {},
                          child: Text('£ ${loggedInUser.appleMusic}',
                              style: const TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      height: 1,
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              "assets/facebook.png",
                              width: 40,
                              height: 30,
                            ),
                            const Text(
                              "Facebook (Vieos)",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        OutlinedButton(
                          onPressed: () {},
                          child: Text('£ ${loggedInUser.facebookVideo}',
                              style: const TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      height: 1,
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              "assets/amazon.png",
                              width: 40,
                              height: 30,
                            ),
                            const Text(
                              "Amazon Music",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        OutlinedButton(
                          onPressed: () {},
                          child: Text(
                            '£ ${loggedInUser.amazon}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "         Top Tracks",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.14,
                width: MediaQuery.of(context).size.width * 0.93,
                decoration: const BoxDecoration(
                  color: Color(0xFF161616),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        "assets/song.gif",
                        fit: BoxFit.contain,
                        height: 180,
                        width: MediaQuery.of(context).size.width * 0.2,
                      ),
                      Column(
                        children: [
                          const Text(
                            "            Song/Artist",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "£ ${loggedInUser.balancePayment}",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: const [
                              SizedBox(
                                width: 90,
                              ),
                              Icon(
                                Icons.headset,
                                size: 15.0,
                                color: Colors.purple,
                              ),
                              Text(
                                "Streams  ",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.grey),
                              ),
                              Icon(
                                Icons.remove_red_eye,
                                size: 15.0,
                                color: Colors.redAccent,
                              ),
                              Text(
                                "Views",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.grey),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            '                         ${loggedInUser.royalties}          ${loggedInUser.views}',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.14,
                width: MediaQuery.of(context).size.width * 0.93,
                decoration: const BoxDecoration(
                  color: Color(0xFF161616),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        "assets/song.gif",
                        height: 180,
                        width: MediaQuery.of(context).size.width * 0.2,
                      ),
                      Column(
                        children: [
                          const Text(
                            "            Song/Artist",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "£ ${loggedInUser.balancePayment}",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: const [
                              SizedBox(
                                width: 90,
                              ),
                              Icon(
                                Icons.headset,
                                size: 15.0,
                                color: Colors.purple,
                              ),
                              Text(
                                "Streams  ",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.grey),
                              ),
                              Icon(
                                Icons.remove_red_eye,
                                size: 15.0,
                                color: Colors.redAccent,
                              ),
                              Text(
                                "Views",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.grey),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            '                         ${loggedInUser.royalties}          ${loggedInUser.views}',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.14,
                width: MediaQuery.of(context).size.width * 0.93,
                decoration: const BoxDecoration(
                  color: Color(0xFF161616),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        "assets/song.gif",
                        height: 180,
                        width: MediaQuery.of(context).size.width * 0.2,
                      ),
                      Column(
                        children: [
                          const Text(
                            "            Song/Artist",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "£ ${loggedInUser.balancePayment}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: const [
                              SizedBox(
                                width: 90,
                              ),
                              Icon(
                                Icons.headset,
                                size: 15.0,
                                color: Colors.purple,
                              ),
                              Text(
                                "Streams  ",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.grey),
                              ),
                              Icon(
                                Icons.remove_red_eye,
                                size: 15.0,
                                color: Colors.redAccent,
                              ),
                              Text(
                                "Views",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.grey),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            '                         ${loggedInUser.royalties}          ${loggedInUser.views}',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "         Top Artists",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.93,
                height: 100,
                decoration: const BoxDecoration(
                  color: Color(0xFF161616),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                  ),
                ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: CircleButton(
                        onTap: () => print("Cool"),
                        iconData: Icons.person,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      children: const [
                        SizedBox(
                          height: 30,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Artist",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "£ 50.00",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.93,
                height: 100,
                decoration: const BoxDecoration(
                  color: Color(0xFF161616),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                  ),
                ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: CircleButton(
                        onTap: () => print("Cool"),
                        iconData: Icons.person,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      children: const [
                        SizedBox(
                          height: 30,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Artist",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "£ 50.00",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.93,
                height: 100,
                decoration: const BoxDecoration(
                  color: Color(0xFF161616),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                  ),
                ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: CircleButton(
                        onTap: () => print("Cool"),
                        iconData: Icons.person,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      children: const [
                        SizedBox(
                          height: 30,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Artist",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "£ 50.00",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "         Top Locations",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.93,
                height: 400,
                decoration: const BoxDecoration(
                  color: Color(0xFF161616),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SfCircularChart(
                          series: <CircularSeries>[
                            // Render pie chart
                            DoughnutSeries<ChartData, String>(
                              dataLabelSettings: const DataLabelSettings(
                                  isVisible: true,
                                  textStyle: TextStyle(color: Colors.grey),
                                  labelPosition:
                                      ChartDataLabelPosition.outside),
                              dataLabelMapper: (ChartData data, _) =>
                                  data.x + '\n' + (data.y).toString() + "%",
                              dataSource: chartData,
                              pointColorMapper: (ChartData data, _) =>
                                  data.color,
                              xValueMapper: (ChartData data, _) => data.x,
                              yValueMapper: (ChartData data, _) => data.y,
                            ),
                            //dataLabelSettings: DataLabelSettings(isVisible: true)),
                          ],
                        ),
                        Image.asset(
                          "assets/pieData.PNG",
                          height: MediaQuery.of(context).size.height * 0.14,
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Female     Male\n"
                          "${loggedInUser.female}%           ${loggedInUser.male}%",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 15),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Pollution {
  String place;
  int year;
  int quantity;

  Pollution(this.year, this.place, this.quantity);
}

class Task {
  String task;
  double taskvalue;
  Color colorval;

  Task(this.task, this.taskvalue, this.colorval);
}

class Sales {
  int yearval;
  int salesval;

  Sales(this.yearval, this.salesval);
}

class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}

class CircleButton extends StatelessWidget {
  final GestureTapCallback onTap;
  final IconData iconData;

  const CircleButton({Key? key, required this.onTap, required this.iconData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double size = 65.0;

    return InkResponse(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Icon(
          iconData,
          color: Colors.blue,
        ),
      ),
    );
  }
}
