import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supercycle_app/core/helpers/custom_dropdown.dart'
    show CustomDropdown;
import 'package:supercycle_app/core/utils/app_colors.dart' show AppColors;
import 'package:supercycle_app/core/utils/app_styles.dart';
import 'package:supercycle_app/features/home/data/managers/home_cubit/home_cubit.dart';
import 'package:supercycle_app/features/home/data/models/dosh_data_model.dart';
import 'package:supercycle_app/features/home/data/models/type_history_model.dart'
    show TypeHistoryModel;
import 'package:supercycle_app/generated/l10n.dart' show S;

// Data model for chart (wrapper around TypeHistoryModel)
class ChartPriceData {
  final String month;
  final double price;

  ChartPriceData({required this.month, required this.price});

  // Convert TypeHistoryModel to ChartPriceData
  factory ChartPriceData.fromTypeHistory(TypeHistoryModel typeHistory) {
    return ChartPriceData(
      month: _formatMonth(typeHistory.month),
      price: double.tryParse(typeHistory.price.toString()) ?? 0.0,
    );
  }

  // Helper to format month from "2025-06" to "Jun"
  static String _formatMonth(String monthString) {
    try {
      if (monthString.contains('-')) {
        List<String> parts = monthString.split('-');
        if (parts.length >= 2) {
          int monthNum = int.tryParse(parts[1]) ?? 1;
          List<String> months = [
            'Jan',
            'Feb',
            'Mar',
            'Apr',
            'May',
            'Jun',
            'Jul',
            'Aug',
            'Sep',
            'Oct',
            'Nov',
            'Dec',
          ];
          return months[monthNum - 1];
        }
      }
      return monthString;
    } catch (e) {
      return monthString;
    }
  }
}

class _LineChart extends StatelessWidget {
  const _LineChart({
    required this.priceData,
    this.priceFormatter,
    this.priceInterval,
    this.maxPrice,
    this.minPrice,
    this.showAllMonths = true,
  });

  final List<ChartPriceData> priceData;
  final String Function(double)? priceFormatter;
  final double? priceInterval;
  final double? maxPrice;
  final double? minPrice;
  final bool showAllMonths;

  @override
  Widget build(BuildContext context) {
    return LineChart(chartData, duration: const Duration(milliseconds: 250));
  }

  LineChartData get chartData => LineChartData(
    lineTouchData: lineTouchData,
    gridData: gridData,
    titlesData: titlesData,
    borderData: borderData,
    lineBarsData: [lineChartBarData],
    minX: 0,
    maxX: (priceData.length - 1).toDouble(),
    maxY: _getMaxPrice() * 1.1,
    // Add 10% padding
    minY: _getMinPrice() * 0.9,
  );

