import 'meta_model.dart';
import 'user_model.dart';

class AuthModel {
  Meta? dataMeta;
  Data? dataField;

  AuthModel({
    this.dataMeta,
    this.dataField,
  });

  AuthModel.fromJson(Map<String, dynamic> json) {
    dataMeta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    dataField = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (dataMeta != null) {
      data['meta'] = dataMeta!.toJson();
    }
    if (dataField != null) {
      data['data'] = dataField!.toJson();
    }
    return data;
  }
}

class Data {
  String? token, tokenType;
  User? dataUser;

  Data({
    this.token,
    this.tokenType,
    this.dataUser,
  });

  Data.fromJson(Map<String, dynamic> json) {
    token = json['access_token'];
    tokenType = json['token_type'];
    dataUser = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['token_type'] = tokenType;
    if (dataUser != null) {
      data['user'] = dataUser!.toJson();
    }
    return data;
  }
}
