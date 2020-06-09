import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiestapp/models/promo.dart';
import 'package:fiestapp/models/event.dart';

class DatabaseService{

  final String uid;
  DatabaseService({this.uid});

  // Collection reference
  final CollectionReference promosCollection = Firestore.instance.collection('promos');
  // final Query eventsCollection = Firestore.instance.collection('eventos')
  // .where('colabs.$uid.id', isEqualTo: '$uid');

  // Brew list from Snapshot
  List<Promo> _promoListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Promo(
        descripcion: doc.data['descripcion'] ?? 'Sin descripcion',
        fechaInicio: doc.data['fechaInicio'] ?? 'Sin fecha de inicio',
        fechaVencimiento: doc.data['fechaVencimiento'] ?? 'Sin fecha de vencimiento',
        tienda: doc.data['tienda'] ?? 'Tienda desconocida',
        estado: doc.data['estado'] ?? '0',
        costo: doc.data['costo'] ?? '0',
      );
    }).toList();
  }


  // Events list from Snapshot
  List<Event> _eventsListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Event(
        dueno: doc.data['dueno'] ?? 'Sin dueño  ',
        monto: doc.data['monto'] ?? 000000,
        codigo: doc.data['codigo'] ?? 000000,
        nombre: doc.data['nombre'] ?? 'Sin nombre',
        uid: doc.data['uid'] ?? 'Sin UID',
        colabs: doc.data['colabs'] ?? {'id':'Sin colabs'}
      );
    }).toList();
  }

  // Stram of Promos
  Stream<List<Promo>> get promos {
    return promosCollection.snapshots()
    .map(_promoListFromSnapshot);
  }

  // Stream of Events
  Stream<List<Event>> get events {
    return Firestore.instance.collection('eventos')
  .where('colabs.$uid.id', isEqualTo: '$uid').snapshots()
    .map(_eventsListFromSnapshot);
  }
}