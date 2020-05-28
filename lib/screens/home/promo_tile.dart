import 'package:fiestapp/models/promo.dart';
import 'package:flutter/material.dart';

class PromoTile extends StatelessWidget {
  final Promo promo;

  PromoTile({ this.promo });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage('http://fasa.co.za/fasablog/wp-content/uploads/2016/07/Walmart-Logo.jpg'),
            backgroundColor: Colors.transparent,
          ),
          title: Text(promo.descripcion),
          subtitle: Text(
            'de ${promo.fechaInicio} hasta ${promo.fechaVencimiento} en ${promo.tienda} por ${promo.costo}'
            ),
          isThreeLine:  true,
          
        ),
        ),
      );
  }
}