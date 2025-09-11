import 'package:flutter/material.dart';
import 'package:supercycle_app/core/services/storage_services.dart';
import 'package:supercycle_app/core/utils/app_styles.dart';
import 'package:supercycle_app/features/sign_in/data/models/logined_user_model.dart';
import 'package:supercycle_app/generated/l10n.dart';

class ClientDataContent extends StatefulWidget {
  const ClientDataContent({super.key});

  @override
  State<ClientDataContent> createState() => _ClientDataContentState();
}

class _ClientDataContentState extends State<ClientDataContent> {
  LoginedUserModel? entity;
  @override
  void initState() {
    super.initState();
    getUserData();
  }

  void getUserData() async {
    LoginedUserModel? user = await StorageServices.getUserData();
    setState(() {
      entity = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DataRow(
          label: '${S.of(context).entity_name}:  ',
          value: entity?.bussinessName,
        ),
        const SizedBox(height: 20),
        DataRow(
          label: '${S.of(context).entity_type}:  ',
          value: entity?.rawBusinessType,
        ),
        const SizedBox(height: 20),
        DataRow(
          label: '${S.of(context).entity_address}:  ',
          value: entity?.bussinessAdress,
        ),
        const SizedBox(height: 20),
        DataRow(
          label: '${S.of(context).administrator_name}:  ',
          value: entity?.doshMangerName,
        ),
        const SizedBox(height: 20),
        DataRow(
          label: '${S.of(context).administrator_phone}: ',
          value: entity?.doshMangerPhone,
        ),
        const SizedBox(height: 20),
        Divider(color: Colors.grey.shade300),
        const SizedBox(height: 20),
        DataRow(label: '${S.of(context).start_date}:  ', value: '15 Mar 2020'),
        const SizedBox(height: 20),
        DataRow(
          label: '${S.of(context).payment_method}:  ',
          value: 'تحويل بنكي',
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

class DataRow extends StatelessWidget {
  final String? label;
  final String? value;

  const DataRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      textDirection: TextDirection.ltr,
      children: [
        Flexible(
          child: Text(
            value ?? 'Unknown',
            style: AppStyles.styleMedium14(
              context,
            ).copyWith(color: Colors.grey.shade600),
          ),
        ),
        Text(
          label ?? 'Unknown',
          style: AppStyles.styleMedium14(
            context,
          ).copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
