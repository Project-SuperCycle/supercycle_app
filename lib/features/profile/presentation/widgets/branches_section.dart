import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BranchesSection extends StatefulWidget {
  const BranchesSection({
    super.key,
    required this.branchCount,
  });

  final int branchCount;

  @override
  State<BranchesSection> createState() => _BranchesSectionState();
}

class _BranchesSectionState extends State<BranchesSection> {
  final PageController _pageController = PageController(viewportFraction: 0.35);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "الفروع المتعاونه",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          textAlign: TextAlign.right,
        ),
        const SizedBox(height: 10),
        _buildBranchesCarousel(),
        const SizedBox(height: 12),
        Center(
          child: SmoothPageIndicator(
            controller: _pageController,
            count: widget.branchCount,
            effect: ExpandingDotsEffect(
              dotHeight: 8,
              dotWidth: 8,
              activeDotColor: Colors.green.shade600,
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
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.grey[300]!,
                  width: 1,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.store_outlined,
                    color: Colors.grey[600],
                    size: 30,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "فرع ${index + 1}",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w500,
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
        const Text(
          " الأنواع المتعامل بيها :",
          style: TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          children: const [
            Text(
              "كرتون بنى",
              style: TextStyle(
                color: Color(0xFF0BAC00),
                fontSize: 14,
              ),
            ),
            Text(
              " - ",
              style: TextStyle(
                color: Color(0xFF0BAC00),
                fontSize: 14,
              ),
            ),
            Text(
              "ورق ابيض",
              style: TextStyle(
                color: Color(0xFF0BAC00),
                fontSize: 14,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
