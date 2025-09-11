import 'package:flutter/material.dart';
import 'package:supercycle_app/core/models/drawer_item_model.dart';
import 'package:supercycle_app/core/widgets/drawer/active_drawer_item.dart';
import 'package:supercycle_app/core/widgets/drawer/in_active_drawer_item.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem({
    super.key,
    required this.drawerItemModel,
    required this.isActive,
  });
  final DrawerItemModel drawerItemModel;
  final bool isActive;
  @override
  Widget build(BuildContext context) {
    return isActive
        ? ActiveDrawerItem(drawerItemModel: drawerItemModel)
        : InActiveDrawerItem(drawerItemModel: drawerItemModel);
  }
}
