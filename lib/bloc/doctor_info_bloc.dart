import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:willow/api/api_provider.dart';
import 'package:willow/model/doctor_info_model.dart';

class DoctorInfoBloc {

  final _blocFetcher = BehaviorSubject<DoctorInfoModel>();

  Stream<DoctorInfoModel> get info => _blocFetcher.stream;

  fetch(int id) async {
    try {
    DoctorInfoModel? doctorInfoModel = await apiProvider.getDoctorInfo(id);

      _blocFetcher.sink.add(doctorInfoModel);
    } catch (e) {
      _blocFetcher.sink.addError(e);
      if (kDebugMode) {
        print('error: $e');
      }
    }
  }

  dispose() {
    _blocFetcher.close();
  }
}

final doctorInfoBloc = DoctorInfoBloc();
