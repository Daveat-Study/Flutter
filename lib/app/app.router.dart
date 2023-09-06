import 'package:flutter/material.dart';
import 'package:stacked_from_scratch/ui/views/login/login_view.dart';
import 'package:stacked_services/stacked_services.dart' as _i5;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_from_scratch/ui/views/startup/startup_view.dart' as _i2;

class Routes {

  static const startupView = '/startup-view';
  static const loginView = "/login-view";

  static const all = <String>{
    startupView,
    loginView
  };
  
}

class StackedRouter extends _i1.RouterBase {

  // initialize Route Object
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.startupView,
      page: _i2.StartupView
    ),
    _i1.RouteDef(
      Routes.loginView,
      page: LoginView
    )
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{

    _i2.StartupView: (settings) {
      return MaterialPageRoute(builder: (context) => const _i2.StartupView(), settings: settings);
    },
    LoginView: (settings){
      return MaterialPageRoute(builder: (context) => const LoginView(), settings: settings);
    }

  };

  @override
  List<_i1.RouteDef> get routes => _routes;

  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;

}

extension NavigatorStateExtension on _i5.NavigationService{

  Future<dynamic> navigateToLoginView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transition
  ]) async {
    return navigateTo<dynamic>(
      Routes.loginView,
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition
    );
  }

  Future<dynamic> replaceWithLoginView([int? routerId, bool preventDuplicates = true, Map<String, String>? parameters, Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transition]) async {

    return replaceWith<dynamic>(Routes.loginView, parameters: parameters, transition: transition);
  }

}