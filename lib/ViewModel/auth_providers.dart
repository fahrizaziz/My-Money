import 'dart:async';
import 'dart:convert';

import 'package:d_info/d_info.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mymoney/Model/auth_model.dart';
import 'package:mymoney/Model/Shared/api.dart';
import 'package:mymoney/Model/Utils/assets.dart';
import 'package:mymoney/View/home_screens.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/Shared/user_preferences.dart';
import '../Model/Utils/routes.dart';

class AuthProviders with ChangeNotifier {
  final urlLogin = Api.login;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  String _resMessage = '';

  String get resMessage => _resMessage;

  AuthModel _user = AuthModel();

  AuthModel get user => _user;

  set user(AuthModel user) {
    _user = user;
    notifyListeners();
  }

  Future<bool> logout() async {
    await UserPreferences().clearToken();
    await UserPreferences().clearUserModel();
    await UserPreferences().clearPassword();
    await UserPreferences().clearAuthEmail();
    await UserPreferences().clearIdUser();
    return true;
  }

  Future<bool> checkLogin() async {
    final savedUser = await UserPreferences().getUserModel();
    if (savedUser == null) {
      return false;
    }

    _user = savedUser;
    // AuthModel user = AuthModel();
    // user = savedUser;
    return true;
  }

  Future<AuthModel?> login({
    String? email,
    String? password,
    BuildContext? context,
  }) async {
    _isLoading = true;
    notifyListeners();

    final body = {
      "email": email,
      "password": password,
    };

    final headers = {
      'Content-Type': 'application/json',
    };

    try {
      Response req = await post(
        Uri.parse(
          urlLogin,
        ),
        headers: headers,
        body: jsonEncode(body),
      );

      if (req.statusCode == 201) {
        final res = jsonDecode(req.body);

        AuthModel user = AuthModel.fromJson(res);

        _isLoading = false;
        notifyListeners();

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('data' 'access_token', user.dataField!.token!);
        prefs.setString('data' 'user' 'email', email!);
        prefs.setString('data' 'user' 'password', password!);
        prefs.setString(
            'data' 'user' 'id', user.dataField!.dataUser!.id!.toString() ?? '');

        await UserPreferences().setToken(user.dataField!.token!);
        await UserPreferences().setUserModel(user);
        await UserPreferences().setAuthEmail(email);
        await UserPreferences().setAuthPassword(password);
        await UserPreferences()
            .setIdUser(user.dataField!.dataUser!.id!.toString() ?? '');
        Timer(
            const Duration(
              seconds: 2,
            ), () {
          PageNavigator(ctx: context).nextPageOnly(
            page: const HomeScreens(),
          );
        });
        showDialog(
          context: context!,
          builder: (context) {
            context = context;
            return AnimatedContainer(
              duration: const Duration(),
              curve: Curves.fastLinearToSlowEaseIn,
              child: Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 0,
                backgroundColor: Colors.transparent,
                child: Stack(
                  children: [
                    Center(
                      child: Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              offset: Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Image.asset(
                            AppAsset.logo,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
        return user;
      } else {
        final res = jsonDecode(req.body);
        AuthModel user = AuthModel.fromJson(res);
        _resMessage = user.dataMeta!.message!;
        _isLoading = false;
        DInfo.dialogError(context!, _resMessage);
        DInfo.closeDialog(context);
        notifyListeners();
      }
    } catch (e) {
      _isLoading = false;
      _resMessage = 'Silahkan Coba Kembali';
      DInfo.dialogError(context!, _resMessage);
      DInfo.closeDialog(context);
      notifyListeners();
    }
  }
}
