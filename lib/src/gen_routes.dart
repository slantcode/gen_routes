import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gen_routes/src/route_details.dart';

/// Root Class to access the GenRoutes API.
class GenRoutes {
  final routes = <RouteDetails>[];
  final navKey = GlobalKey<NavigatorState>();

  /// Defines a new route.
  static RouteDetails defineRoute({
    required String routeName,
    required Widget screen,
    bool useCupertino = false,
    bool fullscreenDialog = false
  }) {
    /// Creating a new RouteDetails object
    RouteDetails newRouteDetails = RouteDetails(
      routeName: routeName,
      screen: screen,
      useCupertino: useCupertino,
      fullscreenDialog: fullscreenDialog
    );

    /// Return if the route already exists
    if(instance.routes.contains(newRouteDetails)) {
      int index = instance.routes.indexOf(newRouteDetails);
      return instance.routes[index];
    }

    /// Adding the `newRouteDetails` to the `routes` list
    instance.routes.add(newRouteDetails);
    return newRouteDetails;
  }

  static Route? onGenerateRoute(RouteSettings settings) {
    String routeName = settings.name ?? "";
    List<RouteDetails> foundRoutes = instance.routes.where((element) => element.routeName == routeName).toList();

    /// If no routes are found, return null
    if(foundRoutes.isEmpty) {
      return null;
    }

    /// Build and return a new route
    RouteDetails details = foundRoutes[0];
    if(details.useCupertino == true) {
      return CupertinoPageRoute(
        fullscreenDialog: details.fullscreenDialog,
        builder: (context) => details.screen
      );
    }
    else {
      return MaterialPageRoute(
        fullscreenDialog: details.fullscreenDialog,
        builder: (context) => details.screen
      );
    }
  }

  static void goTo(RouteDetails routeDetails) async {
    Navigator.pushNamed(navigatorKey.currentContext!, routeDetails.routeName);
  }

  static void replaceWith(RouteDetails routeDetails) async {
    Navigator.pushReplacementNamed(navigatorKey.currentContext!, routeDetails.routeName);
  }
  
  static void pop() async {
    Navigator.pop(navigatorKey.currentContext!);
  }

  static void popUntil(bool Function(Route<dynamic>) condition) {
    Navigator.popUntil(navigatorKey.currentContext!, condition);
  }

  static void closeAllExceptFirst() {
    popUntil((route) => route.isFirst);
  }

  static void closeAllAndReplaceWith(RouteDetails routeDetails) async {
    closeAllExceptFirst();
    replaceWith(routeDetails);
  }

  GenRoutes._();
  static final _instance = GenRoutes._();

  static GlobalKey<NavigatorState> get navigatorKey => _instance.navKey;
  static GenRoutes get instance => _instance;
}