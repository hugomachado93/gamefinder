import 'package:app2/validators/formfieldvalidator.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/subjects.dart';

class EventBloc extends BlocBase with FormFieldValidator {

  final _tituloController = BehaviorSubject<String>();
  final _localController = BehaviorSubject<String>();

  Stream<String> get outTitulo => _tituloController.stream.transform(validateTitulo);
  Stream<String> get outLocal => _localController.stream.transform(validateTitulo);

  Function(String) get changeTitulo => _tituloController.sink.add;
  Function(String) get changeLocal => _localController.sink.add;

  @override
  void dispose() {
    _tituloController.close();
    _localController.close();
  }

}