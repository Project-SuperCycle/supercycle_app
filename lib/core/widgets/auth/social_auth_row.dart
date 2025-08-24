import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart' show GoRouter;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart' show Logger;
import 'package:supercycle_app/core/cubits/social_auth/social_auth_cubit.dart';
import 'package:supercycle_app/core/models/social_auth_request_model.dart';
import 'package:supercycle_app/core/routes/end_points.dart';
import 'package:supercycle_app/core/services/social_auth_services.dart';
import 'package:supercycle_app/core/utils/app_assets.dart';

class SocialAuthRow extends StatelessWidget {
  const SocialAuthRow({
    super.key,

  });




  void signInWithGoogle({required BuildContext context}) async {
    final accessToken = await SocialAuthService.signInWithGoogle();
    final SocialAuthRequestModel credentials = SocialAuthRequestModel(
      provider: "google",
      accessToken: accessToken,
    );
    Logger().i("GOOGLE SIGN IN -> ${credentials.toJson()}");
    BlocProvider.of<SocialAuthCubit>(context).socialAuth(credentials);
  }

  void signInWithFacebook({required BuildContext context}) async {
    final accessToken = await SocialAuthService.signInWithFacebook();
    final SocialAuthRequestModel credentials = SocialAuthRequestModel(
      provider: "facebook",
      accessToken: accessToken,
    );
    Logger().i("FACEBOOK SIGN IN -> ${credentials.toJson()}");
    BlocProvider.of<SocialAuthCubit>(context).socialAuth(credentials);
  }



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAuthCubit, SocialAuthState>(
      listener: (context, state) {
        // TODO: implement listener
        if(state is SocialAuthSuccess){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.socialAuth.message ?? "NO MESSAGE")));
          if (state.socialAuth.status == 201){
            GoRouter.of(context).push(EndPoints.signUpDetailsView);
          } else if (state.socialAuth.status == 200){
            GoRouter.of(context).push(EndPoints.homeView);
          }
        }
        if(state is SocialAuthFailure){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)));
          Logger().w(state.message);
        }
      },
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              style: IconButton.styleFrom(
                padding: EdgeInsets.all(2.0),
              ),
              onPressed: () => signInWithGoogle(context: context),
              icon: Image.asset(AppAssets.googleIcon, scale: 3.5),
            ),
            SizedBox(width: 30),
            IconButton(
              style: IconButton.styleFrom(
                padding: EdgeInsets.all(2.0),
              ),
              onPressed: () => signInWithFacebook(context: context),
              icon: Image.asset(AppAssets.facebookIcon, scale: 3.5),
            ),
          ],
        );
      },
    );
  }
}
