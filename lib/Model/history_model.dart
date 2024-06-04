import 'package:mymoney/Model/inoutcome_model.dart';
import 'package:mymoney/Model/meta_model.dart';

class HistoryModel {
  Meta? dataMeta;
  List<InOutComeModel>? dataField;

  HistoryModel({
    this.dataMeta,
    this.dataField,
  });

  HistoryModel.fromJson(Map<String, dynamic> json) {
    dataMeta =
        json['metadata'] != null ? Meta.fromJson(json['metadata']) : null;
    if (json['data'] != null) {
      dataField = <InOutComeModel>[];
      json['data'].forEach((v) {
        dataField!.add(InOutComeModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (dataMeta != null) {
      data['metadata'] = dataMeta!.toJson();
    }
    if (dataField != null) {
      data['data'] = dataField!.map((e) => e.toJson()).toList();
    }
    return data;
  }
}
