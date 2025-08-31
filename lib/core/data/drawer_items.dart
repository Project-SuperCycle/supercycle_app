import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:supercycle_app/core/models/drawer_item_model.dart';
import 'package:supercycle_app/core/routes/end_points.dart';
import 'package:supercycle_app/core/utils/app_assets.dart';
import 'package:supercycle_app/generated/l10n.dart';

List<DrawerItemModel> getDrawerItems(BuildContext context) {
  return [
    DrawerItemModel(
      title: S.of(context).drawer_home,
      leading: Image.asset(
        AppAssets.homeIcon,
        fit: BoxFit.cover,
        width: 30,
        height: 30,
      ),
      onTap: () => GoRouter.of(context).push(EndPoints.homeView),
    ),
    DrawerItemModel(
      title: S.of(context).drawer_profile,
      leading: SvgPicture.asset(
        AppAssets.userCardIcon,
        fit: BoxFit.cover,
        width: 30,
        height: 30,
      ),
      onTap: () => GoRouter.of(context).push(EndPoints.homeView),
    ),
    DrawerItemModel(
      title: S.of(context).drawer_sales_calender,
      leading: SvgPicture.asset(
        AppAssets.calendarIcon,
        fit: BoxFit.cover,
        width: 30,
        height: 30,
      ),
      onTap: () => GoRouter.of(context).push(EndPoints.homeView),
    ),
    DrawerItemModel(
      title: S.of(context).drawer_transactions_table,
      leading: SvgPicture.asset(
        AppAssets.calendarIcon,
        fit: BoxFit.cover,
        width: 30,
        height: 30,
      ),
      onTap: () => GoRouter.of(context).push(EndPoints.homeView),
    ),
  ];
}
