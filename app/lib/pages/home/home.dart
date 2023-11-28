import 'package:app/functions/nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ionicons/ionicons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:edge_alerts/edge_alerts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../classes/LoginApp.dart';
import 'homeadd.dart';
import 'menuHome.dart';


class home extends StatefulWidget {
  final LoginApp Login ;
  final List<String>? texto;
  const home({Key? key,required this.Login, required this.texto}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(30, 78, 98, 1),
        title: Text("Target Sistemas",),
      ),
      drawer: menuHome(),
      body:Scrollbar(
        child: homeCorpo(),
      ),
    );
  }

  homeCorpo(){
    Size Mdq= MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color.fromRGBO(30, 78, 98, 1),
              Color.fromRGBO(46, 150, 143, 1),
            ],
          )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          (widget.texto?.length ?? 0) > 0 ? Container(
            width: Mdq.width,
            height: Mdq.height * .4,
            child: ListView.builder(
              itemCount: widget.texto?.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Card(child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Container(width: Mdq.width * .6 ,child: Text( (widget.texto?[index]??""),style: TextStyle(color: Colors.black, fontSize: 20,fontWeight: FontWeight.bold, ) )),
                        IconButton(onPressed: (){
                          pushReplace(context, homeAdd(Login: widget.Login,texto: (widget.texto?[index]??""),));
                        }, icon: Icon(Icons.edit,color: Colors.black,)),
                        IconButton(onPressed: ()async{
                          final SharedPreferences prefs = await SharedPreferences.getInstance();
                          List<String>? texto =await prefs.getStringList('TextoSalvo');
                          var textoSelecionado = (widget.texto?[index]??"");
                          for(int i = 0 ; i <  (texto?.length??0) ; i++){
                            if ( (texto?[i]??"")== textoSelecionado){
                              texto?.removeAt(i);
                              break;
                            }
                          }
                          List<String> vazio = [];
                          await prefs.setStringList("TextoSalvo", (texto??vazio));
                          fcVoltar(context);
                        }, icon: Icon(Icons.delete_forever,color: Colors.red,)),
                      ],
                    ),
                  )),
                );
              },
            ),
          ):SizedBox(),

          SizedBox(height: 10,),
          Center(
            child: Container(
              width: Mdq.width * 0.5,
              height: 40,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color.fromRGBO(68, 189, 110, 1)),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                ),
                onPressed: (){
                  pushReplace(context, homeAdd(Login: widget.Login,texto: "",));
                },
                child: Text("Digite seu texto",style: TextStyle(color: Colors.white, fontSize: 14, ),),
              ),
            ),
          ),
          SizedBox(height: 30,),


          Center(
            child: InkWell(child: Text("Política de Privacidade",style: TextStyle(color: Colors.white, fontSize: 16 ),)
              ,onTap: ()async{

                final Uri _url = Uri.parse('https://www.targetsistemas.com.br/');
                await launchUrl(_url);

              },
            ),
          ),



        ],
      ),
    );


  }

  Future<void> fcVoltar(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? texto =await prefs.getStringList('TextoSalvo');
    print(texto);
    pushReplace(context,home(Login: widget.Login,texto: texto,));
  }


}
