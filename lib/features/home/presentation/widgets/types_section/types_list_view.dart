import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:supercycle_app/core/helpers/custom_loading_indicator.dart';
import 'package:supercycle_app/core/services/dosh_types_manager.dart';
import 'package:supercycle_app/core/services/services_locator.dart';
import 'package:supercycle_app/features/home/data/managers/home_cubit/home_cubit.dart';
import 'package:supercycle_app/features/home/presentation/widgets/types_section/type_card_item.dart';

class TypesListView extends StatefulWidget {
  const TypesListView({super.key});

  @override
  State<TypesListView> createState() => _TypesListViewState();
}

class _TypesListViewState extends State<TypesListView> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeCubit>(context).fetchDoshTypes();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is FetchDoshTypesFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }

        if (state is FetchDoshTypesSuccess) {
          List<DoshItem> typesList = state.doshTypes
              .map((e) => DoshItem(name: e.name, price: e.maxPrice))
              .toList();
          getIt<DoshTypesManager>().setTypesList(typesList);
        }
      },
      builder: (context, state) {
        if (state is FetchDoshTypesLoading) {
          return const Center(child: CustomLoadingIndicator());
        }
        if (state is FetchDoshTypesSuccess) {
          if (state.doshTypes.isEmpty) {
            return const Center(child: Text('No Dosh Types'));
          }
          final items = state.doshTypes;
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: items
                  .map(
                    (item) => IntrinsicHeight(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 10.0,
                        ),
                        child: TypeCardItem(typeModel: item),
                      ),
                    ),
                  )
                  .toList(),
            ),
          );
        }

        return Container();
      },
      buildWhen: (previous, current) =>
          current is FetchDoshTypesSuccess ||
          current is FetchDoshTypesFailure ||
          current is FetchDoshTypesLoading,
    );
  }
}
