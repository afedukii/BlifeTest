import 'package:blife_test/APInServices/RandomUser/RandomUser.dart';
import 'package:blife_test/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:blife_test/models/user.dart';
import 'package:blife_test/ui/components/MainButton.dart';
import 'package:blife_test/ui/components/TextInputForm.dart';
import 'package:blife_test/ui/components/TextTitle.dart';
import 'package:blife_test/ui/components/ToastAlert.dart';
import 'package:blife_test/utils/Strings/Alerts.dart';
import 'package:blife_test/utils/Strings/Buttons.dart';
import 'package:blife_test/utils/Strings/LocalKeys.dart';
import 'package:blife_test/utils/Strings/TextInputs.dart';
import 'package:blife_test/utils/Strings/Titles.dart';
import 'package:blife_test/utils/colors.dart';
import 'package:blife_test/utils/navigator.dart';
import 'package:blife_test/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  User user = User();
  RandomUser temp_user = RandomUser();
  SharedPreferencesHelper shadPrefs = SharedPreferencesHelper();

  final _unameCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  @override
  void initState() {
    _getTempUser();
    super.initState();
  }

  @override
  Widget build(context){
    return Material(
      child: SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(10),
              alignment: Alignment.bottomLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: user.username));
                      ToastAlert().showToastAlert(ClipboardAlert, true);
                    },
                    child: TextTitle(title: user.username, fontSize: 14.0, fontWeight: FontWeight.w400),
                  ),
                  GestureDetector(
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: user.password));
                      ToastAlert().showToastAlert(ClipboardAlert, true);
                    },
                    child: TextTitle(title: user.password, fontSize: 14.0, fontWeight: FontWeight.w400),
                  )
                ],
              )
            ),
          ),
          Flexible(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const TextTitle(title: AppNameTitle,color: DeepPurpleColor, fontSize: 25.0, fontWeight: FontWeight.bold),
                TextInputForm(controller: _unameCtrl, inputType: TextInputType.emailAddress, hintText: UnameInputText,),
                TextInputForm(controller: _passCtrl, inputType: TextInputType.visiblePassword, hintText: PassInputText,),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: MainButton(
              text: const TextTitle(title: SignInLabel, fontSize: 20.0, fontWeight: FontWeight.bold, color: WhiteColor,),
              onTap: _validateCred,
              width: 200,
              height: 60,
              bg: DeepPurpleColor,
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(),
          ),
        ],
      ),
      ),
    );
  }

  Future<void> _getTempUser() async {
    shadPrefs.SharedPrefsInit();
    await temp_user.genRandomUser();
    setState(() {
      user.name = temp_user.name;
      user.username = temp_user.username;
      user.password = temp_user.password;
      user.phone = temp_user.phone;
    });
  }

  void _validateCred() async {
    if(_unameCtrl.text.isEmpty || _passCtrl.text.isEmpty){
      //toast err: empty fieds
      ToastAlert().showToastAlert(EmptyFieldsErr,false);
    }else{
      if(_unameCtrl.text == user.username && _passCtrl.text == user.password){
        //toast user founded
        ToastAlert().showToastAlert(UserFoundAlert,true);
        //save data on local storage
        shadPrefs.saveData(LocalNameKey, user.name);
        shadPrefs.saveData(LocalUsernameKey, user.username);
        shadPrefs.saveData(LocalPasswordKey, user.password);
        shadPrefs.saveData(LocalPhoneKey, user.phone);
        //change to profile screen
        nextScreen(context,profile_route);
      }else{
        //toast wrong data
        ToastAlert().showToastAlert(UserNotFoundErr,false);
      }
    }
  }
}