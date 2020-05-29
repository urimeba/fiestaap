import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiestapp/models/promo.dart';

class DatabaseService{

  final String uid;
  DatabaseService({this.uid});

  // Collection reference
  final CollectionReference promosCollection = Firestore.instance.collection('promos');

  

  // Brew list from Snapshot
  List<Promo> _promoListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Promo(
        descripcion: doc.data['descripcion'] ?? '',
        fechaInicio: doc.data['fechaInicio'] ?? 'Sin definir',
        fechaVencimiento: doc.data['fechaVencimiento'] ?? 'Sin definir',
        tienda: doc.data['tienda'] ?? 'tienda desconocida',
        estado: doc.data['estado'] ?? '0',
        costo: doc.data['costo'] ?? '0',
      );
    }).toList();
  }

   Stream<List<Promo>> get promos {
    return promosCollection.snapshots()
    .map(_promoListFromSnapshot);
  }
}