  LineTouchData get lineTouchData => LineTouchData(
    handleBuiltInTouches: true,
    touchTooltipData: LineTouchTooltipData(
      getTooltipColor: (touchedSpot) => Colors.blueGrey.withValues(alpha: 0.8),
      getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
        return touchedBarSpots.map((barSpot) {
          final flSpot = barSpot;
          final index = flSpot.x.toInt();
          if (index >= 0 && index < priceData.length) {
            String formattedPrice = priceFormatter != null
                ? priceFormatter!(flSpot.y)
                : '\$${flSpot.y.toStringAsFixed(1)}';
            return LineTooltipItem(
              '${priceData[index].month}\n$formattedPrice',
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            );
          }
          return null;
        }).toList();
      },
    ),
  );

  FlTitlesData get titlesData => FlTitlesData(
    bottomTitles: AxisTitles(sideTitles: bottomTitles),
    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
    leftTitles: AxisTitles(sideTitles: leftTitles()),
  );

  double _getMaxPrice() {
    if (priceData.isEmpty) return 4.0;
    if (maxPrice != null) return maxPrice!;
    return priceData.map((e) => e.price).reduce((a, b) => a > b ? a : b);
  }

  double _getMinPrice() {
    if (minPrice != null) return minPrice!;
    if (priceData.isEmpty) return 0.0;
    double dataMinPrice = priceData
        .map((e) => e.price)
        .reduce((a, b) => a < b ? a : b);
    return dataMinPrice > 0 ? dataMinPrice * 0.9 : 0.0;
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
      fontFamily: 'Cairo',
      color: Colors.grey,
    );
    String formattedPrice = priceFormatter != null
        ? priceFormatter!(value)
        : '\$${value.toStringAsFixed(1)}';
    return SideTitleWidget(
      meta: meta,
      child: Text(formattedPrice, style: style, textAlign: TextAlign.center),
    );
  }

  SideTitles leftTitles() => SideTitles(
    getTitlesWidget: leftTitleWidgets,
    showTitles: true,
    interval: priceInterval ?? ((_getMaxPrice() - _getMinPrice()) / 4),
    reservedSize: 50,
  );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
      fontFamily: 'Cairo',
      color: Colors.grey,
    );
    final index = value.toInt();
    if (index >= 0 && index < priceData.length) {
      if (showAllMonths || index % 3 == 0 || index == priceData.length - 1) {
        return SideTitleWidget(
          meta: meta,
          space: 10,
          child: Text(priceData[index].month.toUpperCase(), style: style),
        );
      }
    }
    return SideTitleWidget(meta: meta, child: const Text(''));
  }

  SideTitles get bottomTitles => SideTitles(
    showTitles: true,
    reservedSize: 30,
    interval: showAllMonths ? 1 : null,
    getTitlesWidget: bottomTitleWidgets,
  );

  FlGridData get gridData => const FlGridData(show: false);

  FlBorderData get borderData => FlBorderData(
    show: true,
    border: Border(
      bottom: BorderSide(
        color: AppColors.primaryColor.withValues(alpha: 0.2),
        width: 3,
      ),
      left: const BorderSide(color: Colors.transparent),
      right: const BorderSide(color: Colors.transparent),
      top: const BorderSide(color: Colors.transparent),
    ),
  );

  LineChartBarData get lineChartBarData => LineChartBarData(
    isCurved: true,
    color: AppColors.primaryColor,
    barWidth: 4,
    isStrokeCapRound: true,
    dotData: const FlDotData(show: true),
    belowBarData: BarAreaData(
      show: true,
      color: AppColors.primaryColor.withValues(alpha: 0.1),
    ),
    spots: _getFlSpots(),
  );

  List<FlSpot> _getFlSpots() {
    return priceData
        .asMap()
        .entries
        .map((entry) => FlSpot(entry.key.toDouble(), entry.value.price))
        .toList();
  }
}

class SalesLineChart extends StatefulWidget {
  final String Function(double)? priceFormatter;
  final double? priceInterval;
  final double? maxPrice;
  final double? minPrice;
  final bool showAllMonths;

  const SalesLineChart({
    super.key,
    this.priceFormatter,
    this.priceInterval,
    this.maxPrice,
    this.minPrice,
    this.showAllMonths = true,
  });

  @override
  State<SalesLineChart> createState() => SalesLineChartState();
}

class SalesLineChartState extends State<SalesLineChart> {
  String? selectedTypeId;
  List<DoshDataModel> doshData = [];
  String? selectedTypeName;
  bool isInitialized = false;

  @override
  void initState() {
    super.initState();
  }

  void _loadTypeHistory({String? typeId}) {
    final String finalTypeId =
        typeId ?? selectedTypeId ?? '68a8567bf5a2951a1ee9e982';
    BlocProvider.of<HomeCubit>(context).fetchTypeHistory(typeId: finalTypeId);
  }

  void _loadDoshTypes() {
    BlocProvider.of<HomeCubit>(context).fetchTypesData();
  }

