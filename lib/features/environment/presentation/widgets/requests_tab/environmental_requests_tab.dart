import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supercycle/core/helpers/custom_loading_indicator.dart';
import 'package:supercycle/core/utils/app_styles.dart';
import 'package:supercycle/features/environment/data/cubits/requests_cubit/requests_cubit.dart';
import 'package:supercycle/features/environment/presentation/widgets/requests_tab/enviromental_request_card.dart';
import 'package:supercycle/features/trader_main_profile/data/models/environmental_redeem_model.dart';

class EnvironmentalRequestsTab extends StatefulWidget {
  const EnvironmentalRequestsTab({super.key});

  @override
  State<EnvironmentalRequestsTab> createState() =>
      _EnvironmentalRequestsTabState();
}

class _EnvironmentalRequestsTabState extends State<EnvironmentalRequestsTab> {
  // Pagination settings
  int _currentPage = 1;
  final int _itemsPerPage = 5;
  bool _isLoadingPage = false;

  @override
  void initState() {
    super.initState();
    // Fetch requests when tab is opened
    context.read<RequestsCubit>().getTraderEcoRequests();
  }

  int _getTotalPages(int totalItems) {
    return (totalItems / _itemsPerPage).ceil();
  }

  int get _startIndex => (_currentPage - 1) * _itemsPerPage;

  int _getEndIndex(int totalItems) {
    final end = _startIndex + _itemsPerPage;
    return end > totalItems ? totalItems : end;
  }

  List<EnvironmentalRedeemModel> _getCurrentPageRequests(
    List<EnvironmentalRedeemModel> allRequests,
  ) {
    if (allRequests.isEmpty) return [];
    final endIndex = _getEndIndex(allRequests.length);
    return allRequests.sublist(_startIndex, endIndex);
  }

  Future<void> _goToPage(int page, int totalPages) async {
    if (page < 1 || page > totalPages || page == _currentPage) return;

    setState(() {
      _isLoadingPage = true;
    });

    await Future.delayed(const Duration(milliseconds: 300));

    setState(() {
      _currentPage = page;
      _isLoadingPage = false;
    });
  }

  Future<void> _nextPage(int totalPages) async {
    if (_currentPage < totalPages) {
      await _goToPage(_currentPage + 1, totalPages);
    }
  }

  Future<void> _previousPage(int totalPages) async {
    if (_currentPage > 1) {
      await _goToPage(_currentPage - 1, totalPages);
    }
  }

  Future<void> _onRefresh() async {
    setState(() {
      _currentPage = 1;
    });
    await context.read<RequestsCubit>().getTraderEcoRequests();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RequestsCubit, RequestsState>(
      listener: (context, state) {
        if (state is RequestsFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errMessage),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        // Loading state
        if (state is RequestsLoading) {
          return Center(child: CustomLoadingIndicator());
        }

        // Failure state
        if (state is RequestsFailure) {
          return _buildErrorState(state.errMessage);
        }

        // Success state
        if (state is RequestsSuccess) {
          if (state.requests.isEmpty) {
            return _buildEmptyState();
          }

          final totalPages = _getTotalPages(state.requests.length);
          final endIndex = _getEndIndex(state.requests.length);
          final currentPageRequests = _getCurrentPageRequests(state.requests);

          return RefreshIndicator(
            onRefresh: _onRefresh,
            color: const Color(0xFF10B981),
            child: CustomScrollView(
              slivers: [
                // Header Section
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(25, 10, 25, 0),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'الطلبات البيئية',
                              style: AppStyles.styleSemiBold18(context),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF10B981).withAlpha(50),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                'إجمالي: ${state.requests.length}',
                                style: AppStyles.styleSemiBold12(
                                  context,
                                ).copyWith(color: const Color(0xFF10B981)),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),

                // Requests List
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  sliver: _isLoadingPage
                      ? SliverToBoxAdapter(
                          child: SizedBox(
                            height: 400,
                            child: Center(child: CustomLoadingIndicator()),
                          ),
                        )
                      : SliverList.builder(
                          itemBuilder: (context, index) {
                            return EcoRequestCard(
                              request: currentPageRequests[index],
                            );
                          },
                          itemCount: currentPageRequests.length,
                        ),
                ),

                // Pagination Controls
                SliverToBoxAdapter(
                  child: _buildPaginationControls(
                    totalPages,
                    state.requests.length,
                    endIndex,
                  ),
                ),

                // Bottom Spacing
                const SliverToBoxAdapter(child: SizedBox(height: 100)),
              ],
            ),
          );
        }

        // Initial state
        return Center(child: CustomLoadingIndicator());
      },
    );
  }

  Widget _buildPaginationControls(
    int totalPages,
    int totalItems,
    int endIndex,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 0),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Divider(color: Colors.grey[300], thickness: 0.6),
          ),

          // Navigation controls
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Previous button
              _buildNavigationButton(
                icon: Icons.arrow_back_ios,
                onPressed: _currentPage > 1
                    ? () => _previousPage(totalPages)
                    : null,
                tooltip: 'الصفحة السابقة',
              ),

              const SizedBox(width: 16),

              // Page indicator
              _buildPageIndicator(totalPages),

              const SizedBox(width: 16),

              // Next button
              _buildNavigationButton(
                icon: Icons.arrow_forward_ios,
                onPressed: _currentPage < totalPages
                    ? () => _nextPage(totalPages)
                    : null,
                tooltip: 'الصفحة التالية',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationButton({
    required IconData icon,
    required VoidCallback? onPressed,
    required String tooltip,
  }) {
    final isEnabled = onPressed != null;

    return Tooltip(
      message: tooltip,
      child: Material(
        color: isEnabled ? const Color(0xFF10B981) : Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
            child: Icon(
              icon,
              color: isEnabled ? Colors.white : Colors.grey[500],
              size: 18,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPageIndicator(int totalPages) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF10B981).withAlpha(50),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF10B981).withAlpha(150),
          width: 1.5,
        ),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$_currentPage',
              style: AppStyles.styleSemiBold16(context).copyWith(
                color: const Color(0xFF10B981),
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              ' من ',
              style: AppStyles.styleSemiBold12(
                context,
              ).copyWith(color: Colors.grey[600]),
            ),
            Text(
              '$totalPages',
              style: AppStyles.styleSemiBold16(context).copyWith(
                color: const Color(0xFF10B981),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.assignment_outlined, size: 80, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(
            'لا توجد طلبات',
            style: AppStyles.styleSemiBold16(
              context,
            ).copyWith(color: Colors.grey),
          ),
          const SizedBox(height: 8),
          Text(
            'سيتم عرض طلباتك البيئية هنا',
            style: AppStyles.styleSemiBold12(
              context,
            ).copyWith(color: Colors.grey[400]),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String errorMessage) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 80, color: Colors.red[300]),
          const SizedBox(height: 16),
          Text(
            'حدث خطأ',
            style: AppStyles.styleSemiBold16(
              context,
            ).copyWith(color: Colors.red),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              errorMessage,
              textAlign: TextAlign.center,
              style: AppStyles.styleSemiBold12(
                context,
              ).copyWith(color: Colors.grey[600]),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {
              context.read<RequestsCubit>().getTraderEcoRequests();
            },
            icon: const Icon(Icons.refresh),
            label: const Text('إعادة المحاولة'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF10B981),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
