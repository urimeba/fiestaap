import 'package:fiestapp/models/promo.dart';
import 'package:fiestapp/screens/home/promo_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PromoList extends StatefulWidget {
  @override
  _PromoListState createState() => _PromoListState();
}

class _PromoListState extends State<PromoList> {

  Promo promo = Promo(
    descripcion: 'Soporte para celular/tablet',
    costo: '84',
    estado: '28/05',
    fechaInicio: '01/06',
    fechaVencimiento: 'Manaña',
    tienda: 'Walmart'
    );

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   body: Column(
    //     children: <Widget>[
    //       Text('Home'),
    //       PromoTile(promo: promo),
    //       PromoTile(promo: promo),
    //       PromoTile(promo: promo),
    //       PromoTile(promo: promo)

    //     ],
    //   ),
    // );


    final promos = Provider.of<List<Promo>>(context) ?? [];

    return ListView.builder(
      itemCount: promos.length,
      itemBuilder: (context, index){
        return PromoTile(promo: promos[index]);
      });
  }
}

