class DataModel {
  static const keyName = "name";
  static const keyShortDes = "shortDes";
  static const keyLongDes = "longDes";
  static const keyImageUrl = "imageUrl";
  static const keyPdfUrl = "PdfUrl";
  static const keyCollectionName = "Notices";
  // static const keyCreateDateTime = "DataTime";
  String imageUrl;
  String name;
  String shortDes;
  String longDes;
  String pdfUrl;
  // DateTime createDateTime;
  DataModel(
      {this.imageUrl, this.name, this.pdfUrl, this.shortDes, this.longDes});
  DataModel.fromJson(json) {
    imageUrl = json[keyImageUrl];
    name = json[keyName];
    pdfUrl = json[keyPdfUrl];
    shortDes = json[keyShortDes];
    longDes = json[keyLongDes];
    // createDateTime = json[keyCreateDateTime];
  }
  Map<String, dynamic> toJson() {
    return {
      keyName: name,
      keyImageUrl: imageUrl,
      keyPdfUrl: pdfUrl,
      keyLongDes: longDes,
      keyShortDes: shortDes
    };
  }
}
