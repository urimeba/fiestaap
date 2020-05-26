import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiestapp/models/user.dart';

class DatabaseService{

  final String uid;
  DatabaseService({this.uid});

  // Collection reference
  // final CollectionReference userCollection = Firestore.instance.collection('users');

  // Future updateUserData(String sugars, String name, int strength) async {
  //   return await brewCollection.document(uid).setData({
  //     'sugars':sugars,
  //     'name':name,
  //     'strength': strength
  //   });
  // }

  // // Brew list from Snapshot
  // List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot){
  //   return snapshot.documents.map((doc){
  //     return Brew(
  //       name: doc.data['name'] ?? '',
  //       strength: doc.data['strength'] ?? 0,
  //       sugars: doc.data['sugars'] ?? '0'
  //     );
  //   }).toList();
  // }

  // // User data from snapshots
  // UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
  //    return UserData(
  //     uid: uid,
  //     name: snapshot.data['name'],
  //     sugars: snapshot.data['sugars'],
  //     strength: snapshot.data['strength']
  //   );
  // }

  // Stream<List<Brew>> get brews {
  //   return brewCollection.snapshots()
  //   .map(_brewListFromSnapshot);
  // }

  // // Get user data doc stream
  // Stream<UserData> get userData{
  //   return brewCollection.document(uid).snapshots()
  //   .map(_userDataFromSnapshot);
  // }
}