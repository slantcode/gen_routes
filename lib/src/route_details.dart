import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// Holds the details for the Route.
class RouteDetails extends Equatable {
  final String routeName;
  final Widget screen;
  final bool useCupertino;
  final bool fullscreenDialog;

  const RouteDetails({
    required this.routeName,
    required this.screen,
    required this.useCupertino,
    required this.fullscreenDialog
  });

  @override
  List<Object?> get props => [ routeName ];
}