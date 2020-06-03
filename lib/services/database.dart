import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/models/food.dart';
import 'package:firebase/models/user.dart';



class DatabaseService{
  final String uid;
  DatabaseService({this.uid});
  final CollectionReference foodCollection = Firestore.instance.collection('foods');
  Future updateUserData(String dishs,String name ) async {
    return await foodCollection.document(uid).setData({
      'dishs':dishs,
      'name': name,
      
    });
  }

//
List<Ice> _iceListFromSnapshot(QuerySnapshot snapshot){
  return snapshot.documents.map((doc){
      return Ice(
        name:doc.data['name'] ?? '',
       
        dishs:doc.data['dishs'] ?? '0',


      );
  }).toList();

}
//userdata from snapshot
UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
  return UserData(
    uid:uid,
    name:snapshot.data['name'],
    dishs:snapshot.data['falvors'],
    
  );
}


  //get food stream

  Stream<List<Ice>> get foods {
    return foodCollection.snapshots()
    .map(_iceListFromSnapshot);
  }

  Stream<UserData> get userData {
      return foodCollection.document(uid).snapshots()
      .map(_userDataFromSnapshot);  
  }


}