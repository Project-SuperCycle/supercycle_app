import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supercycle_app/core/models/drawer_item_model.dart';
import 'package:supercycle_app/core/models/user_info_model.dart';
import 'package:supercycle_app/core/routes/end_points.dart';
import 'package:supercycle_app/core/services/storage_services.dart';
import 'package:supercycle_app/core/utils/app_assets.dart';
import 'package:supercycle_app/core/widgets/drawer/drawer_items_list.dart';
import 'package:supercycle_app/core/widgets/drawer/in_active_drawer_item.dart';
import 'package:supercycle_app/core/widgets/drawer/user_info_list_tile.dart';
import 'package:supercycle_app/features/sign_in/data/models/logined_user_model.dart';
import 'package:supercycle_app/generated/l10n.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  int activeIndex = 0;
  bool isUserLoggedIn = false;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  void getUserData() async {
    LoginedUserModel? user = await StorageServices.getUserData();
    setState(() {
      isUserLoggedIn = (user != null);
    });
  }

  void logout() async {
    await StorageServices.clearAll();
    GoRouter.of(context).push(EndPoints.signInView);
    GoogleSignIn().signOut();
    FacebookAuth.instance.logOut();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * .7,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 255, 255, 1),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          bottomLeft: Radius.circular(30),
        ),
      ),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(height: MediaQuery.of(context).padding.top),
          ),
          SliverToBoxAdapter(child: UserInfoListTile()),
          SliverToBoxAdapter(child: SizedBox(height: 10)),
          DrawerItemsList(),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                Spacer(),
                InActiveDrawerItem(
                  drawerItemModel: DrawerItemModel(
                    title: S.of(context).drawer_settings,
                    leading: Image.asset(
                      AppAssets.settingsIcon,
                      fit: BoxFit.cover,
                      width: 30,
                      height: 30,
                    ),
                    onTap: () => GoRouter.of(context).push(EndPoints.homeView),
                  ),
                ),
                isUserLoggedIn
                    ? InActiveDrawerItem(
                        drawerItemModel: DrawerItemModel(
                          title: S.of(context).drawer_logout,
                          leading: Image.asset(
                            AppAssets.logoutIcon,
                            fit: BoxFit.cover,
                            width: 30,
                            height: 30,
                          ),
                          onTap: logout,
                        ),
                      )
                    : InActiveDrawerItem(
                        drawerItemModel: DrawerItemModel(
                          title: S.of(context).drawer_sign_in,
                          leading: Image.asset(
                            AppAssets.loginIcon,
                            fit: BoxFit.cover,
                            width: 30,
                            height: 30,
                          ),
                          onTap: () =>
                              GoRouter.of(context).push(EndPoints.signInView),
                        ),
                      ),
                SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
