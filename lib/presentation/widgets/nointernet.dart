import 'package:flutter/material.dart';
import 'package:funny_zone_app/presentation/constants/color.dart';

class NoInteret extends StatelessWidget {
  const NoInteret({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.14),
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.wifi_off_outlined,
              size: 140.0,
              color: AppColor.gold,
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              "No Internet",
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(fontSize: 24.0),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Text(
              "Please Connect Internet",
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(color: AppColor.black, fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }
}
