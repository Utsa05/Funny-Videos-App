import 'package:flutter/material.dart';
import 'package:funny_zone_app/presentation/constants/color.dart';
import 'package:funny_zone_app/presentation/pages/home/utils/drawer_item.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
            icon: Icons.search_outlined,
            tap: () {},
            title: "Search",
          ),
          DrawerItem(
            icon: Icons.favorite_outline,
            tap: () {},
            title: "Favorite",
          ),
          DrawerItem(
            icon: Icons.notifications_outlined,
            tap: () {},
            title: "Notification",
          ),
          DrawerItem(
            icon: Icons.update_outlined,
            tap: () {},
            title: "Update App",
          ),
          DrawerItem(
            icon: Icons.share_outlined,
            tap: () {},
            title: "Share App",
          ),
          DrawerItem(
            icon: Icons.more_horiz_outlined,
            tap: () {},
            title: "More App",
          ),
          DrawerItem(
            icon: Icons.policy_outlined,
            tap: () {},
            title: "Privacy & Policy",
          ),
        ],
      ),
    );
  }
}
