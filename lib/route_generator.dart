import 'package:app/ui/home/master.dart';
import 'package:app/ui/home/state/home_cubit.dart';
import 'package:app/ui/image/master.dart';
import 'package:app/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';

class RouteGenerator {
  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();

  static BuildContext get context => rootNavigatorKey.currentContext!;

  static late HomeCubit homeCubit;

  static void initializeCubits() {
    homeCubit = HomeCubit();
  }

  static GoRouter generateRoutes() {
    return GoRouter(
      navigatorKey: rootNavigatorKey,
      initialLocation: Routes.HOME_SCREEN.value,
      onException: (context, state, exception) {
        Get.find<Logger>().e(exception);
      },
      routes: [
        GoRoute(
          path: Routes.HOME_SCREEN.value,
          builder: (context, state) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: homeCubit),
            ],
            child: const HomePage(),
          ),
        ),
        GoRoute(
          path: Routes.VIEW_IMAGE.value,
          builder: (context, state) =>MultiBlocProvider(
            providers: [
              BlocProvider.value(value: homeCubit),
            ],
            child: const ViewImagePage(),
          ),
        )
      ],
    );
  }
}
