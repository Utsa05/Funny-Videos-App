import 'package:flutter/material.dart';
import 'package:funny_zone_app/presentation/constants/color.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem({
    Key? key,
    required this.tap,
    required this.icon,
    required this.title,
  }) : super(key: key);
  final GestureTapCallback tap;
  final IconData icon;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 12.0),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
        tileColor: AppColor.grey.withOpacity(0.1),
        onTap: tap,
        title: Text(
          title,
          style:
              Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 17.0),
        ),
        leading: CircleAvatar(
          backgroundColor: AppColor.black,
          child: Icon(
            icon,
            color: AppColor.white,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios_outlined,
          color: AppColor.white,
        ),
      ),
    );
  }
}
