class AudioModel {
  int? id;
  String? audioPath;
  String? audioName;

  AudioModel( this.audioName, this.audioPath);


  AudioModel.map(dynamic obj) {
    this.audioPath = obj["audioPath"];
    this.audioName = obj["audioName"];
  }


  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    map["audioPath"] = audioPath;
    map["audioName"] = audioName;

    return map;
  }


}
