// ignore: depend_on_referenced_packages
import 'package:equatable/equatable.dart';

class AppInfoEntity extends Equatable {
  final String? addstatus;
  final String? bannerad;
  final String? interstitialad;
  final String? videoad;
  final String? shareapp;
  final String? policy;
  final String? othersapp;

  const AppInfoEntity({
    this.addstatus,
    this.bannerad,
    this.interstitialad,
    this.videoad,
    this.shareapp,
    this.policy,
    this.othersapp,
  });

  @override
  List<Object?> get props => [addstatus, shareapp, policy];
}
