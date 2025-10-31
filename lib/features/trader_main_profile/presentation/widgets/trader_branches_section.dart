import 'package:flutter/material.dart';
import 'package:supercycle_app/core/utils/app_colors.dart';
import 'package:supercycle_app/core/utils/app_styles.dart';
import 'package:supercycle_app/features/trader_main_profile/data/models/trader_profile_data.dart';
import 'package:fl_chart/fl_chart.dart';

class TraderBranchesSection extends StatefulWidget {
  const TraderBranchesSection({
    super.key,
    required this.branches,
    required this.types,
  });

  final List<BranchModel> branches;
  final List<String> types;

  @override
  State<TraderBranchesSection> createState() => _TraderBranchesSectionState();
}

class _TraderBranchesSectionState extends State<TraderBranchesSection> {
  bool _isListView = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        const SizedBox(height: 12),
        _isListView ? _buildBranchesList() : _buildBranchesChart(),
        const SizedBox(height: 30),
        _buildTypeUsed(),
      ],
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("الفروع المتعاونة", style: AppStyles.styleSemiBold18(context)),
        Row(
          children: [
            _buildViewToggleButton(Icons.list, true),
            _buildViewToggleButton(Icons.bar_chart, false),
          ],
        ),
      ],
    );
  }

  Widget _buildViewToggleButton(IconData icon, bool isListButton) {
    final isActive = _isListView == isListButton;
    return IconButton(
      icon: Icon(icon, color: isActive ? AppColors.primaryColor : Colors.grey),
      onPressed: () => setState(() => _isListView = isListButton),
    );
  }

  Widget _buildBranchesList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.branches.length,
      itemBuilder: (context, index) {
        final branch = widget.branches[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: InkWell(
            onTap: () => _showBranchDetails(branch),
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: _decorBox(),
              child: Row(
                children: [
                  Icon(
                    Icons.store_outlined,
                    color: AppColors.primaryColor,
                    size: 40,
                  ),
                  const SizedBox(width: 16),
                  Expanded(child: _buildBranchInfo(branch)),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.primaryColor,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  BoxDecoration _decorBox() => BoxDecoration(
    color: AppColors.primaryColor.withAlpha(25),
    borderRadius: BorderRadius.circular(12),
    border: Border.all(
      color: AppColors.primaryColor.withAlpha(100),
      width: 1.5,
    ),
  );

  Widget _buildBranchInfo(BranchModel branch) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          branch.name,
          style: AppStyles.styleSemiBold16(
            context,
          ).copyWith(color: AppColors.primaryColor),
        ),
        const SizedBox(height: 4),
        Text(
          "كمية التوريدات: ${branch.deliveryVolume} كجم",
          style: AppStyles.styleSemiBold12(
            context,
          ).copyWith(color: AppColors.subTextColor),
        ),
      ],
    );
  }

  Widget _buildBranchesChart() {
    final branches = widget.branches;
    if (branches.isEmpty) {
      return const Center(child: Text("لا توجد بيانات للفروع"));
    }

    final maxVolume = branches
        .map((b) => b.deliveryVolume)
        .reduce((a, b) => a > b ? a : b);

    return SizedBox(
      height: 300,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: maxVolume * 1.2,
          borderData: FlBorderData(show: false),
          gridData: const FlGridData(show: false),
          titlesData: FlTitlesData(
            leftTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: true, reservedSize: 50),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 60,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  if (index < 0 || index >= branches.length)
                    return const SizedBox();
                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      branches[index].name,
                      style: AppStyles.styleSemiBold12(context),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                },
              ),
            ),
          ),
          barGroups: List.generate(branches.length, (index) {
            final branch = branches[index];
            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: branch.deliveryVolume.toDouble(),
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(6),
                  width: 22,
                ),
              ],
              showingTooltipIndicators: [0],
            );
          }),
          barTouchData: BarTouchData(
            enabled: true,
            touchTooltipData: BarTouchTooltipData(
              tooltipRoundedRadius: 8,
              getTooltipColor: (_) => AppColors.primaryColor.withOpacity(0.9),
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                final branch = branches[group.x.toInt()];
                return BarTooltipItem(
                  "${branch.name}\n${branch.deliveryVolume} كجم",
                  const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTypesSection(List<String> types) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.category, color: AppColors.primaryColor, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "الأنواع المتعامل بها",
                  style: AppStyles.styleSemiBold12(
                    context,
                  ).copyWith(color: AppColors.subTextColor),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: types.map((type) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: AppColors.primaryColor.withAlpha(100),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        type,
                        style: AppStyles.styleSemiBold12(
                          context,
                        ).copyWith(color: AppColors.primaryColor),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showBranchDetails(BranchModel branch) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _BranchDetailsSheet(branch: branch),
    );
  }

  Widget _buildTypeUsed() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "الأنواع المتعامل بيها:",
          style: AppStyles.styleSemiBold18(context),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: widget.types.map((type) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: _decorBox().copyWith(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                type,
                style: AppStyles.styleSemiBold12(
                  context,
                ).copyWith(color: AppColors.primaryColor),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _BranchDetailsSheet extends StatelessWidget {
  const _BranchDetailsSheet({required this.branch});

  final BranchModel branch;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 50,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text("تفاصيل الفرع", style: AppStyles.styleSemiBold18(context)),
            const SizedBox(height: 24),
            _DetailRow(Icons.store, "اسم الفرع", branch.name),
            _DetailRow(Icons.location_on, "عنوان الفرع", branch.address),
            _DetailRow(Icons.person, "اسم المسؤول", branch.managerName),
            _DetailRow(Icons.phone, "رقم تواصل المسؤول", branch.managerPhone),
            _DetailRow(
              Icons.inventory_2,
              "حجم التوريدات",
              "${branch.deliveryVolume} كجم",
            ),
            _DetailRow(
              Icons.schedule,
              "ميعاد التسليم",
              branch.deliverySchedule,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.category, color: AppColors.primaryColor, size: 24),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "الأنواع المتعامل بها",
                          style: AppStyles.styleSemiBold12(
                            context,
                          ).copyWith(color: AppColors.subTextColor),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: branch.recyclableTypes.map((type) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor.withAlpha(25),
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: AppColors.primaryColor.withAlpha(100),
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                type,
                                style: AppStyles.styleSemiBold12(
                                  context,
                                ).copyWith(color: AppColors.primaryColor),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  "إغلاق",
                  style: AppStyles.styleSemiBold16(
                    context,
                  ).copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow(this.icon, this.label, this.value);

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primaryColor, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppStyles.styleSemiBold12(
                    context,
                  ).copyWith(color: AppColors.subTextColor),
                ),
                const SizedBox(height: 4),
                Text(value, style: AppStyles.styleSemiBold14(context)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
