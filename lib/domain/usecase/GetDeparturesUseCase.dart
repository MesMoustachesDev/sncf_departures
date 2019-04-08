import 'package:intl/intl.dart';
import 'package:sncf_schedules/data/model/departures/DeparturesResponse.dart';
import 'package:sncf_schedules/data/repo/departures/Departures.dart';
import 'package:sncf_schedules/domain/model/DepartureViewObject.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sncf_schedules/mustachttp/ParsedResponse.dart';

class GetDeparturesUseCase {
  AsObservableFuture<List<DepartureViewObject>> execute() {
    String format = "yyyyMMdd'T'HHmmss";
    String date = DateFormat(format).format(DateTime.now());

    Observable<ParsedResponse<List<Departures>>> observable =
        Observable.fromFuture(DeparturesRepository().getDepartures(
          "stop_area%3AOCE%3ASA%3A87271593",
            date));

    return observable
        .map((response) => response.body)
        .flatMap((list) => Observable.fromIterable(list))
        .map((departure) => DepartureViewObject(departure))
        .toList();
  }
}

//class DeparturesBloc {
//  final DeparturesRepository _repository = DeparturesRepository();
//  final BehaviorSubject<DepartureViewObject> _subject =
//  BehaviorSubject<UserResponse>();
//
//  getUser() async {
//    UserResponse response = await _repository.getUser();
//    _subject.sink.add(response);
//  }
//
//  dispose() {
//    _subject.close();
//  }
//
//  BehaviorSubject<UserResponse> get subject => _subject;
//
//}
//final bloc = UserBloc();
