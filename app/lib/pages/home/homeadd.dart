import 'package:app/functions/nav.dart';
import 'package:app/pages/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ionicons/ionicons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:edge_alerts/edge_alerts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../classes/LoginApp.dart';



class homeAdd extends StatefulWidget {
  final LoginApp Login ;
  final String texto;
  const homeAdd({Key? key,required this.Login, required this.texto}) : super(key: key);

  @override
  State<homeAdd> createState() => _homeAddState();
}

class _homeAddState extends State<homeAdd> {
  @override

  final txTextoDigitado = TextEditingController(text: "");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    txTextoDigitado.text = widget.texto;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          //icone 01
          IconButton(
              icon: Icon(Icons.close,color: Colors.white,),
              onPressed: () async{
                await fcVoltar(context);
              })

        ],
        backgroundColor: Color.fromRGBO(30, 78, 98, 1),
        title: Text("Target Sistemas",),
      ),

      body:Scrollbar(
        child: homeAddCorpo(),
      ),
    );
  }

  Future<void> fcVoltar(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? texto =await prefs.getStringList('TextoSalvo');
    print(texto);
    pushReplace(context,home(Login: widget.Login,texto: texto,));
  }

  homeAddCorpo(){
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          SizedBox(height: 20,),
          Text("Digite Seu Texto",style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold, ),),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              style: TextStyle(backgroundColor: Colors.white),
              keyboardType: TextInputType.text,
              controller: txTextoDigitado,
              maxLength: 100,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.text_fields,color: Colors.black,),
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderSide:
                  BorderSide(width: 1, color: Colors.white), //<-- SEE HERE
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),

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
                onPressed: ()async{
                  if (txTextoDigitado.text==""){
                    edgeAlert(
                        context,
                        title: 'Informação!',
                        description: 'Informe o texto.',
                        gravity: Gravity.top,
                        duration: 3,
                        backgroundColor: Colors.redAccent,
                        icon: Icons.person
                    );
                    return;
                  }
                  //
                  final SharedPreferences prefs = await SharedPreferences.getInstance();
                  List<String>? texto =await prefs.getStringList('TextoSalvo');
                  if ( (texto?.length??0) > 0 ){
                    bool existe=false;
                    for(int i = 0 ; i <  (texto?.length??0) ; i++){
                      if ( (texto?[i]??"")== txTextoDigitado.text){
                        existe=true;
                        break;
                      }
                    }
                    if ( existe==true){
                      edgeAlert(
                          context,
                          title: 'Informação',
                          description: 'Texto já cadastrado!',
                          gravity: Gravity.top,
                          backgroundColor: Colors.red,
                          icon: Icons.text_fields,
                          duration: 2
                      );
                      return;
                    }
                  }
                  //salvar texto
                  if ( widget.texto!=""){
                    for(int i = 0 ; i <  (texto?.length??0) ; i++){
                      if ( (texto?[i]??"")== widget.texto){
                        texto?.removeAt(i);
                        break;
                      }
                    }
                  }
                  //
                  texto?.add(txTextoDigitado.text);
                  List<String> vazio = [txTextoDigitado.text];
                  print((texto??vazio));
                  await prefs.setStringList("TextoSalvo", (texto??vazio));
                  await fcVoltar(context);
                },
                child: Text("Salvar",style: TextStyle(color: Colors.white, fontSize: 14, ),),
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


}
