import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiestapp/models/promo.dart';
import 'package:fiestapp/models/event.dart';

class DatabaseService{

  final String uid;
  DatabaseService({this.uid});

  // Collection reference
  final CollectionReference promosCollection = Firestore.instance.collection('promos');
  final CollectionReference eventsCollection = Firestore.instance.collection('eventos');

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


  // Events list from Snapshot
  List<Event> _eventsListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Event(
        dueno: doc.data['dueno'] ?? 'Dueño',
        monto: doc.data['monto'] ?? 'Monto',
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
    return eventsCollection.snapshots()
    .map(_eventsListFromSnapshot);
  }
}