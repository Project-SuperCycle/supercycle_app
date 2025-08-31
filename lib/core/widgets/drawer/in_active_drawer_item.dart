import 'package:flutter/material.dart';
import 'package:supercycle_app/core/models/drawer_item_model.dart';
import 'package:supercycle_app/core/utils/app_styles.dart';

class InActiveDrawerItem extends StatelessWidget {
  const InActiveDrawerItem({super.key, required this.drawerItemModel});

  final DrawerItemModel drawerItemModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: GestureDetector(
        onTap: drawerItemModel.onTap,
        child: ListTile(
          leading: drawerItemModel.leading,
          title: FittedBox(
            alignment: AlignmentDirectional.centerStart,
            fit: BoxFit.scaleDown,
            child: Text(
              drawerItemModel.title,
              style: AppStyles.styleMedium16(context),
            ),
          ),
        ),
      ),
    );
  }
}
