import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../../../../model/user_model.dart';
import '../../main/components/side_menu.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert' as convert;
import 'package:http_auth/http_auth.dart';
import 'dart:core';
import 'package:music_app/model/user_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Payment extends StatefulWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  Stream<QuerySnapshot<Map<String, dynamic>>> _foundUsers =
      FirebaseFirestore.instance.collection('users').snapshots();
  final Stream<QuerySnapshot<Map<String, dynamic>>> _allUsers =
      FirebaseFirestore.instance.collection('users').snapshots();
  void _runFilter(String enteredKeyword) {
    Stream<QuerySnapshot<Map<String, dynamic>>> results =
        FirebaseFirestore.instance.collection('users').snapshots();
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _allUsers;
    } else {
      // we use the toLowerCase() method to make it case-insensitive
      results = FirebaseFirestore.instance
          .collection('users')
          .where('fullName'.toString(), isEqualTo: '$enteredKeyword'.toString())
          .snapshots();
    }

    // Refresh the UI
    setState(() {
      _foundUsers = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      drawer: const SideMenu(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Align(
          alignment: Alignment.center,
          child: Text(
            'Payments',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: TextField(
                onChanged: (value) => _runFilter(value),
                decoration: const InputDecoration(
                    labelText: 'Search', suffixIcon: Icon(Icons.search)),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: Color(0xFF161616),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                ),
              ),
              child: SizedBox(
                width: 450,
                height: 400,
                child: StreamBuilder(
                  stream: _foundUsers,
                  builder:
                      (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                    return Padding(
                      padding: const EdgeInsets.all(20),
                      child: Expanded(
                        child: streamSnapshot.data?.docs.length != 0
                            ? ListView.builder(
                                itemCount: streamSnapshot.data?.docs.length,
                                itemBuilder: (ctx, index) => Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "${index + 1}: ${streamSnapshot.data?.docs[index]['fullName']}",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        PaymentSection(
                                                          uid: streamSnapshot
                                                                  .data
                                                                  ?.docs[index]
                                                              ['uid'],
                                                          clientId: streamSnapshot
                                                                  .data
                                                                  ?.docs[index][
                                                              'paypalClientId'],
                                                          name: streamSnapshot
                                                                  .data
                                                                  ?.docs[index]
                                                              ['fullName'],
                                                          email: streamSnapshot
                                                                  .data
                                                                  ?.docs[index]
                                                              ['email'],
                                                        )));
                                          },
                                          child: Row(
                                            children: const [
                                              Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Text(
                                                  "Manage",
                                                  style: TextStyle(
                                                      color: Colors.blue,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 12,
                                                      decoration: TextDecoration
                                                          .underline),
                                                ),
                                              ),
                                            ],
                                          ),
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
                                  ],
                                ),
                              )
                            : const Text(
                                'No results found',
                                style: TextStyle(fontSize: 24),
                              ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentSection extends StatefulWidget {
  final String uid;
  final String clientId;
  final String name;
  final String email;
  const PaymentSection(
      {Key? key,
      required this.uid,
      required this.clientId,
      required this.email,
      required this.name})
      : super(key: key);

  @override
  _PaymentSectionState createState() => _PaymentSectionState();
}

class _PaymentSectionState extends State<PaymentSection> {
  final TextEditingController janController = TextEditingController();
  final TextEditingController balancePaymentController =
      TextEditingController();
  final TextEditingController royaltiesController = TextEditingController();
  final TextEditingController paymentController = TextEditingController();
  String value = 'United Kingdom';
  String value1 = 'United Kingdom';
  String value2 = 'United Kingdom';
  String value3 = 'United Kingdom';
  String value4 = 'United Kingdom';
  var now = new DateTime.now();
  String year = DateFormat('yyyy').format(DateTime.now()).toString();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              // passing this to our root
              Navigator.of(context).pop();
            },
          ),
          title: const Align(
            alignment: Alignment.center,
            child: Text(
              'Payments',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 300,
              ),
              TextFormField(
                autofocus: false,
                controller: paymentController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return ("Please Enter March Streams");
                  }
                  // reg expression for email validation
                  return null;
                },
                onSaved: (value) {
                  paymentController.text = value!;
                },
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFF161616),
                  contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  hintText: "Enter Amount",
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontStyle: FontStyle.normal,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue,
                child: MaterialButton(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  minWidth: MediaQuery.of(context).size.width,
                  onPressed: () {
                    if (paymentController.text != "") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaypalPaymentRecord(
                            onFinish: (number) async {
                              // payment done
                              print('order id: ' + number);
                            },
                            clientId: widget.clientId,
                            amount: paymentController.text,
                            email: widget.email,
                            fullName: widget.name,
                          ),
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaypalPaymentRecord(
                            onFinish: (number) async {
                              // payment done
                              print('order id: ' + number);
                            },
                            clientId: widget.clientId,
                            amount: paymentController.text,
                            email: widget.email,
                            fullName: widget.name,
                          ),
                        ),
                      );
                    }
                  },
                  child: const Text(
                    "Pay",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  postDetailsToFirestore() async {
    UserModel userModel = UserModel();

    // writing all the values
    userModel.royalties = royaltiesController.text;
    userModel.balancePayment = balancePaymentController.text;
    await FirebaseFirestore.instance
        .collection("users")
        .doc(widget.uid)
        .update(userModel.toMapStatements());
  }
}

