import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:financial_app/services/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../model/navbar.dart';
import '../model/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

  class _HomePageState extends State<HomePage> {
    final user=FirebaseAuth.instance.currentUser!;
    String itemcheck=ItemChecker().item;
    String pricecheck=ItemChecker().price;
    //firestore
    final FirestoreService firestoreService = FirestoreService();

    //text controller
    final TextEditingController itemController = TextEditingController();
    final TextEditingController priceController =TextEditingController();

    // open dialog box to add note
    void openItemBox({String? docID}){
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  key: const Key("item"),
                  controller: itemController,
                  decoration: const InputDecoration(labelText: "Item"),
                ),
                TextField(
                  key: const Key("price"),
                  controller: priceController,
                  decoration: const InputDecoration(labelText: "Price"),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                  key: const Key("add"),
                  onPressed: (){
                    //add note
                    if(docID==null){
                      firestoreService.addItem(itemController.text,priceController.text);
                      itemcheck=itemController.text;
                      pricecheck=priceController.text;
                      print(itemcheck+":"+pricecheck);
                    }else{
                      firestoreService.updateItem(docID, itemController.text,priceController.text);
                      itemcheck=itemController.text;
                      pricecheck=priceController.text;
                      print(itemcheck+":"+pricecheck);
                    }
                    //clear controller
                    itemController.clear();
                    priceController.clear();
                    itemcheck="";
                    pricecheck="";
                    //close box
                    Navigator.pop(context);
                  },
                  child: const Text("Add"))
            ],
          )
      );
    }
    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          drawer: NavBar(user),
          appBar: AppBar(
            title: const Text(
                'GALAXY RAY',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            backgroundColor: Colors.blueAccent,
            centerTitle: true,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: openItemBox,
            child: const Icon(Icons.add),
          ),
          body: StreamBuilder<QuerySnapshot>(
            stream: firestoreService.getItemsStream(),
            builder: (context,snapshot){
              if(snapshot.hasData){
                List itemsList=snapshot.data!.docs;
                //display list
                return ListView.builder(
                  itemCount: itemsList.length,
                  itemBuilder: (context,index){
                    //get each individual doc
                    DocumentSnapshot document=itemsList[index];
                    String docID=document.id;
                    //get note from each doc
                    Map<String,dynamic> data = document.data() as Map<String,dynamic>;
                    String itemText=data['item'];
                    String priceText=data['price'];
                    //display list
                    return Container(
                      margin: const EdgeInsets.all(30.0),
                      padding: const EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.blueAccent,
                      ),
                      child: ListTile(
                        title: Column(
                          children: [
                            Text(
                              "Item: "+itemText,
                              style: CustomTextStyle.txtweight,
                            ),
                            Text(
                              "Price: "+priceText+" \$",
                              style: CustomTextStyle.txtweight,
                            ),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () => openItemBox(docID:docID),
                              icon: const Icon(Icons.settings),
                            ),
                            IconButton(
                              onPressed: () => firestoreService.deleteItem(docID),
                              icon: const Icon(Icons.delete),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }else {
                return const Text("No Items");
              }
            },
          ),

        ),
      );

    }
  }
