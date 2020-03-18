//import 'package:new_super_doc/model/PatientDataModel.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_app/DurationType.dart';

class AppRelatedData extends ChangeNotifier {
  //OLD URL's
  //final String base_url = 'http://qa.qurix.ai:8080/imedihub_ivrs_test/openapi/';
  //final String base_url = 'http://139.59.17.219:9099/imedihub_ivrs_test/openapi/';

  //PROD
  //final String base_url = 'http://qurix.ai:8080/qurix_uat/openapi/';
  //QA
  final String base_url = 'http://139.59.17.219:9099/imedihubhims/openapi/';

  List<DurationType> durationType = [
    DurationType('Days', '1'),
    DurationType('Weeks', '2'),
    DurationType('Months', '3'),
    DurationType('Years', '4'),
  ];
  Color circleAvatarColor = Color(0xff83AE45);
  Color appColor = Color(0xff6ACCCD);
  Color toastColor = Color(0xff686868);
  //#686868
}
