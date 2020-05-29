import 'package:fiestapp/models/promo.dart';
import 'package:fiestapp/screens/home/promo_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PromoList extends StatefulWidget {
  @override
  _PromoListState createState() => _PromoListState();
}

class _PromoListState extends State<PromoList> {
  @override
  Widget build(BuildContext context) {
    final promos = Provider.of<List<Promo>>(context) ?? [];

    return ListView.builder(
      itemCount: promos.length,
      itemBuilder: (context, index){
        return PromoTile(promo: promos[index]);
      });
  }
}

