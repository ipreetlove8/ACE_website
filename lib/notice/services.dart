import 'package:cloud_firestore/cloud_firestore.dart';

import 'model.dart';

class DataServices {
  final FirebaseFirestore _store = FirebaseFirestore.instance;
  CollectionReference _collectionRef;
  DataServices();
  DataServices.table({String tableName}) {
    _collectionRef = _store.collection(tableName);
  }
  Future addNotice(DataModel notice) async {
    try {
      DocumentReference result = await _collectionRef.add(notice.toJson());
      result
          .get()
          .then((value) => print(value.data()))
          .catchError((er) => print(er));
    } catch (e) {
      print("Creation Error $e");
    }
  }

  Future<List<DataModel>> getNotices() async {
    List<DataModel> res = [];
    try {
      QuerySnapshot result = await _collectionRef.get();
      if (result != null) {
        result.docs.forEach((element) {
          print(element.data());
          res.add(DataModel.fromJson(element.data()));
        });
      }
    } catch (e) {
      print(e);
    }
    return res;
  }

  uploadImage() {}

  Future<List<DataModel>> getNewFeed() async {
    List<DataModel> res = [];
    try {
      QuerySnapshot result = await _collectionRef.get();
      if (result != null) {
        result.docs.forEach((element) {
          print(element.data());
          res.add(DataModel.fromJson(element.data()));
        });
      }
    } catch (e) {
      print(e);
    }
    return res;
  }
}
