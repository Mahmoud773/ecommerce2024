
import 'package:amazon/consts/lists.dart';
import 'package:amazon/views/settings_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../consts/colors.dart';
import '../doctors/models/doctor_model.dart';
import '../doctors/firestore_Repository/firetore_repository.dart';
import '../res/components/Doctor_Grid_Card.dart';
import 'Doctor_new_Details.dart';

class NewHomeScreen extends StatefulWidget {

  const NewHomeScreen({Key? key}) : super(key: key);

  @override
  State<NewHomeScreen> createState() => _NewHomeScreenState();
}

class _NewHomeScreenState extends State<NewHomeScreen> {
  // final doctorsRepository=DoctorsFirestoreRpository();
  List<DoctorModel> searchedList=[];

  bool isSearching=false;
  bool isSearchingCategories=false;
  int selectedCategoryIndex=0;
  String selectedCategory='';
  String searchedValue="";

  List<DoctorModel> doctorsList=[];
  void getDoctors()  async {
    doctorsList=  await DoctorsFirestoreRpository.getAllDoctors();
  }
  bool isDoctor=false;

  SharedPreferences? prefs;
  void initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    isDoctor=prefs?.getBool("isDoctor") ?? false;
  }
  @override
  void initState() {
    getDoctors();
    super.initState();
    initPrefs();
  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Material(
       color: Colors.white,
       child: SingleChildScrollView(
         child: Stack(
           children: [
             Container(
                 width:width ,
                 height: height/3.5,
                 padding: EdgeInsets.all(20),
                 decoration: BoxDecoration(
                     gradient: LinearGradient(
                       colors: [
                         AppColors.primaryColor.withOpacity(0.8),

                         AppColors.primaryColor,

                       ],
                       begin: Alignment.topCenter,
                       end:Alignment.bottomCenter,
                     ),
                     borderRadius: BorderRadius.only(
                       bottomLeft:Radius.circular(20) ,
                       bottomRight: Radius.circular(20) ,
                     )           )
             ),
             Padding(
               padding: EdgeInsets.only(top: 30) ,
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Padding(
                     padding: EdgeInsets.symmetric(horizontal: 15)
                     ,  child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           CircleAvatar(
                             radius: 30,
                             backgroundImage: AssetImage("assets/images/doctor11.jpg"),
                           ),
                           InkWell(onTap: (){
                             Navigator.push(context,
                                 MaterialPageRoute(builder: (context) {
                                   return SettingsView();
                                 }));
                           },
                               child:
                           Icon(Icons.notifications_outlined, size: 30,color: Colors.white,)),

                         ],
                       ),
                       Text('Hi Name' ,
                         style: TextStyle(
                           fontSize: 18 ,
                           fontWeight: FontWeight.w500,
                           color: Colors.white,

                         ),
                       ),
                       SizedBox(height: 10,),
                       Text('Your Health is our first priority' ,
                         style: TextStyle(
                           fontSize: 25 ,
                           fontWeight: FontWeight.w500,
                           color: Colors.white,

                         ),
                       ),
                       Container(
                         margin: EdgeInsets.only(top: 15 , bottom:20 ),
                         width: width,
                         height: 55,
                         alignment: Alignment.center,
                         decoration: BoxDecoration(
                             color: Colors.white,
                             borderRadius: BorderRadius.circular(10),
                             boxShadow: [
                               BoxShadow(
                                   color: Colors.black12,
                                   blurRadius:6 ,
                                   spreadRadius: 3
                               ),
                             ]
                         ),
                         child: TextFormField(
                           decoration: InputDecoration(
                             border: InputBorder.none ,
                             hintText: "Search doctor name",
                             hintStyle: TextStyle(
                               color: Colors.black.withOpacity(0.5),
                             ),
                             prefixIcon: Icon(Icons.search , size: 25,),

                           ),
                           onChanged: (value) {
                             setState(() {
                               searchedValue = value;
                               isSearching =true;
                             });
                           },
                         ),
                       )
                     ],
                   ),
                   ),

                   isSearching ?
                   StreamBuilder(stream:
                   DoctorsFirestoreRpository.searchDoctors(searchedValue),
                       builder: (context , snapshot) {
                         if(snapshot.connectionState == ConnectionState.waiting){
                           return Center(child: CircularProgressIndicator(),);
                         }
                         if(snapshot.hasData &&  snapshot.data!.docs.isNotEmpty ) {
                           // final doctorsList =snapshot!.data!.docs as List<DoctorModel>;

                           List<DoctorModel> doctorsList=[] ;
                           for(var doc in snapshot.data!.docs){
                             var data = doc.data() ;
                             doctorsList.add(DoctorModel.fromJson(data));

                           }
                           searchedList=doctorsList;
                           return
                             DoctorGridCard(doctorsList:doctorsList);
                         }
                         if(snapshot.hasError){
                           return Center(child: Text("something went wrong"),);
                         }

                         else
                           return Center(child: Text("No Doctors yet"),);
                       })
                       :

                   Column(
                     children: [
                       Padding(padding: EdgeInsets.only(left: 15) ,
                         child: Text('Categories' , style: TextStyle(
                           fontSize: 20 ,
                           fontWeight: FontWeight.w500,
                           color: Colors.black12.withOpacity(0.7),
                         )
                           ,)
                         ,),
                       SizedBox(height: 15,),
                       //categories List

                       Container(
                         height: 100,
                         child: ListView.builder(
                             shrinkWrap: true,
                             scrollDirection: Axis.horizontal,
                             itemCount: CategoriesNamesList.length,
                             itemBuilder: (context , int index) {
                               return InkWell(
                                 onTap:(){
                                   isSearchingCategories=true;
                                   selectedCategoryIndex=index;
                                   selectedCategory=CategoriesNamesList[selectedCategoryIndex];
                                   print(selectedCategory);
                                   setState(() {

                                   });
                                 },
                                 child: Column(
                                   children: [
                                     Container(
                                       margin: EdgeInsets.symmetric(vertical: 5 , horizontal: 15),
                                       height: 60,
                                       width: 60,
                                       decoration: BoxDecoration(
                                           color: Color(0xFFF2F8FF),
                                           shape: BoxShape.circle,
                                           boxShadow: [
                                             BoxShadow(
                                               color: Colors.black12,
                                               blurRadius: 4,
                                               spreadRadius: 2,
                                             )
                                           ]

                                       ),
                                       child: Center(
                                         child: CategoriesIconsList[index],
                                       ),
                                     ),
                                     SizedBox(height: 10,),
                                     Text(CategoriesNamesList[index] ,
                                       style: TextStyle(
                                         fontSize: 16 ,
                                         fontWeight: FontWeight.w500,
                                         color: Colors.black.withOpacity(0.7),

                                       ),
                                     ),
                                   ],
                                 ),
                               );
                             }),
                       ),
                       SizedBox(height: 30,),
                       isSearchingCategories?
                       StreamBuilder(stream:
                       DoctorsFirestoreRpository.searchDoctorCategories(
                           CategoriesNamesList[selectedCategoryIndex],
                           selectedCategoryIndex),
                           builder: (context , snapshot) {
                         print("${CategoriesNamesList[selectedCategoryIndex]}");
                             if(snapshot.connectionState == ConnectionState.waiting){
                               return Center(child: CircularProgressIndicator(),);
                             }
                             if(snapshot.hasData &&  snapshot.data!.docs.isNotEmpty ) {
                               // final doctorsList =snapshot!.data!.docs as List<DoctorModel>;

                               List<DoctorModel> doctorsList=[] ;
                               for(var doc in snapshot.data!.docs){
                                 var data = doc.data() ;
                                 doctorsList.add(DoctorModel.fromJson(data));

                               }
                               searchedList=doctorsList;
                               return
                                 DoctorGridCard(doctorsList:doctorsList);
                             }
                             if(snapshot.hasError){
                               return Center(child: Text("something went wrong"),);
                             }

                             else
                               return Center(child: Text("No Doctors yet"),);
                           }):
                       Column(
                         children: [
                           Padding(padding: EdgeInsets.only(left: 15) ,
                             child:
                             Text('Recommended Doctors' , style: TextStyle(
                               fontSize: 20 ,
                               fontWeight: FontWeight.w500,
                               color: Colors.black.withOpacity(0.7),
                             )
                               ,)
                             ,),
                           // Doctors Section
                           StreamBuilder(stream:
                           DoctorsFirestoreRpository.getDoctorsAsStream()
                               , builder: (context, snapshot){
                                 if(snapshot.connectionState == ConnectionState.waiting){
                                   return Center(child: CircularProgressIndicator(),);
                                 }
                                 if(snapshot.hasData &&  snapshot.data!.docs.isNotEmpty ) {
                                   // final doctorsList =snapshot!.data!.docs as List<DoctorModel>;

                                   List<DoctorModel> doctorsList=[] ;
                                   for(var doc in snapshot.data!.docs){
                                     var data = doc.data() ;
                                     doctorsList.add(DoctorModel.fromJson(data));
                                     // doctorsList.add(DoctorModel(
                                     //   Category: doc.data()!["Category"],
                                     //   id: doc.data()!["id"],
                                     //   email: doc.data()!["email"],
                                     //   appointsDays: doc.data()!["appointsDays"],
                                     //   name: doc.data()!["name"],
                                     //   experience: doc.data()!["experience"],
                                     //   pictureUrl: doc.data()!["pictureUrl"],
                                     //
                                     // ));
                                   }
                                   searchedList=doctorsList;
                                   return
                                     DoctorGridCard(doctorsList:doctorsList);
                                 }
                                 if(snapshot.hasError){
                                   return Center(child: Text("something went wrong"),);
                                 }

                                 else
                                   return Center(child: Text("No Doctors yet"),);
                               }),
                         ],
                       ),
                     ],
                   ),

                   // FutureBuilder<List<DoctorModel>>(
                   //     future: DoctorsFirestoreRpository.getAllDoctors(),
                   //     builder: (context, snapshot){
                   //       if(snapshot.hasData) {
                   //         return
                   //         DoctorGridCard(doctorsList:snapshot.data!);
                   //       } else return Center(child: CircularProgressIndicator(),);
                   //     }
                   // ),



                 ],
               )
               ,),

           ],
         ),
       ),
     );
  }
}
