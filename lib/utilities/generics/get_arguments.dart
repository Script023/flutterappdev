//create a generic way of extracting arguments from a route
import 'package:flutter/material.dart' show BuildContext, ModalRoute;

extension GetArgument on BuildContext {
  T? getArguement<T>() {
    final modalRoute = ModalRoute.of(this);
    if (modalRoute != null) {
      final args = modalRoute.settings.arguments;
      if (args != null && args is T) {
        return args as T;
      }
    }
    return null;
  }
}
// adds a convinient method to the buildContext
//to read route argumentsin a typed null safe way
// it uses a specificied type so that callers can request a 
// specific type