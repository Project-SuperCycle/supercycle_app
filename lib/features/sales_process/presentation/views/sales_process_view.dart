import 'package:flutter/cupertino.dart' show StatelessWidget;
import 'package:flutter/material.dart' show Scaffold;
import 'package:flutter/src/widgets/framework.dart';
import 'package:supercycle_app/features/sales_process/presentation/widgets/sales_process_view_body.dart';

class SalesProcessView extends StatelessWidget {
  const SalesProcessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: const SalesProcessViewBody());
  }

}