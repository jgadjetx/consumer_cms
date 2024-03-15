import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consumer_cms/Cubit/config_cubit/config_cubit.dart';
import 'package:consumer_cms/Models/Configuration.dart';
import 'package:consumer_cms/Widget/LargeButton.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Info extends StatefulWidget {
  const Info({super.key});

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {

  Configuration? configuration;
  ConfigCubit? configCubit;
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  void initState() {
    super.initState();
    configCubit = BlocProvider.of<ConfigCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('settings').doc('configuration').snapshots(),
          builder: (context, snapshot) {

            if (snapshot.hasError) {
              return Text("Error");
            }
            else if (snapshot.connectionState == ConnectionState.waiting) {
              return Container();
            }
            else{

              Map<String, dynamic> data = snapshot.data!.data()! as Map<String, dynamic>;
              configuration = Configuration.fromJson(data);

              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    configuration!.bannerImage!,
                    width: double.infinity,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  configuration!.showManagePackages! ?
                  ManagePackageWidget() : Container(),
                  const Spacer(),
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    child: LargeButton(
                      backgroundColor: Colors.blue,
                      text: "Simulate log event", 
                      onPressed:() async{
                        
                        await FirebaseAnalytics.instance.logEvent(
                          name: "button_simulate_pressed",
                          parameters: {
                            "userID": "demoUser1",
                            "dateTime": DateTime.now().toIso8601String()
                          }
                        );
                      }
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    child: LargeButton(
                        backgroundColor: Colors.red,
                      text: "Simulate error", 
                      onPressed:() {
                        FirebaseCrashlytics.instance.crash();
                      }
                    ),
                  )
                ],
              );

            }
       
          }
        )
      ),
    );
  }

  Widget ManagePackageWidget(){

    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Manage Package"),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.orange),
                height: 100,
                width: 100,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.settings),
                    Text("Change")
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.orange),
                height: 100,
                width: 100,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.info),
                    Text("Cancel")
                  ],
                ),
              )
            ],
          )      
        ],
      )
    );
  }
}