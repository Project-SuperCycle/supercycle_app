import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supercycle/core/services/storage_services.dart';
import 'package:supercycle/features/home/data/managers/home_cubit/home_cubit.dart';
import 'package:supercycle/features/home/presentation/widgets/home_chart/sales_chart_card.dart';
import 'package:supercycle/features/home/presentation/widgets/home_view_header.dart';
import 'package:supercycle/features/home/presentation/widgets/types_section/types_list_view.dart';
import 'package:supercycle/features/home/presentation/widgets/types_section/types_section_header.dart';
import 'package:supercycle/features/home/presentation/widgets/today_shipments_card.dart';
import 'package:supercycle/features/sign_in/data/models/logined_user_model.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key, required this.onDrawerPressed});
  final VoidCallback onDrawerPressed;

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  bool isUserLoggedIn = false;

  @override
  void initState() {
    super.initState();
    loadUserData();

    // استدعاء الـ method الجديدة مرة واحدة بس
    var cubit = BlocProvider.of<HomeCubit>(context, listen: false);
    cubit.fetchInitialData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // إعادة تحميل بيانات المستخدم عند الرجوع للصفحة
    loadUserData();
  }

  void loadUserData() async {
    LoginedUserModel? loginedUser = await StorageServices.getUserData();
    if (mounted) {
      setState(() {
        isUserLoggedIn = (loginedUser != null);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: RefreshIndicator(
        onRefresh: () async {
          loadUserData();
          await context.read<HomeCubit>().refreshData();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              HomeViewHeader(onDrawerPressed: widget.onDrawerPressed),
              const SizedBox(height: 10),
              (isUserLoggedIn == false)
                  ? const SizedBox.shrink()
                  : TodayShipmentsCard(),
              SalesChartCard(),
              const SizedBox(height: 20),
              TypesSectionHeader(),
              const SizedBox(height: 12),
              TypesListView(),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
