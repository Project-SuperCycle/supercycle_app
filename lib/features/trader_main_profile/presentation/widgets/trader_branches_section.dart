import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:supercycle_app/core/utils/app_colors.dart';
import 'package:supercycle_app/core/utils/app_styles.dart';

class TraderBranchesSection extends StatefulWidget {
  const TraderBranchesSection({super.key, required this.branchCount});

  final int branchCount;

  @override
  State<TraderBranchesSection> createState() => _TraderBranchesSectionState();
}

class _TraderBranchesSectionState extends State<TraderBranchesSection> {
  final PageController _pageController = PageController(viewportFraction: 0.35);
  List<String> types = ["كرتون بنى", "ورق ابيض"];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "الفروع المتعاونه",
          style: AppStyles.styleSemiBold18(context),
          textAlign: TextAlign.right,
        ),
        const SizedBox(height: 12),
        _buildBranchesCarousel(),
        const SizedBox(height: 12),
        Center(
          child: SmoothPageIndicator(
            controller: _pageController,
            count: widget.branchCount,
            effect: ExpandingDotsEffect(
              dotHeight: 8,
              dotWidth: 8,
              activeDotColor: const Color(0xFF10B981),
              dotColor: Colors.grey.shade400,
            ),
          ),
        ),
        const SizedBox(height: 30),
        _buildTypeUsed(),
      ],
    );
  }

  Widget _buildBranchesCarousel() {
    return SizedBox(
      height: 100,
      child: PageView.builder(
        controller: _pageController,
        itemCount: widget.branchCount,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF10B981).withAlpha(25),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF10B981).withAlpha(100), width: 1.5),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.store_outlined, color: const Color(0xFF10B981), size: 30),
                  const SizedBox(height: 8),
                  Text(
                    "فرع ${index + 1}",
                    style: AppStyles.styleSemiBold12(context).copyWith(
                      color: const Color(0xFF059669),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTypeUsed() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          " الأنواع المتعامل بيها :",
          style: AppStyles.styleSemiBold18(context),
        ),
        const SizedBox(height: 10.0),
        Row(
          children: [
            ...types.map(
                  (type) => Text(
                "$type - ",
                style: AppStyles.styleSemiBold12(
                  context,
                ).copyWith(color: AppColors.subTextColor),
              ),
            ),
          ],
        ),
      ],
    );
  }
}