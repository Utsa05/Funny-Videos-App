// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:funny_zone_app/presentation/cubits/notification/notification_cubit.dart';
import 'package:funny_zone_app/presentation/widgets/nointernet.dart';

import '../../constants/color.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var date = DateTime.now();

    var month = DateFormat('d MMM yyyy').format(date);

    bool isCurrentData(String d) {
      return month.toLowerCase() == d.toLowerCase() ? true : false;
    } // prints Tuesday, 10 Dec, 2019

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notification",
          style: Theme.of(context).textTheme.headline6!.copyWith(
              color: AppColor.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColor.white),
        elevation: 0.0,
        leading: IconButton(
            splashRadius: 25.0,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
        backgroundColor: AppColor.black.withOpacity(0.5),
      ),
      body: BlocBuilder<NotificationCubit, NotificationState>(
        builder: (context, state) {
          if (state is NotificationLoaded) {
            return state.notificationList.isNotEmpty
                ? ListView.builder(
                    itemCount: state.notificationList.length,
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 8.0),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 12.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          tileColor: AppColor.white,
                          onTap: () {},
                          subtitle: Column(
                            children: [
                              Text(
                                state.notificationList[index].description!,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                        fontSize: 15.0,
                                        color: AppColor.black,
                                        fontWeight: FontWeight.normal),
                              ),
                              // const Divider()
                            ],
                          ),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                state.notificationList[index].title!,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                        fontSize: 19.0,
                                        color: AppColor.black,
                                        fontWeight: FontWeight.w500),
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.history_outlined,
                                    color: AppColor.gold,
                                    size: 20,
                                  ),
                                  const SizedBox(
                                    width: 7.0,
                                  ),
                                  Text(
                                    state.notificationList[index].time!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                            fontSize: 12.0,
                                            color: AppColor.gold,
                                            fontWeight: FontWeight.w500),
                                  ),
                                ],
                              )
                            ],
                          ),
                          leading: Container(
                            decoration: BoxDecoration(
                                color: isCurrentData(
                                        state.notificationList[index].date!)
                                    ? AppColor.gold.withOpacity(0.8)
                                    : AppColor.gold.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(7.0)),
                            height: 80.0,
                            width: 50.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.notifications_outlined,
                                  size: 25.0,
                                  color: AppColor.white,
                                ),
                                Text(
                                  state.notificationList[index].date!,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                          fontSize: 10.0,
                                          color: AppColor.white,
                                          fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    })
                : const Center(
                    child: Text("No Notification"),
                  );
          } else if (state is NotificationNoInternet) {
            return const NoInteret();
          } else if (state is NotificationFailure) {
            return const Center(
              child: Text("Something Wrong"),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
