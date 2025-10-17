import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_tracking_app/core/app_theme.dart';
import 'package:flowery_tracking_app/core/global_cubit/global_cubit.dart';
import 'package:flowery_tracking_app/core/global_cubit/global_state.dart';
import 'package:flowery_tracking_app/core/router/app_routes.dart';
import 'package:flowery_tracking_app/core/router/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FloweryTrackingApp extends StatelessWidget {
  const FloweryTrackingApp({super.key});

  @override
  Widget build(BuildContext context) {
    final globalCubit = BlocProvider.of<GlobalCubit>(context);
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => BlocBuilder<GlobalCubit, GlobalState>(
        buildWhen: (previous, current) =>
            current is LoadedRedirectedScreen ||
            current is ChangeLanguageIndexState,
        builder: (context, state) => globalCubit.redirectedScreen != null
            ? MaterialApp(
                title: 'Flowery',
                debugShowCheckedModeBanner: false,
                theme: AppTheme.lightTheme,
                themeMode: ThemeMode.light,
                onGenerateRoute: AppRoutes.onGenerateRoute,
                initialRoute:RouteNames.bottomNavigation ,
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
