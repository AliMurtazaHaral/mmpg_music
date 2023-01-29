import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:music_app/admin_dashboard/screens/dashboard/components/download.dart';
import 'package:music_app/admin_dashboard/screens/dashboard/components/funding.dart';
import 'package:music_app/admin_dashboard/screens/dashboard/components/payment.dart';
import 'package:music_app/admin_dashboard/screens/dashboard/components/promotion.dart';
import 'package:music_app/admin_dashboard/screens/dashboard/components/releases.dart';
import 'package:music_app/admin_dashboard/screens/dashboard/components/satistics.dart';
import 'package:music_app/admin_dashboard/screens/dashboard/components/search.dart';
import 'package:music_app/admin_dashboard/screens/dashboard/components/splits.dart';
import 'package:music_app/admin_dashboard/screens/dashboard/components/statment.dart';
import 'package:music_app/admin_dashboard/screens/dashboard/components/submissions.dart';
import 'package:music_app/admin_dashboard/screens/dashboard/components/notifications.dart';
import 'package:music_app/admin_dashboard/screens/dashboard/components/users.dart';
import 'package:music_app/admin_dashboard/screens/main/main_screen.dart';
import 'package:provider/provider.dart';

import '../../../controllers/MenuController.dart';
import '../../dashboard/components/message.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset("assets/logo.PNG"),
          ),
          DrawerListTile(
            title: "DASHBOARD",
            svgSrc: "assets/icons/menu_dashbord.svg",
            press: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MultiProvider(
                      providers: [
                        ChangeNotifierProvider(
                          create: (context) => MenuController(),
                        ),
                      ],
                      child: MainScreen(),
                    ),
                  ));
            },
          ),
          DrawerListTile(
            title: "MESSAGES",
            svgSrc: "assets/icons/menu_tran.svg",
            press: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MessageSection()));
            },
          ),
          DrawerListTile(
            title: "NOTIFICATIONS",
            svgSrc: "assets/icons/menu_tran.svg",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationManagement(),
                ),
              );
            },
          ),
          DrawerListTile(
            title: "SUBMISSIONS",
            svgSrc: "assets/icons/menu_tran.svg",
            press: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Submissions()));
            },
          ),
          DrawerListTile(
            title: "RELEASES",
            svgSrc: "assets/icons/menu_tran.svg",
            press: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Releases()));
            },
          ),
          DrawerListTile(
            title: "USERS",
            svgSrc: "assets/icons/menu_tran.svg",
            press: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Users()));
            },
          ),
          DrawerListTile(
            title: "STATISTICS",
            svgSrc: "assets/icons/menu_tran.svg",
            press: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Statistics()));
            },
          ),
          DrawerListTile(
            title: "FUNDING",
            svgSrc: "assets/icons/menu_tran.svg",
            press: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Funding()));
            },
          ),
          DrawerListTile(
            title: "SPLITS",
            svgSrc: "assets/icons/menu_tran.svg",
            press: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Splits()));
            },
          ),
          DrawerListTile(
            title: "PAYMENTS",
            svgSrc: "assets/icons/menu_tran.svg",
            press: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Payment()));
            },
          ),
          DrawerListTile(
            title: "STATEMENT",
            svgSrc: "assets/icons/menu_tran.svg",
            press: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Statement()));
            },
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        color: Colors.white54,
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white54),
      ),
    );
  }
}
