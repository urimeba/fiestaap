import 'package:fiestapp/models/promo.dart';
import 'promo_list.dart';
import 'package:fiestapp/screens/home/promo_list.dart';
import 'package:fiestapp/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Promociones extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Promo>>.value(
        value: DatabaseService().promos,
          child: Scaffold(
            backgroundColor: Colors.brown[50],
            body: Container(
              child: PromoList()
              ),
          ),
    );
  }
}