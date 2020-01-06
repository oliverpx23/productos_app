import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:productos_app/src/config/preferencias_usuario.dart';

class UsuarioProvider {

  final _prefs = new PreferenciasUsuario();

  Future<Map<String, dynamic>> nuevoUsuario(String email, String password) async {

    final String _firebaseToken = 'AIzaSyD1izgFNXnQIC5bYDw5FuyyqEiyaYw8dEo';

    final authData = {
      'email' : email,
      'password' : password,
      'returnSecureToken' : true
    };

    final resp = await http.post(
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseToken',
      body: json.encode(authData)
    );

    Map<String, dynamic> decodedResp = json.decode(resp.body);

    print(decodedResp);

    if(decodedResp.containsKey('idToken')) {
      // TODO: Salvar token en el storage
      //_prefs.token = decodedResp['idToken'];
      return {'ok': true, 'token': decodedResp['idToken']};
    } else {
      return {'ok': false, 'token': decodedResp['error']['message']};
    }

  }


  Future<Map<String, dynamic>> login(String email, String password) async {
    final String _firebaseToken = 'AIzaSyD1izgFNXnQIC5bYDw5FuyyqEiyaYw8dEo';

    final authData = {
      'email' : email,
      'password' : password,
      'returnSecureToken' : true
    };

    final resp = await http.post(
      'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_firebaseToken',
      body: json.encode(authData)
    );

    Map<String, dynamic> decodedResp = json.decode(resp.body);

    print(decodedResp);

    if(decodedResp.containsKey('idToken')) {
      // TODO: Salvar token en el storage
      _prefs.token = decodedResp['idToken'];
      return {'ok': true, 'token': decodedResp['idToken']};
    } else {
      return {'ok': false, 'token': decodedResp['error']['message']};
    }
   
  }


}