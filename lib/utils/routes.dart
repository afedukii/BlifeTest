import 'package:flutter/material.dart';

import 'package:blife_test/ui/pages/login_page.dart';

Map<String, WidgetBuilder> getAppRoutes() {
  return <String, WidgetBuilder>{
    login_route: (BuildContext context) => const LoginPage(),
  };
}

const login_route = "login_route";