import 'package:flutter/material.dart';

extension NavigationExtension on BuildContext {
  Future<T?> push<T>(Widget page) {
    return Navigator.push(
      this,
      MaterialPageRoute(
        builder: (_) => page,
      ),
    );
  }

  /// Pushes a new route onto the navigation stack and removes all previous routes.
  ///
  /// Returns a Future that completes with the result of popping the pushed route.
  Future<T?> pushReplacement<T>(Widget page) {
    return Navigator.pushReplacement(
      this,
      MaterialPageRoute(
        builder: (_) => page,
      ),
    );
  }

  /// Pushes a new route onto the navigation stack and removes all routes until
  /// the predicate returns true for a route.
  ///
  /// Returns a Future that completes with the result of popping the pushed route.
  Future<T?> pushAndRemoveUntil<T>(Widget page, RoutePredicate predicate) {
    return Navigator.pushAndRemoveUntil(
      this,
      MaterialPageRoute(
        builder: (_) => page,
      ),
      predicate,
    );
  }

  /// Pops the top route from the navigator.
  ///
  /// Returns a Future that completes with the value passed to pop when the route was popped.
  void pop<T>() {
    return Navigator.pop<T>(this);
  }

  /// Pops all routes from the navigator until the predicate returns true for a route.
  ///
  /// Returns a list of the results that were popped at each level.
  void popUntil(RoutePredicate predicate) {
    return Navigator.popUntil(this, predicate);
  }

  /// Navigates to a named route.
  ///
  /// Returns a Future that completes with the result of popping the route.
  Future<T?> pushNamed<T>(String routeName, {Object? arguments}) {
    return Navigator.pushNamed(this, routeName, arguments: arguments);
  }

  /// Replaces the current route with a named route.
  ///
  /// Returns a Future that completes with the result of popping the route.
  Future<T?> pushReplacementNamed<T>(String routeName, {Object? arguments}) {
    return Navigator.pushReplacementNamed(this, routeName,
        arguments: arguments);
  }
}