class PaypalPaymentRecord extends StatefulWidget {
  final String clientId;
  final String amount;
  final String email;
  final String fullName;
  final Function onFinish;

  PaypalPaymentRecord(
      {Key? key,
      required this.onFinish,
      required this.clientId,
      required this.amount,
      required this.email,
      required this.fullName});

  @override
  State<StatefulWidget> createState() {
    return PaypalPaymentRecordState();
  }
}

class PaypalPaymentRecordState extends State<PaypalPaymentRecord> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var checkoutUrl;
  var executeUrl;
  var accessToken;
  PaypalServices services = PaypalServices();
  // you can change default currency according to your need
  Map<dynamic, dynamic> defaultCurrency = {
    "symbol": "GBP ",
    "decimalDigits": 2,
    "symbolBeforeTheNumber": true,
    "currency": "GBP"
  };

  bool isEnableShipping = false;
  bool isEnableAddress = false;

  String returnURL = 'return.example.com';
  String cancelURL = 'cancel.example.com';

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      try {
        accessToken = await services.getAccessToken(widget.clientId);

        final transactions = getOrderParams();
        final res =
            await services.createPaypalPayment(transactions, accessToken);
        if (res != null) {
          setState(() {
            checkoutUrl = res["approvalUrl"];
            executeUrl = res["executeUrl"];
          });
        }
      } catch (e) {
        print('exception: ' + e.toString());
        final snackBar = SnackBar(
          content: Text(e.toString()),
          duration: Duration(seconds: 10),
          action: SnackBarAction(
            label: 'Close',
            onPressed: () {
              // Some code to undo the change.
              Navigator.pop(context);
            },
          ),
        );
        // ignore: deprecated_member_use
        _scaffoldKey.currentState!.showSnackBar(snackBar);
      }
    });
  }

  // item name, price and quantity
  String itemName = 'Royalty Balance';
  int quantity = 1;

  Map<String, dynamic> getOrderParams() {
    List items = [
      {
        "name": itemName,
        "quantity": quantity,
        "price": widget.amount,
        "currency": defaultCurrency["currency"]
      }
    ];

    // checkout invoice details
    String totalAmount = widget.amount;
    String subTotalAmount = widget.amount;
    String shippingCost = '0';
    int shippingDiscountCost = 0;
    String? userFullName = widget.fullName;
    String? userEmail = widget.email;

    Map<String, dynamic> temp = {
      "intent": "sale",
      "payer": {"payment_method": "paypal"},
      "transactions": [
        {
          "amount": {
            "total": totalAmount,
            "currency": defaultCurrency["currency"],
            "details": {
              "subtotal": subTotalAmount,
              "shipping": shippingCost,
              "shipping_discount": 0
            }
          },
          "description": "The payment transaction description.",
          "payment_options": {
            "allowed_payment_method": "INSTANT_FUNDING_SOURCE"
          },
          "item_list": {
            "items": items,
            if (isEnableShipping && isEnableAddress)
              "shipping_address": {
                "recipient_name": userFullName,
                "Email": userEmail,
              },
          }
        }
      ],
      "note_to_payer": "Contact us for any questions on your order.",
      "redirect_urls": {"return_url": returnURL, "cancel_url": cancelURL}
    };
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    print(checkoutUrl);

    if (checkoutUrl != null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).backgroundColor,
          leading: GestureDetector(
            child: const Icon(Icons.arrow_back_ios),
            onTap: () => Navigator.pop(context),
          ),
        ),
        body: WebView(
          initialUrl: checkoutUrl,
          javascriptMode: JavascriptMode.unrestricted,
          navigationDelegate: (NavigationRequest request) {
            if (request.url.contains(returnURL)) {
              final uri = Uri.parse(request.url);
              final payerID = uri.queryParameters['PayerID'];
              if (payerID != null) {
                services
                    .executePayment(executeUrl, payerID, accessToken)
                    .then((id) {
                  widget.onFinish(id);
                  Navigator.of(context).pop();
                });
              } else {
                Navigator.of(context).pop();
              }
              Navigator.of(context).pop();
            }
            if (request.url.contains(cancelURL)) {
              Navigator.of(context).pop();
            }
            return NavigationDecision.navigate;
          },
        ),
      );
    } else {
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          backgroundColor: Colors.black12,
          elevation: 0.0,
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
  }
}

