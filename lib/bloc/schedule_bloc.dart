import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:willow/api/api_provider.dart';
import 'package:willow/model/schedule_model.dart';

class ScheduleBloc {

  final _blocFetcher = BehaviorSubject<ScheduleModel>();

  Stream<ScheduleModel> get schedule => _blocFetcher.stream;

  fetch() async {
    try {
      ScheduleModel? scheduleModel = await apiProvider.getAppointments();

      _blocFetcher.sink.add(scheduleModel);
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

final scheduleBloc = ScheduleBloc();
