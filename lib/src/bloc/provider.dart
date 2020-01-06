import 'package:flutter/material.dart';
import 'package:productos_app/src/bloc/login_bloc.dart';
import 'package:productos_app/src/bloc/productos_bloc.dart';
export 'package:productos_app/src/bloc/productos_bloc.dart';
export 'package:productos_app/src/bloc/login_bloc.dart';



class Provider extends InheritedWidget {

  final loginBloc = LoginBloc();
  final _productosBloc = ProductosBloc();

  // patron singleton para no borrar la data entre los hot reload
  static Provider _instancia;


  factory Provider({Key key, Widget child}) {

    if(_instancia == null) {
      _instancia = new Provider._internal(key: key, child: child,);
    }

    return _instancia;

  }


  Provider._internal({Key key, Widget child})
    : super(key: key, child: child);

  
  // Constructor sin patron singleton
  // Provider({Key key, Widget child})
  //   : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static LoginBloc of ( BuildContext context ) {
    return context.dependOnInheritedWidgetOfExactType<Provider>().loginBloc;
  }

  static ProductosBloc productosBloc ( BuildContext context ) {
    return context.dependOnInheritedWidgetOfExactType<Provider>()._productosBloc;
  }





}