  void _onDropdownChanged(String? value) {
    if (value != null && doshData.isNotEmpty) {
      try {
        final selectedType = doshData.firstWhere(
          (e) => e.name == value,
          orElse: () => doshData.first,
        );
        setState(() {
          selectedTypeId = selectedType.id;
          selectedTypeName = selectedType.name;
        });
        _loadTypeHistory(typeId: selectedTypeId!);
      } catch (e) {
        debugPrint('Error in dropdown selection: $e');
        // Fall back to first item if available
        if (doshData.isNotEmpty) {
          setState(() {
            selectedTypeId = doshData.first.id;
            selectedTypeName = doshData.first.name;
          });
          _loadTypeHistory(typeId: selectedTypeId!);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        S.of(context).price_indicator,
                        style: AppStyles.styleSemiBold20(
                          context,
                        ).copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: _buildDropdown(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20, left: 10),
                    child: _buildChart(),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown() {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is FetchTypesDataSuccess) {
          setState(() {
            doshData = state.doshData;
            // Set initial selection if not already set
            if (!isInitialized && doshData.isNotEmpty) {
              selectedTypeId = doshData.first.id;
              selectedTypeName = doshData.first.name;
              isInitialized = true;
            }
          });
          // Load initial data
          if (selectedTypeId != null) {
            _loadTypeHistory(typeId: selectedTypeId);
          }
        }
        if (state is FetchTypesDataFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 3),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is FetchTypesDataLoading) {
          return Container(
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.withAlpha(100)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: AppColors.primaryColor,
                  strokeWidth: 2,
                ),
              ),
            ),
          );
        }

        if (state is FetchTypesDataSuccess && doshData.isNotEmpty) {
          return CustomDropdown(
            options: doshData.map((e) => e.name).toList(),
            onChanged: _onDropdownChanged,
            hintText: S.of(context).select_type,
            initialValue: selectedTypeName, // Set current value
          );
        }

        // Fallback dropdown with default options
        return CustomDropdown(
          options: const ["ورق", "كرتون"],
          onChanged: _onDropdownChanged,
          hintText: S.of(context).select_type,
          initialValue: selectedTypeName,
        );
      },
      buildWhen: (previous, current) =>
          current is FetchTypesDataSuccess ||
          current is FetchTypesDataFailure ||
          current is FetchTypesDataLoading,
    );
  }

  Widget _buildChart() {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        // Handle TypeHistoryLoading state
        if (state is FetchTypeHistoryLoading) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primaryColor),
          );
        }

        // Handle TypeHistoryFailure state
        if (state is FetchTypeHistoryFailure) {
          return _buildErrorWidget(state.message);
        }

        // Handle TypeHistorySuccess state
        if (state is FetchTypeHistorySuccess) {
          if (state.history.isEmpty) {
            return _buildNoDataWidget();
          }

          // Convert TypeHistoryModel list to ChartPriceData list
          List<ChartPriceData> chartData = state.history
              .map((typeHistory) => ChartPriceData.fromTypeHistory(typeHistory))
              .toList();

          return _LineChart(
            priceData: chartData,
            priceFormatter: widget.priceFormatter,
            priceInterval: widget.priceInterval,
            maxPrice: widget.maxPrice,
            minPrice: widget.minPrice,
            showAllMonths: widget.showAllMonths,
          );
        }

        // Default state - show initial widget
        return _buildInitialWidget();
      },
      buildWhen: (previous, current) =>
          current is FetchTypeHistorySuccess ||
          current is FetchTypeHistoryFailure ||
          current is FetchTypeHistoryLoading,
    );
  }

  Widget _buildErrorWidget(String errorMessage) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 48,
            color: Colors.red.withValues(alpha: 0.7),
          ),
          const SizedBox(height: 16),
          const Text(
            "No Data Available",
            style: TextStyle(
              color: Colors.red,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.red.withValues(alpha: 0.8),
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => _loadTypeHistory(),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              foregroundColor: Colors.white,
            ),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildNoDataWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.analytics_outlined,
            size: 48,
            color: Colors.grey.withValues(alpha: 0.7),
          ),
          const SizedBox(height: 16),
          const Text(
            'No data available',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => _loadTypeHistory(),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              foregroundColor: Colors.white,
            ),
            child: const Text('Load Data'),
          ),
        ],
      ),
    );
  }

  Widget _buildInitialWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.show_chart,
            size: 48,
            color: AppColors.primaryColor.withValues(alpha: 0.7),
          ),
          const SizedBox(height: 16),
          Text(
            'Chart ready to load',
            style: TextStyle(
              fontSize: 16,
              color: AppColors.primaryColor.withValues(alpha: 0.8),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => _loadTypeHistory(),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              foregroundColor: Colors.white,
            ),
            child: const Text('Load Chart'),
          ),
        ],
      ),
    );
  }
}
