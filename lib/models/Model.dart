class Model {
  List<Appointments> _appointments;

  Model({List<Appointments> appointments}) {
    this._appointments = appointments;
  }

  List<Appointments> get appointments => _appointments;
  set appointments(List<Appointments> appointments) =>
      _appointments = appointments;

  Model.fromJson(Map<String, dynamic> json) {
    if (json['appointments'] != null) {
      _appointments = new List<Appointments>();
      json['appointments'].forEach((v) {
        _appointments.add(new Appointments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._appointments != null) {
      data['appointments'] = this._appointments.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Appointments {
  String _identifierId;
  String _apptId;
  String _patientId;
  String _patientName;
  String _mobileNo;
  int _procedureId;
  String _locationId;
  String _procedureName;
  String _doctorId;
  String _doctorName;
  String _appointmentTime;
  String _checkInTime;
  String _inTime;
  String _checkOutTime;
  String _cancelTime;
  String _noShowTime;
  Null _apptWaitingTime;
  String _scheduledTime;
  int _apptStatus;
  String _apptStatusName;
  int _deptId;
  String _deptName;
  int _sessionId;
  bool _emergency;
  bool _firstTimeUser;
  int _channelId;
  String _channelType;
  int _slotId;
  String _visitStateCode;
  String _docImage;
  Null _uhid;
  int _entityId;
  String _entityName;
  String _qualifications;
  String _doctorPhoneNo;
  String _locationName;
  int _procedureFee;
  String _organizationName;
  Null _email;
  String _shortUrl;
  String _slotType;
  String _apptmntDate;
  bool _walkin;
  bool _recheckIn;
  bool _rescheduled;

  Appointments(
      {String identifierId,
      String apptId,
      String patientId,
      String patientName,
      String mobileNo,
      int procedureId,
      String locationId,
      String procedureName,
      String doctorId,
      String doctorName,
      String appointmentTime,
      String checkInTime,
      String inTime,
      String checkOutTime,
      String cancelTime,
      String noShowTime,
      Null apptWaitingTime,
      String scheduledTime,
      int apptStatus,
      String apptStatusName,
      int deptId,
      String deptName,
      int sessionId,
      bool emergency,
      bool firstTimeUser,
      int channelId,
      String channelType,
      int slotId,
      String visitStateCode,
      String docImage,
      Null uhid,
      int entityId,
      String entityName,
      String qualifications,
      String doctorPhoneNo,
      String locationName,
      int procedureFee,
      String organizationName,
      Null email,
      String shortUrl,
      String slotType,
      String apptmntDate,
      bool walkin,
      bool recheckIn,
      bool rescheduled}) {
    this._identifierId = identifierId;
    this._apptId = apptId;
    this._patientId = patientId;
    this._patientName = patientName;
    this._mobileNo = mobileNo;
    this._procedureId = procedureId;
    this._locationId = locationId;
    this._procedureName = procedureName;
    this._doctorId = doctorId;
    this._doctorName = doctorName;
    this._appointmentTime = appointmentTime;
    this._checkInTime = checkInTime;
    this._inTime = inTime;
    this._checkOutTime = checkOutTime;
    this._cancelTime = cancelTime;
    this._noShowTime = noShowTime;
    this._apptWaitingTime = apptWaitingTime;
    this._scheduledTime = scheduledTime;
    this._apptStatus = apptStatus;
    this._apptStatusName = apptStatusName;
    this._deptId = deptId;
    this._deptName = deptName;
    this._sessionId = sessionId;
    this._emergency = emergency;
    this._firstTimeUser = firstTimeUser;
    this._channelId = channelId;
    this._channelType = channelType;
    this._slotId = slotId;
    this._visitStateCode = visitStateCode;
    this._docImage = docImage;
    this._uhid = uhid;
    this._entityId = entityId;
    this._entityName = entityName;
    this._qualifications = qualifications;
    this._doctorPhoneNo = doctorPhoneNo;
    this._locationName = locationName;
    this._procedureFee = procedureFee;
    this._organizationName = organizationName;
    this._email = email;
    this._shortUrl = shortUrl;
    this._slotType = slotType;
    this._apptmntDate = apptmntDate;
    this._walkin = walkin;
    this._recheckIn = recheckIn;
    this._rescheduled = rescheduled;
  }

  String get identifierId => _identifierId;
  set identifierId(String identifierId) => _identifierId = identifierId;
  String get apptId => _apptId;
  set apptId(String apptId) => _apptId = apptId;
  String get patientId => _patientId;
  set patientId(String patientId) => _patientId = patientId;
  String get patientName => _patientName;
  set patientName(String patientName) => _patientName = patientName;
  String get mobileNo => _mobileNo;
  set mobileNo(String mobileNo) => _mobileNo = mobileNo;
  int get procedureId => _procedureId;
  set procedureId(int procedureId) => _procedureId = procedureId;
  String get locationId => _locationId;
  set locationId(String locationId) => _locationId = locationId;
  String get procedureName => _procedureName;
  set procedureName(String procedureName) => _procedureName = procedureName;
  String get doctorId => _doctorId;
  set doctorId(String doctorId) => _doctorId = doctorId;
  String get doctorName => _doctorName;
  set doctorName(String doctorName) => _doctorName = doctorName;
  String get appointmentTime => _appointmentTime;
  set appointmentTime(String appointmentTime) =>
      _appointmentTime = appointmentTime;
  String get checkInTime => _checkInTime;
  set checkInTime(String checkInTime) => _checkInTime = checkInTime;
  String get inTime => _inTime;
  set inTime(String inTime) => _inTime = inTime;
  String get checkOutTime => _checkOutTime;
  set checkOutTime(String checkOutTime) => _checkOutTime = checkOutTime;
  String get cancelTime => _cancelTime;
  set cancelTime(String cancelTime) => _cancelTime = cancelTime;
  String get noShowTime => _noShowTime;
  set noShowTime(String noShowTime) => _noShowTime = noShowTime;
  Null get apptWaitingTime => _apptWaitingTime;
  set apptWaitingTime(Null apptWaitingTime) =>
      _apptWaitingTime = apptWaitingTime;
  String get scheduledTime => _scheduledTime;
  set scheduledTime(String scheduledTime) => _scheduledTime = scheduledTime;
  int get apptStatus => _apptStatus;
  set apptStatus(int apptStatus) => _apptStatus = apptStatus;
  String get apptStatusName => _apptStatusName;
  set apptStatusName(String apptStatusName) => _apptStatusName = apptStatusName;
  int get deptId => _deptId;
  set deptId(int deptId) => _deptId = deptId;
  String get deptName => _deptName;
  set deptName(String deptName) => _deptName = deptName;
  int get sessionId => _sessionId;
  set sessionId(int sessionId) => _sessionId = sessionId;
  bool get emergency => _emergency;
  set emergency(bool emergency) => _emergency = emergency;
  bool get firstTimeUser => _firstTimeUser;
  set firstTimeUser(bool firstTimeUser) => _firstTimeUser = firstTimeUser;
  int get channelId => _channelId;
  set channelId(int channelId) => _channelId = channelId;
  String get channelType => _channelType;
  set channelType(String channelType) => _channelType = channelType;
  int get slotId => _slotId;
  set slotId(int slotId) => _slotId = slotId;
  String get visitStateCode => _visitStateCode;
  set visitStateCode(String visitStateCode) => _visitStateCode = visitStateCode;
  String get docImage => _docImage;
  set docImage(String docImage) => _docImage = docImage;
  Null get uhid => _uhid;
  set uhid(Null uhid) => _uhid = uhid;
  int get entityId => _entityId;
  set entityId(int entityId) => _entityId = entityId;
  String get entityName => _entityName;
  set entityName(String entityName) => _entityName = entityName;
  String get qualifications => _qualifications;
  set qualifications(String qualifications) => _qualifications = qualifications;
  String get doctorPhoneNo => _doctorPhoneNo;
  set doctorPhoneNo(String doctorPhoneNo) => _doctorPhoneNo = doctorPhoneNo;
  String get locationName => _locationName;
  set locationName(String locationName) => _locationName = locationName;
  int get procedureFee => _procedureFee;
  set procedureFee(int procedureFee) => _procedureFee = procedureFee;
  String get organizationName => _organizationName;
  set organizationName(String organizationName) =>
      _organizationName = organizationName;
  Null get email => _email;
  set email(Null email) => _email = email;
  String get shortUrl => _shortUrl;
  set shortUrl(String shortUrl) => _shortUrl = shortUrl;
  String get slotType => _slotType;
  set slotType(String slotType) => _slotType = slotType;
  String get apptmntDate => _apptmntDate;
  set apptmntDate(String apptmntDate) => _apptmntDate = apptmntDate;
  bool get walkin => _walkin;
  set walkin(bool walkin) => _walkin = walkin;
  bool get recheckIn => _recheckIn;
  set recheckIn(bool recheckIn) => _recheckIn = recheckIn;
  bool get rescheduled => _rescheduled;
  set rescheduled(bool rescheduled) => _rescheduled = rescheduled;

  Appointments.fromJson(Map<String, dynamic> json) {
    _identifierId = json['identifierId'];
    _apptId = json['apptId'];
    _patientId = json['patientId'];
    _patientName = json['patientName'];
    _mobileNo = json['mobileNo'];
    _procedureId = json['procedureId'];
    _locationId = json['locationId'];
    _procedureName = json['procedureName'];
    _doctorId = json['doctorId'];
    _doctorName = json['doctorName'];
    _appointmentTime = json['appointmentTime'];
    _checkInTime = json['checkInTime'];
    _inTime = json['inTime'];
    _checkOutTime = json['checkOutTime'];
    _cancelTime = json['cancelTime'];
    _noShowTime = json['noShowTime'];
    _apptWaitingTime = json['apptWaitingTime'];
    _scheduledTime = json['scheduledTime'];
    _apptStatus = json['apptStatus'];
    _apptStatusName = json['apptStatusName'];
    _deptId = json['deptId'];
    _deptName = json['deptName'];
    _sessionId = json['sessionId'];
    _emergency = json['emergency'];
    _firstTimeUser = json['firstTimeUser'];
    _channelId = json['channelId'];
    _channelType = json['channelType'];
    _slotId = json['slotId'];
    _visitStateCode = json['visitStateCode'];
    _docImage = json['docImage'];
    _uhid = json['uhid'];
    _entityId = json['entityId'];
    _entityName = json['entityName'];
    _qualifications = json['qualifications'];
    _doctorPhoneNo = json['doctorPhoneNo'];
    _locationName = json['locationName'];
    _procedureFee = json['procedureFee'];
    _organizationName = json['organizationName'];
    _email = json['email'];
    _shortUrl = json['shortUrl'];
    _slotType = json['slotType'];
    _apptmntDate = json['apptmntDate'];
    _walkin = json['walkin'];
    _recheckIn = json['recheckIn'];
    _rescheduled = json['rescheduled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['identifierId'] = this._identifierId;
    data['apptId'] = this._apptId;
    data['patientId'] = this._patientId;
    data['patientName'] = this._patientName;
    data['mobileNo'] = this._mobileNo;
    data['procedureId'] = this._procedureId;
    data['locationId'] = this._locationId;
    data['procedureName'] = this._procedureName;
    data['doctorId'] = this._doctorId;
    data['doctorName'] = this._doctorName;
    data['appointmentTime'] = this._appointmentTime;
    data['checkInTime'] = this._checkInTime;
    data['inTime'] = this._inTime;
    data['checkOutTime'] = this._checkOutTime;
    data['cancelTime'] = this._cancelTime;
    data['noShowTime'] = this._noShowTime;
    data['apptWaitingTime'] = this._apptWaitingTime;
    data['scheduledTime'] = this._scheduledTime;
    data['apptStatus'] = this._apptStatus;
    data['apptStatusName'] = this._apptStatusName;
    data['deptId'] = this._deptId;
    data['deptName'] = this._deptName;
    data['sessionId'] = this._sessionId;
    data['emergency'] = this._emergency;
    data['firstTimeUser'] = this._firstTimeUser;
    data['channelId'] = this._channelId;
    data['channelType'] = this._channelType;
    data['slotId'] = this._slotId;
    data['visitStateCode'] = this._visitStateCode;
    data['docImage'] = this._docImage;
    data['uhid'] = this._uhid;
    data['entityId'] = this._entityId;
    data['entityName'] = this._entityName;
    data['qualifications'] = this._qualifications;
    data['doctorPhoneNo'] = this._doctorPhoneNo;
    data['locationName'] = this._locationName;
    data['procedureFee'] = this._procedureFee;
    data['organizationName'] = this._organizationName;
    data['email'] = this._email;
    data['shortUrl'] = this._shortUrl;
    data['slotType'] = this._slotType;
    data['apptmntDate'] = this._apptmntDate;
    data['walkin'] = this._walkin;
    data['recheckIn'] = this._recheckIn;
    data['rescheduled'] = this._rescheduled;
    return data;
  }
}

//class Model {
//  List<Symptoms> _symptoms;
//
//  Model({List<Symptoms> symptoms}) {
//    this._symptoms = symptoms;
//  }
//
//  List<Symptoms> get symptoms => _symptoms;
//  set symptoms(List<Symptoms> symptoms) => _symptoms = symptoms;
//
//  Model.fromJson(Map<String, dynamic> json) {
//    if (json['symptoms'] != null) {
//      _symptoms = new List<Symptoms>();
//      json['symptoms'].forEach((v) {
//        _symptoms.add(new Symptoms.fromJson(v));
//      });
//    }
//  }
//
//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    if (this._symptoms != null) {
//      data['symptoms'] = this._symptoms.map((v) => v.toJson()).toList();
//    }
//    return data;
//  }
//}
//
//class Symptoms {
//  String _name;
//  List<Durationn> _durationn;
//  List<Severity> _severity;
//  List<Colorofphlegm> _colorofphlegm;
//  List<Fromwhen> _fromwhen;
//
//  Symptoms(
//      {String name,
//      List<Durationn> durationn,
//      List<Severity> severity,
//      List<Colorofphlegm> colorofphlegm,
//      List<Fromwhen> fromwhen}) {
//    this._name = name;
//    this._durationn = durationn;
//    this._severity = severity;
//    this._colorofphlegm = colorofphlegm;
//    this._fromwhen = fromwhen;
//  }
//
//  String get name => _name;
//  set name(String name) => _name = name;
//  List<Durationn> get durationn => _durationn;
//  set durationn(List<Durationn> durationn) => _durationn = durationn;
//  List<Severity> get severity => _severity;
//  set severity(List<Severity> severity) => _severity = severity;
//  List<Colorofphlegm> get colorofphlegm => _colorofphlegm;
//  set colorofphlegm(List<Colorofphlegm> colorofphlegm) =>
//      _colorofphlegm = colorofphlegm;
//  List<Fromwhen> get fromwhen => _fromwhen;
//  set fromwhen(List<Fromwhen> fromwhen) => _fromwhen = fromwhen;
//
//  Symptoms.fromJson(Map<String, dynamic> json) {
//    _name = json['name'];
//    if (json['durationn'] != null) {
//      _durationn = new List<Durationn>();
//      json['durationn'].forEach((v) {
//        _durationn.add(new Durationn.fromJson(v));
//      });
//    }
//    if (json['severity'] != null) {
//      _severity = new List<Severity>();
//      json['severity'].forEach((v) {
//        _severity.add(new Severity.fromJson(v));
//      });
//    }
//    if (json['colorofphlegm'] != null) {
//      _colorofphlegm = new List<Colorofphlegm>();
//      json['colorofphlegm'].forEach((v) {
//        _colorofphlegm.add(new Colorofphlegm.fromJson(v));
//      });
//    }
//    if (json['fromwhen'] != null) {
//      _fromwhen = new List<Fromwhen>();
//      json['fromwhen'].forEach((v) {
//        _fromwhen.add(new Fromwhen.fromJson(v));
//      });
//    }
//  }
//
//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    data['name'] = this._name;
//    if (this._durationn != null) {
//      data['durationn'] = this._durationn.map((v) => v.toJson()).toList();
//    }
//    if (this._severity != null) {
//      data['severity'] = this._severity.map((v) => v.toJson()).toList();
//    }
//    if (this._colorofphlegm != null) {
//      data['colorofphlegm'] =
//          this._colorofphlegm.map((v) => v.toJson()).toList();
//    }
//    if (this._fromwhen != null) {
//      data['fromwhen'] = this._fromwhen.map((v) => v.toJson()).toList();
//    }
//    return data;
//  }
//}
//
//class Durationn {
//  String _days;
//
//  Durationn({String days}) {
//    this._days = days;
//  }
//
//  String get days => _days;
//  set days(String days) => _days = days;
//
//  Durationn.fromJson(Map<String, dynamic> json) {
//    _days = json['days'];
//  }
//
//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    data['days'] = this._days;
//    return data;
//  }
//}
//
//class Severity {
//  String _severityname;
//
//  Severity({String severityname}) {
//    this._severityname = severityname;
//  }
//
//  String get severityname => _severityname;
//  set severityname(String severityname) => _severityname = severityname;
//
//  Severity.fromJson(Map<String, dynamic> json) {
//    _severityname = json['severityname'];
//  }
//
//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    data['severityname'] = this._severityname;
//    return data;
//  }
//}
//
//class Colorofphlegm {
//  String _colorofphlegmname;
//
//  Colorofphlegm({String colorofphlegmname}) {
//    this._colorofphlegmname = colorofphlegmname;
//  }
//
//  String get colorofphlegmname => _colorofphlegmname;
//  set colorofphlegmname(String colorofphlegmname) =>
//      _colorofphlegmname = colorofphlegmname;
//
//  Colorofphlegm.fromJson(Map<String, dynamic> json) {
//    _colorofphlegmname = json['colorofphlegmname'];
//  }
//
//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    data['colorofphlegmname'] = this._colorofphlegmname;
//    return data;
//  }
//}
//
//class Fromwhen {
//  String _fromwhen;
//
//  Fromwhen({String fromwhen}) {
//    this._fromwhen = fromwhen;
//  }
//
//  String get fromwhen => _fromwhen;
//  set fromwhen(String fromwhen) => _fromwhen = fromwhen;
//
//  Fromwhen.fromJson(Map<String, dynamic> json) {
//    _fromwhen = json['fromwhen'];
//  }
//
//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    data['fromwhen'] = this._fromwhen;
//    return data;
//  }
//}
