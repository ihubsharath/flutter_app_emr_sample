class Model {
  List<Emrdata> _emrdata;

  Model({List<Emrdata> emrdata}) {
    this._emrdata = emrdata;
  }

  List<Emrdata> get emrdata => _emrdata;
  set emrdata(List<Emrdata> emrdata) => _emrdata = emrdata;

  Model.fromJson(Map<String, dynamic> json) {
    if (json['emrdata'] != null) {
      _emrdata = new List<Emrdata>();
      json['emrdata'].forEach((v) {
        _emrdata.add(new Emrdata.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._emrdata != null) {
      data['emrdata'] = this._emrdata.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Emrdata {
  List<Symptoms> _symptoms;
  List<Deseases> _deseases;

  Emrdata({List<Symptoms> symptoms, List<Deseases> deseases}) {
    this._symptoms = symptoms;
    this._deseases = deseases;
  }

  List<Symptoms> get symptoms => _symptoms;
  set symptoms(List<Symptoms> symptoms) => _symptoms = symptoms;
  List<Deseases> get deseases => _deseases;
  set deseases(List<Deseases> deseases) => _deseases = deseases;

  Emrdata.fromJson(Map<String, dynamic> json) {
    if (json['symptoms'] != null) {
      _symptoms = new List<Symptoms>();
      json['symptoms'].forEach((v) {
        _symptoms.add(new Symptoms.fromJson(v));
      });
    }
    if (json['deseases'] != null) {
      _deseases = new List<Deseases>();
      json['deseases'].forEach((v) {
        _deseases.add(new Deseases.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._symptoms != null) {
      data['symptoms'] = this._symptoms.map((v) => v.toJson()).toList();
    }
    if (this._deseases != null) {
      data['deseases'] = this._deseases.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Symptoms {
  String _name;
  List<Duration> _duration;
  List<Severity> _severity;
  List<Colorofphlegm> _colorofphlegm;
  List<Fromwhen> _fromwhen;

  Symptoms(
      {String name,
      List<Duration> duration,
      List<Severity> severity,
      List<Colorofphlegm> colorofphlegm,
      List<Fromwhen> fromwhen}) {
    this._name = name;
    this._duration = duration;
    this._severity = severity;
    this._colorofphlegm = colorofphlegm;
    this._fromwhen = fromwhen;
  }

  String get name => _name;
  set name(String name) => _name = name;
  List<Duration> get duration => _duration;
  set duration(List<Duration> duration) => _duration = duration;
  List<Severity> get severity => _severity;
  set severity(List<Severity> severity) => _severity = severity;
  List<Colorofphlegm> get colorofphlegm => _colorofphlegm;
  set colorofphlegm(List<Colorofphlegm> colorofphlegm) =>
      _colorofphlegm = colorofphlegm;
  List<Fromwhen> get fromwhen => _fromwhen;
  set fromwhen(List<Fromwhen> fromwhen) => _fromwhen = fromwhen;

  Symptoms.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
    if (json['duration'] != null) {
      _duration = new List<Duration>();
      json['duration'].forEach((v) {
        _duration.add(new Duration.fromJson(v));
      });
    }
    if (json['severity'] != null) {
      _severity = new List<Severity>();
      json['severity'].forEach((v) {
        _severity.add(new Severity.fromJson(v));
      });
    }
    if (json['colorofphlegm'] != null) {
      _colorofphlegm = new List<Colorofphlegm>();
      json['colorofphlegm'].forEach((v) {
        _colorofphlegm.add(new Colorofphlegm.fromJson(v));
      });
    }
    if (json['fromwhen'] != null) {
      _fromwhen = new List<Fromwhen>();
      json['fromwhen'].forEach((v) {
        _fromwhen.add(new Fromwhen.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this._name;
    if (this._duration != null) {
      data['duration'] = this._duration.map((v) => v.toJson()).toList();
    }
    if (this._severity != null) {
      data['severity'] = this._severity.map((v) => v.toJson()).toList();
    }
    if (this._colorofphlegm != null) {
      data['colorofphlegm'] =
          this._colorofphlegm.map((v) => v.toJson()).toList();
    }
    if (this._fromwhen != null) {
      data['fromwhen'] = this._fromwhen.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Deseases {
  String _name;
  List<Duration> _duration;
  List<Severity> _severity;
  List<Colorofphlegm> _colorofphlegm;
  List<Fromwhen> _fromwhen;

  Symptoms(
      {String name,
      List<Duration> duration,
      List<Severity> severity,
      List<Colorofphlegm> colorofphlegm,
      List<Fromwhen> fromwhen}) {
    this._name = name;
    this._duration = duration;
    this._severity = severity;
    this._colorofphlegm = colorofphlegm;
    this._fromwhen = fromwhen;
  }

  String get name => _name;
  set name(String name) => _name = name;
  List<Duration> get duration => _duration;
  set duration(List<Duration> duration) => _duration = duration;
  List<Severity> get severity => _severity;
  set severity(List<Severity> severity) => _severity = severity;
  List<Colorofphlegm> get colorofphlegm => _colorofphlegm;
  set colorofphlegm(List<Colorofphlegm> colorofphlegm) =>
      _colorofphlegm = colorofphlegm;
  List<Fromwhen> get fromwhen => _fromwhen;
  set fromwhen(List<Fromwhen> fromwhen) => _fromwhen = fromwhen;

  Deseases.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
    if (json['duration'] != null) {
      _duration = new List<Duration>();
      json['duration'].forEach((v) {
        _duration.add(new Duration.fromJson(v));
      });
    }
    if (json['severity'] != null) {
      _severity = new List<Severity>();
      json['severity'].forEach((v) {
        _severity.add(new Severity.fromJson(v));
      });
    }
    if (json['colorofphlegm'] != null) {
      _colorofphlegm = new List<Colorofphlegm>();
      json['colorofphlegm'].forEach((v) {
        _colorofphlegm.add(new Colorofphlegm.fromJson(v));
      });
    }
    if (json['fromwhen'] != null) {
      _fromwhen = new List<Fromwhen>();
      json['fromwhen'].forEach((v) {
        _fromwhen.add(new Fromwhen.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this._name;
    if (this._duration != null) {
      data['duration'] = this._duration.map((v) => v.toJson()).toList();
    }
    if (this._severity != null) {
      data['severity'] = this._severity.map((v) => v.toJson()).toList();
    }
    if (this._colorofphlegm != null) {
      data['colorofphlegm'] =
          this._colorofphlegm.map((v) => v.toJson()).toList();
    }
    if (this._fromwhen != null) {
      data['fromwhen'] = this._fromwhen.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Duration {
  String _days;

  Duration({String days}) {
    this._days = days;
  }

  String get days => _days;
  set days(String days) => _days = days;

  Duration.fromJson(Map<String, dynamic> json) {
    _days = json['days'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['days'] = this._days;
    return data;
  }
}

class Severity {
  String _severityname;

  Severity({String severityname}) {
    this._severityname = severityname;
  }

  String get severityname => _severityname;
  set severityname(String severityname) => _severityname = severityname;

  Severity.fromJson(Map<String, dynamic> json) {
    _severityname = json['severityname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['severityname'] = this._severityname;
    return data;
  }
}

class Colorofphlegm {
  String _colorofphlegmname;

  Colorofphlegm({String colorofphlegmname}) {
    this._colorofphlegmname = colorofphlegmname;
  }

  String get colorofphlegmname => _colorofphlegmname;
  set colorofphlegmname(String colorofphlegmname) =>
      _colorofphlegmname = colorofphlegmname;

  Colorofphlegm.fromJson(Map<String, dynamic> json) {
    _colorofphlegmname = json['colorofphlegmname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['colorofphlegmname'] = this._colorofphlegmname;
    return data;
  }
}

class Fromwhen {
  String _fromwhen;

  Fromwhen({String fromwhen}) {
    this._fromwhen = fromwhen;
  }

  String get fromwhen => _fromwhen;
  set fromwhen(String fromwhen) => _fromwhen = fromwhen;

  Fromwhen.fromJson(Map<String, dynamic> json) {
    _fromwhen = json['fromwhen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fromwhen'] = this._fromwhen;
    return data;
  }
}
