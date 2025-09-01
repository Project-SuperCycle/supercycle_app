import 'package:flutter/material.dart';
import 'package:supercycle_app/core/data/drawer_items.dart';
import 'package:supercycle_app/core/models/drawer_item_model.dart';
import 'package:supercycle_app/core/widgets/drawer/drawer_item.dart';

class DrawerItemsList extends StatefulWidget {
  const DrawerItemsList({super.key});

  @override
  State<DrawerItemsList> createState() => _DrawerItemsListState();
}

class _DrawerItemsListState extends State<DrawerItemsList> {
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    List<DrawerItemModel> drawerItems = getDrawerItems(context);
    return SliverList.builder(
      itemCount: drawerItems.length,
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {
          if (activeIndex != index) {
            setState(() {
              activeIndex = index;
            });
          }
        },
        child: DrawerItem(
          drawerItemModel: drawerItems[index],
          isActive: activeIndex == index,
        ),
      ),
    );
  }
}
