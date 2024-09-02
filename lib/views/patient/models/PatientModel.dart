
class PatientModel{
  final String id;
  final String name;
  final String email;
  final String? pictureUrl;
   String deviceToken;
   bool isDoctor;

  PatientModel( {required this.id,  this.name ="", required this.email, this.pictureUrl ="",
     this.deviceToken ="",this.isDoctor=false});


  factory PatientModel.fromJson(Map<String, dynamic> json) => PatientModel(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      pictureUrl: json["pictureUrl"],
      deviceToken: json["deviceToken"],
      isDoctor: json["isDoctor"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "pictureUrl":pictureUrl,
    "deviceToken":deviceToken,
    "isDoctor":isDoctor
  };
}