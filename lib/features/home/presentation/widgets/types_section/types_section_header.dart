import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart' show SvgPicture;
import 'package:supercycle_app/core/utils/app_assets.dart' show AppAssets;
import 'package:supercycle_app/core/utils/app_styles.dart' show AppStyles;
import 'package:supercycle_app/features/home/presentation/widgets/types_section/types_filter_buttons_list.dart';
import 'package:supercycle_app/generated/l10n.dart' show S;

class TypesSectionHeader extends StatefulWidget {
  const TypesSectionHeader({super.key});

  @override
  State<TypesSectionHeader> createState() => _TypesSectionHeaderState();
}

class _TypesSectionHeaderState extends State<TypesSectionHeader> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              S.of(context).types,
              style: AppStyles.styleSemiBold20(
                context,
              ).copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            textDirection: TextDirection.ltr,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  },
                  icon: SvgPicture.asset(
                    AppAssets.drawerIcon,
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(Colors.grey, BlendMode.srcIn),
                  ),
                ),
              ),
              SizedBox(width: 10),
              isExpanded ? TypesFilterButtonsList() : SizedBox.shrink(),
            ],
          ),
        ],
      ),
    );
  }
}
