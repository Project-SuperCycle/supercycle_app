import 'package:flutter/material.dart';
import 'package:supercycle_app/core/services/storage_services.dart';
import 'package:supercycle_app/core/utils/app_assets.dart';
import 'package:supercycle_app/core/utils/app_styles.dart';
import 'package:supercycle_app/features/sign_in/data/models/logined_user_model.dart';

class UserInfoListTile extends StatefulWidget {
  const UserInfoListTile({super.key});

  @override
  State<UserInfoListTile> createState() => _UserInfoListTileState();
}

class _UserInfoListTileState extends State<UserInfoListTile> {
  late final String managerName;
  late final String businessType;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  void getUserData() async {
    LoginedUserModel? user = await StorageServices.getUserData();
    setState(() {
      managerName = (user != null) ? user.doshMangerName : '';
      businessType = (user != null) ? user.rawBusinessType : '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFFAFAFA),
      elevation: 0,
      child: Center(
        child: ListTile(
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Image.asset(AppAssets.defaultAvatar, fit: BoxFit.contain),
          ),
          title: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: AlignmentDirectional.centerStart,
            child: Text(managerName, style: AppStyles.styleSemiBold16(context)),
          ),
          subtitle: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: AlignmentDirectional.centerStart,
            child: Text(businessType, style: AppStyles.styleRegular12(context)),
          ),
        ),
      ),
    );
  }
}
