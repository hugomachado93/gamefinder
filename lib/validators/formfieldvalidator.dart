import 'dart:async';

class FormFieldValidator {

  final validateTitulo = StreamTransformer<String, String>.fromHandlers(
    handleData: (titulo, sink) {
      if(!titulo.isEmpty) {
        sink.add(titulo);
      } else {
        sink.addError("Precisa preencher este campo");
      }
    }
  );

}