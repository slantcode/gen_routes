import 'package:flutter/material.dart';
import 'package:gen_routes/src/gen_routes.dart';
import 'package:gen_routes/src/route_details.dart';

/// App Level Widget to use the Router.
class GenRoutesApp extends StatefulWidget {
  final bool debugShowCheckedModeBanner;
  final RouteDetails? initialRoute;
  final ThemeData? theme;
  final ThemeData? darkTheme;
  final ThemeMode? themeMode;

  const GenRoutesApp({
    super.key,
    this.debugShowCheckedModeBanner = true,
    this.initialRoute,
    this.theme,
    this.darkTheme,
    this.themeMode
  });

  @override
  State<GenRoutesApp> createState() => _GenRoutesAppState();
}

class _GenRoutesAppState extends State<GenRoutesApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: widget.debugShowCheckedModeBanner,
      theme: widget.theme,
      darkTheme: widget.darkTheme,
      themeMode: widget.themeMode,
      onGenerateRoute: GenRoutes.onGenerateRoute,
      navigatorKey: GenRoutes.navigatorKey,
      initialRoute: widget.initialRoute?.routeName
    );
  }
}