class PaypalServices {
  String domain = "https://api.sandbox.paypal.com"; // for sandbox mode
//  String domain = "https://api.paypal.com"; // for production mode

  // change clientId and secret with your own, provided by paypal

  String secret = '';
  // for getting the access token from Paypal
  Future<String> getAccessToken(String clientId) async {
    try {
      var client = BasicAuthClient(clientId, secret);
      var response = await client.post(
          Uri.parse('$domain/v1/oauth2/token?grant_type=client_credentials'));
      if (response.statusCode == 200) {
        final body = convert.jsonDecode(response.body);
        return body["access_token"];
      }
      return "0";
    } catch (e) {
      rethrow;
    }
  }

  // for creating the payment request with Paypal
  Future<Map<String, String>> createPaypalPayment(
      transactions, accessToken) async {
    try {
      var response = await http.post(Uri.parse("$domain/v1/payments/payment"),
          body: convert.jsonEncode(transactions),
          headers: {
            "content-type": "application/json",
            'Authorization': 'Bearer ' + accessToken
          });

      final body = convert.jsonDecode(response.body);
      if (response.statusCode == 201) {
        if (body["links"] != null && body["links"].length > 0) {
          List links = body["links"];

          String executeUrl = "";
          String approvalUrl = "";
          final item = links.firstWhere((o) => o["rel"] == "approval_url",
              orElse: () => null);
          if (item != null) {
            approvalUrl = item["href"];
          }
          final item1 = links.firstWhere((o) => o["rel"] == "execute",
              orElse: () => null);
          if (item1 != null) {
            executeUrl = item1["href"];
          }
          return {"executeUrl": executeUrl, "approvalUrl": approvalUrl};
        }
        throw Exception("0");
      } else {
        throw Exception(body["message"]);
      }
    } catch (e) {
      rethrow;
    }
  }

  // for executing the payment transaction
  Future<String> executePayment(url, payerId, accessToken) async {
    try {
      var response = await http.post(url,
          body: convert.jsonEncode({"payer_id": payerId}),
          headers: {
            "content-type": "application/json",
            'Authorization': 'Bearer ' + accessToken
          });

      final body = convert.jsonDecode(response.body);
      if (response.statusCode == 200) {
        return body["id"];
      }
      return "0";
    } catch (e) {
      rethrow;
    }
  }
}
