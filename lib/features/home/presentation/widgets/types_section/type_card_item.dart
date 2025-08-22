import 'package:flutter/material.dart';
import 'package:supercycle_app/core/utils/app_assets.dart' show AppAssets;
import 'package:supercycle_app/core/utils/app_colors.dart' show AppColors;
import 'package:supercycle_app/core/utils/app_styles.dart' show AppStyles;
import 'package:supercycle_app/core/widgets/custom_button.dart' show CustomButton;
import 'package:supercycle_app/features/home/data/models/dosh_type_model.dart';
import 'package:supercycle_app/generated/l10n.dart' show S;

class TypeCardItem extends StatelessWidget {
  final DoshTypeModel typeModel;
  const TypeCardItem({super.key, required this.typeModel});

  String formatPrice(dynamic price) {
    if (price == null) return '0.00';

    double priceValue;

    if (price is String) {
      priceValue = double.tryParse(price) ?? 0.0;
    } else if (price is int) {
      priceValue = price.toDouble();
    } else if (price is double) {
      priceValue = price;
    } else {
      priceValue = 0.0;
    }

    return priceValue.toStringAsFixed(2);
  }

  String formatPriceRange(dynamic minPrice, dynamic maxPrice) {
    String formattedMinPrice = formatPrice(minPrice);
    String formattedMaxPrice = formatPrice(maxPrice);
    return '$formattedMinPrice : $formattedMaxPrice';
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 220 / 280,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withAlpha(150),
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              height: 125,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                image: DecorationImage(
                  image: AssetImage(AppAssets.miniature),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        typeModel.name,
                        textDirection: TextDirection.rtl,
                        style: AppStyles.styleSemiBold12(
                          context,
                        ).copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(height: 15.0),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      textDirection: TextDirection.rtl,
                      children: [
                        Text(
                          formatPriceRange(
                            typeModel.minPrice,
                            typeModel.maxPrice,
                          ),
                          textDirection: TextDirection.rtl,
                          style: AppStyles.styleSemiBold12(context).copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "${S.of(context).money} / ${S.of(context).unit}",
                          textDirection: TextDirection.rtl,
                          style: AppStyles.styleSemiBold12(
                            context,
                          ).copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0),
                  CustomButton(
                    title: S.of(context).make_process,
                    onPress: () {},
                  ),
                  SizedBox(height: 12.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
