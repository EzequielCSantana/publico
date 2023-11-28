import 'package:flutter/material.dart';
import '../../functions/nav.dart';
import '../login/login.dart';
import 'package:ionicons/ionicons.dart';
import 'package:url_launcher/url_launcher.dart';


class menuHome extends StatefulWidget {
  const menuHome({Key? key}) : super(key: key);

  @override
  State<menuHome> createState() => _menuHome();
}

class _menuHome extends State<menuHome> {


  @override
  Widget build(BuildContext context) {
    final mQW = MediaQuery.of(context).size.width;
    double szbox = 15;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 40, 20, 30),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(30, 78, 98, 1),
                Color.fromRGBO(46, 150, 143, 1),
              ],
            ),
          ),
          child: Column(
            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Menu",style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold, ),),
                  IconButton(onPressed: (){
                    pop(context);
                  }, icon: Icon(Ionicons.exit,color: Colors.white,)),



                ],
              ),
              const SizedBox(height: 40),

              ListTile(
                onTap: ()async{

                },
                title: Text("Dados",style: TextStyle(color: Colors.white),),
                leading: Icon( Ionicons.card , color: Colors.white,) ,
                trailing: Icon( Icons.arrow_forward , color: Colors.white,) ,
              ),
              Divider(color: Colors.white,),
              ListTile(
                onTap: ()async{

                  final Uri _url = Uri.parse('https://www.targetsistemas.com.br/');
                  await launchUrl(_url);

                },
                title: Text("Política de Privacidade",style: TextStyle(color: Colors.white),),
                leading: Icon( Ionicons.people , color: Colors.white,) ,
                trailing: Icon( Icons.arrow_forward , color: Colors.white,) ,
              ),
              Divider(color: Colors.white,),
              ListTile(
                onTap: ()async{

                },
                title: Text("WhatsApp",style: TextStyle(color: Colors.white),),
                leading: Icon( Ionicons.logo_whatsapp , color: Colors.white,) ,
                trailing: Icon( Icons.arrow_forward , color: Colors.white,) ,
              ),
              Divider(color: Colors.white,),
              ListTile(
                onTap: ()async{
                  final Uri _url = Uri.parse('https://www.biocardsaude.com.br');
                  await launchUrl(_url);

                },
                title: Text("Site",style: TextStyle(color: Colors.white),),
                leading: Icon( Ionicons.logo_chrome , color: Colors.white,) ,
                trailing: Icon( Icons.arrow_forward , color: Colors.white,) ,
              ),
              Divider(color: Colors.white,),
              ListTile(
                onTap: ()async{

                },
                title: Text("Contato",style: TextStyle(color: Colors.white),),
                leading: Icon( Ionicons.list , color: Colors.white,) ,
                trailing: Icon( Icons.arrow_forward , color: Colors.white,) ,
              ),
              Divider(color: Colors.white,),
              ListTile(
                onTap: ()async{

                },
                title: Text("Instagram",style: TextStyle(color: Colors.white),),
                leading: Icon( Ionicons.logo_instagram , color: Colors.white,) ,
                trailing: Icon( Icons.arrow_forward , color: Colors.white,) ,
              ),
              Divider(color: Colors.white,),


              ListTile(
                onTap: ()async{
                  pushReplace(context, login());

                },
                title: Text("Sair",style: TextStyle(color: Colors.white),),
                leading: Icon( Icons.exit_to_app , color: Colors.white,) ,
                trailing: Icon( Icons.arrow_forward , color: Colors.white,) ,
              ),




              //SizedBox(height: szbox),
            ],
          ),
        ),
      ),
    );
  }


}
