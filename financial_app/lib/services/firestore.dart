import 'package:cloud_firestore/cloud_firestore.dart';
class FirestoreService{
  //get collection of notes
  final CollectionReference items=FirebaseFirestore.instance.collection('items');
  //create add new note
  Future<void> addItem(String item,String price){
    return items.add({
      'item':item,
      'price':price,
      'timestamp':Timestamp.now(),
    });
  }
  //read get notes from database
  Stream<QuerySnapshot>getItemsStream(){
    final itemsStream=items.orderBy('timestamp',descending: true).snapshots();
    return itemsStream;
  }
  //update note given doc id
  Future<void> updateItem(String docID,String newItem,String newPrice){
    return items.doc(docID).update({
      'item':newItem,
      'price':newPrice,
      'timestamp':Timestamp.now(),
    });
  }
  //delete note given doc id
  Future<void> deleteItem(String docID){
    return items.doc(docID).delete();
  }
}