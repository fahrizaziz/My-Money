import 'dart:convert';

import 'package:d_info/d_info.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mymoney/Model/Shared/api.dart';
import 'package:mymoney/Model/Shared/user_preferences.dart';
import 'package:mymoney/Model/inoutcome_model.dart';

import '../Model/history_model.dart';

class HistoryProviders with ChangeNotifier {
  List<InOutComeModel> _history = [];
  List<InOutComeModel> get history => _history;

  String _resMessage = '';

  String get resMessage => _resMessage;

  Future getInOutCome({
    String? type,
    BuildContext? context,
  }) async {
    final token = await UserPreferences().getToken() ?? '';
    final idUser = await UserPreferences().getIdUser() ?? '';
    var url = Uri.parse(
      '${Api.inoutcome}$idUser/${type!}',
    );
    print(url);
    var headers = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      Response req = await post(
        url,
        headers: headers,
      );
      print(req.statusCode);
      if (req.statusCode == 201) {
        final data = jsonDecode(req.body);
        final HistoryModel history = HistoryModel.fromJson(data);
        _history = history.dataField!;
        // List<InOutComeModel> response = List<InOutComeModel>.from(
        //   data.map(
        //     (e) => HistoryModel.fromJson(e),
        //   ),
        // );
        // _history.addAll(response);
        print(history);
        notifyListeners();
      } else {
        final data = jsonDecode(req.body);
        final HistoryModel inOutCome = HistoryModel.fromJson(data);
        _resMessage = inOutCome.dataMeta!.message!;
        DInfo.dialogError(context!, _resMessage);
        DInfo.closeDialog(context);
        notifyListeners();
      }
    } catch (e) {
      _resMessage = e.toString();
      print(_resMessage);
      DInfo.dialogError(context!, _resMessage);
      DInfo.closeDialog(context);
      notifyListeners();
    }
  }
}
