class Model2 {
  List<Result> _result;

  Model2({List<Result> result}) {
    this._result = result;
  }

  List<Result> get result => _result;
  set result(List<Result> result) => _result = result;

  Model2.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      _result = new List<Result>();
      json['result'].forEach((v) {
        _result.add(new Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._result != null) {
      data['result'] = this._result.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  int _id;
  String _uuid;
  String _name;
  Null _timeZone;
  Null _addressDtos;
  Null _contractPointDtos;

  Result(
      {int id,
      String uuid,
      String name,
      Null timeZone,
      Null addressDtos,
      Null contractPointDtos}) {
    this._id = id;
    this._uuid = uuid;
    this._name = name;
    this._timeZone = timeZone;
    this._addressDtos = addressDtos;
    this._contractPointDtos = contractPointDtos;
  }

  int get id => _id;
  set id(int id) => _id = id;
  String get uuid => _uuid;
  set uuid(String uuid) => _uuid = uuid;
  String get name => _name;
  set name(String name) => _name = name;
  Null get timeZone => _timeZone;
  set timeZone(Null timeZone) => _timeZone = timeZone;
  Null get addressDtos => _addressDtos;
  set addressDtos(Null addressDtos) => _addressDtos = addressDtos;
  Null get contractPointDtos => _contractPointDtos;
  set contractPointDtos(Null contractPointDtos) =>
      _contractPointDtos = contractPointDtos;

  Result.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _uuid = json['uuid'];
    _name = json['name'];
    _timeZone = json['timeZone'];
    _addressDtos = json['addressDtos'];
    _contractPointDtos = json['contractPointDtos'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['uuid'] = this._uuid;
    data['name'] = this._name;
    data['timeZone'] = this._timeZone;
    data['addressDtos'] = this._addressDtos;
    data['contractPointDtos'] = this._contractPointDtos;
    return data;
  }
}
