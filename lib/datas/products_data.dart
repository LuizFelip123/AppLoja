import 'package:cloud_firestore/cloud_firestore.dart';

class ProductsData{
  String? category;
  String? id;
  String? title;
  String? description;
  double? price;
  List? images;
  List? sizes;
  ProductsData.fromDocument(DocumentSnapshot documentSnapshot){
    id = documentSnapshot.id;
    title = documentSnapshot["title"];
    description = documentSnapshot["description"];
    price =  documentSnapshot["price"];
    images = documentSnapshot["images"];
    sizes = documentSnapshot["sizes"];  

  }

  Map<String, dynamic> toResumedMap(){
    return {
      'title': title,
      'description': description,
      'price': price
    };
  }
}