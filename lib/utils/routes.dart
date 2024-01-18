import 'package:blife_test/ui/pages/profile.dart';
import 'package:blife_test/ui/pages/shopping_cart.dart';
import 'package:flutter/material.dart';

import 'package:blife_test/ui/pages/login_page.dart';

Map<String, WidgetBuilder> getAppRoutes() {
  return <String, WidgetBuilder>{
    login_route: (BuildContext context) => const LoginPage(),
    profile_route: (BuildContext context) => const ProfilePage(),
    shop_cart_route: (BuildContext context) => const ShopCartPage(),
  };
}

const login_route = "login_route";
const profile_route = "profile_route";
const shop_cart_route = "shop_cart_route";