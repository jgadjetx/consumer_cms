import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consumer_cms/Models/Configuration.dart';
import 'package:consumer_cms/Widget/LargeButton.dart';
import 'package:consumer_cms/info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Cubit/config_cubit/config_cubit.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();

}

class _HomeState extends State<Home> {

  Configuration? configuration;
  ConfigCubit? configCubit;

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
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Image.network(configuration!.homeHeadingImage!),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text(
                      configuration!.homeHeadingText!,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    child: LargeButton(
                      text: "Continue", 
                      onPressed:() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Info()),
                        );
                      }
                    ),
                  )
                ],
              );

            }
            
          }
        )
      )  
    );
  }
}