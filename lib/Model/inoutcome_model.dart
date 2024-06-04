class InOutComeModel {
  int? idHistory, idUser;
  String? type, date, total, details;

  InOutComeModel({
    this.idHistory,
    this.idUser,
    this.type,
    this.date,
    this.total,
    this.details,
  });

  InOutComeModel.fromJson(Map<String, dynamic> json) {
    idHistory = json['id_history'];
    idUser = json['id_user'];
    type = json['type'];
    date = json['date'];
    total = json['total'];
    details = json['details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_history'] = idHistory;
    data['id_user'] = idUser;
    data['type'] = type;
    data['date'] = date;
    data['total'] = total;
    data['details'] = details;
    return data;
  }
}
