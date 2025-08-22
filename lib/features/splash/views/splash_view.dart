import 'package:flutter/material.dart';
import 'package:supercycle_app/core/constants.dart';
import 'package:supercycle_app/core/utils/app_assets.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: MediaQuery.sizeOf(context).width,
                  height: MediaQuery.sizeOf(context).height,
                  decoration: const BoxDecoration(
                    gradient: kGradientBackground,
                  ),
                ),
              ),
              Positioned(
                left: -MediaQuery.of(context).size.width * 0.4,
                top: -MediaQuery.of(context).size.height * 0.25,
                child: Opacity(
                  opacity: 0.05,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.8,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(AppAssets.logoIcon),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: MediaQuery.of(context).size.width * 0.4,
                top: MediaQuery.of(context).size.height * 0.3,
                child: Opacity(
                  opacity: 0.05,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: MediaQuery.of(context).size.height * 0.85,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(AppAssets.logoIcon),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppAssets.logo),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
