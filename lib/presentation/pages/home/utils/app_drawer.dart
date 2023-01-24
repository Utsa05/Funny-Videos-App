// ignore_for_file: public_member_api_docs, sort_constructors_first, deprecated_member_use, depend_on_referenced_packages, no_leading_underscores_for_local_identifiers
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:funny_zone_app/domain/entities/appinfo.dart';
import 'package:funny_zone_app/presentation/constants/color.dart';
import 'package:funny_zone_app/presentation/constants/string.dart';
import 'package:funny_zone_app/presentation/pages/home/utils/drawer_item.dart';
import 'package:share_plus/share_plus.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    Key? key,
    required this.info,
  }) : super(key: key);
  final AppInfoEntity info;

  @override
  Widget build(BuildContext context) {
    _sendingMails(String uri) async {
      if (await canLaunch(uri)) {
        await launch(uri);
      } else {
        throw 'Could not launch $uri';
      }
    }

    return Drawer(
      width: MediaQuery.of(context).size.width,
      // shape: const RoundedRectangleBorder(
      //     borderRadius: BorderRadius.only(
      //         topRight: Radius.circular(25.0),
      //         bottomRight: Radius.circular(25.0))),
      backgroundColor: AppColor.black.withOpacity(0.8),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20.0),
            height: 120.0,
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(25.0),
              ),
              color: AppColor.black,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/logo/Small logo home-01.png',
                  width: 190.0,
                ),
                const SizedBox(
                  height: 5.0,
                ),
                const Text("Enjoy all the latest videos"),
              ],
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          DrawerItem(
            icon: Icons.notifications_outlined,
            tap: () {
              Navigator.pushNamed(context, AppString.notificationRoute);
            },
            title: "Notification",
          ),
          DrawerItem(
            icon: Icons.share_outlined,
            tap: () {
              Share.share(
                  'This is Funny Video App\nDownload link:${info.shareapp}',
                  subject: "Share Now");
            },
            title: "Share App",
          ),
          DrawerItem(
            icon: Icons.update_outlined,
            tap: () {
              _sendingMails(info.shareapp!);
            },
            title: "Update App",
          ),
          DrawerItem(
            icon: Icons.more_horiz_outlined,
            tap: () {
              _sendingMails(info.othersapp!);
            },
            title: "More App",
          ),
          DrawerItem(
            icon: Icons.policy_outlined,
            tap: () {
              _sendingMails(info.policy!);
            },
            title: "Privacy & Policy",
          ),
          DrawerItem(
            icon: Icons.email_outlined,
            tap: () {
              _sendingMails(
                  'mailto:nullit00@gmail.com?subject=Suggestion&body= ');
            },
            title: "Contact Us",
          ),
        ],
      ),
    );
  }
}
