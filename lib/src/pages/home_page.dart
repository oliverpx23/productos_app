import 'package:flutter/material.dart';
import 'package:productos_app/src/bloc/provider.dart';
import 'package:productos_app/src/models/producto_model.dart';
import 'package:productos_app/src/providers/productos_provider.dart';

class HomePage extends StatelessWidget {

  //final productosProv = new ProductosProvider();

  @override
  Widget build(BuildContext context) {

    final productosbloc = Provider.productosBloc(context);
    productosbloc.cargarProductos();
    

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: _crearListado(productosbloc),
      floatingActionButton: _crearBoton(context),
    );
  }

  Widget _crearBoton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Colors.deepPurple,
      onPressed: () { Navigator.pushNamed(context, 'producto'); },
    );
  }

  Widget _crearListado(ProductosBloc bloc) {
    return StreamBuilder(
      stream: bloc.productosStream,
      builder: (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot) {
        if(snapshot.hasData) {

          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) => 
              _crearItem(context, snapshot.data[index], bloc),
          );

        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _crearItem(BuildContext context, ProductoModel producto, ProductosBloc bloc) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
        padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
        child: Text('Eliminar item', style: TextStyle(color: Colors.white)),
      ),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        bloc.borrarProducto(producto.id);
      },
      child: Card(
        child: Column(
          children: <Widget>[
            (producto.fotoUrl == null)
            ? Image(image: AssetImage('assets/no-image.png'))
            : FadeInImage(
              placeholder: AssetImage('assets/jar-loading.gif'),
              image: NetworkImage(producto.fotoUrl),
              height: 300.0,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            ListTile(
              title: Text('${producto.titulo} - ${producto.valor}'),
              subtitle: Text(producto.id),
              onTap: () => Navigator.pushNamed(context, 'producto', arguments: producto),
            )
          ],
        ),
      ),
    );


  }
}