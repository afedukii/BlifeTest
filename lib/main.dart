import 'package:blife_test/ui/pages/login_page.dart';
import 'package:blife_test/utils/colors.dart';
import 'package:blife_test/utils/routes.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(const BlifeTestHome());
}
class BlifeTestHome extends StatelessWidget {
  const BlifeTestHome({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          canvasColor: WhiteColor,
        ),
        home: const LoginPage(),
        routes: getAppRoutes(),
      ),
    );
  }
}
