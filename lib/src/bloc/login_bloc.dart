import 'dart:async';

import 'package:productos_app/src/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validators {

  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();




  // Nota, Con RxDart los StreamController se cambian por BehaviorSubject


  // Recuperar los datos de Stream
  Stream<String> get emailStream => _emailController.stream.transform(validarEmail);
  Stream<String> get passwordStream => _passwordController.stream.transform(validarPassword);

  // rxDart
  // Se pasa el stream despues de transformar (validar)
  Stream<bool> get fromValidStream => 
    CombineLatestStream.combine2(emailStream, passwordStream, (e, p) => true);


  // insertar valores al stream
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;



  // Obtener el ultimo valor ingresado a los stream;

  String get email    => _emailController.value;
  String get password => _passwordController.value;


  void dispose() {
    _emailController?.close();
    _passwordController?.close();
  }

}