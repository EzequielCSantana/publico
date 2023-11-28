import 'package:app/domain/services/apis.dart';
import 'package:app/functions/nav.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:edge_alerts/edge_alerts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../home/home.dart';



class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final txLogin = TextEditingController(text: "");
  final txSenha = TextEditingController(text: "");

  final Color cor01 =  Color.fromRGBO(30, 78, 98, 1);
  final Color cor02 =  Color.fromRGBO(46, 150, 143, 1);

  @override
  Widget build(BuildContext context) {
    Size Mdq= MediaQuery.of(context).size;



    return Material(
      child: Container(
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
          children: [

            SizedBox(height: Mdq.height/4,),



            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Usuário",style: TextStyle(color: Colors.white, fontSize: 16 ),),
                  ),
                  TextField(
                    style: TextStyle(backgroundColor: Colors.white),
                    keyboardType: TextInputType.text,
                    controller: txLogin,
                    maxLength: 20,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person,color: Colors.black,),
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(width: 1, color: Colors.white), //<-- SEE HERE
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Senha",style: TextStyle(color: Colors.white, fontSize: 16 ),),
                  ),
                  TextField(
                    style: TextStyle(backgroundColor: Colors.white),
                    keyboardType: TextInputType.text,
                    controller: txSenha,
                    obscureText: true,
                    maxLength: 20,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.password,color: Colors.black,),
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(width: 1, color: Colors.white), //<-- SEE HERE
                        borderRadius: BorderRadius.circular(10.0),
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
                            onPressed: (){
                              if (txLogin.text==""){
                                edgeAlert(
                                    context,
                                    title: 'Informação!',
                                    description: 'Informe o Login.',
                                    gravity: Gravity.top,
                                    duration: 3,
                                    backgroundColor: Colors.redAccent,
                                    icon: Icons.person
                                );
                                return;
                              }
                              if (txSenha.text==""){
                                edgeAlert(
                                    context,
                                    title: 'Informação!',
                                    description: 'Informe a senha.',
                                    gravity: Gravity.top,
                                    duration: 3,
                                    backgroundColor: Colors.redAccent,
                                    icon: Icons.password
                                );
                                return;
                              }
                              // deixie essa validação na api só para testes
                              if (txSenha.text.length < 2){
                                edgeAlert(
                                    context,
                                    title: 'Informação!',
                                    description: 'O campo senha não pode ter menos de 2 caracteres.',
                                    gravity: Gravity.top,
                                    duration: 3,
                                    backgroundColor: Colors.redAccent,
                                    icon: Icons.password
                                );
                                return;
                              }
                              final expLogin = RegExp(r"[^[a-zA-Z0-9]");
                              if ( expLogin.hasMatch(txLogin.text )){
                                edgeAlert(
                                    context,
                                    title: 'Informação!',
                                    description: "O campo login não pode ter caracteres especiais, sendo apenas possível informar 'a' até 'Z' e '0' até '9'.",
                                    gravity: Gravity.top,
                                    duration: 3,
                                    backgroundColor: Colors.redAccent,
                                    icon: Icons.password
                                );
                                return;
                              }
                              final expSenha = RegExp(r"[^[a-zA-Z0-9]");
                              if ( expSenha.hasMatch(txSenha.text )){
                                edgeAlert(
                                    context,
                                    title: 'Informação!',
                                    description: "O campo senha não pode ter caracteres especiais, sendo apenas possível informar 'a' até 'Z' e '0' até '9'.",
                                    gravity: Gravity.top,
                                    duration: 3,
                                    backgroundColor: Colors.redAccent,
                                    icon: Icons.password
                                );
                                return;
                              }
                              //api Rest - feito c# Asp .Net Core
                              apis.Loginapp(senha: txSenha.text,usuario: txLogin.text).then((dados) async{
                                if ( dados.retorno==1 ){
                                  final SharedPreferences prefs = await SharedPreferences.getInstance();
                                  final List<String>? texto =await prefs.getStringList('TextoSalvo');

                                  prefs.remove('TextoSalvo');

                                  pushReplace(context, home(Login: dados,texto: texto,));
                                }else{
                                  edgeAlert(
                                      context,
                                      title: 'Informação',
                                      description: 'Usuário não encontrado!',
                                      gravity: Gravity.top,
                                      backgroundColor: Colors.red,
                                      icon: Icons.error,
                                      duration: 2
                                  );
                                }
                              }).catchError((erro){
                                edgeAlert(
                                    context,
                                    title: 'Erro',
                                    description: 'Verifique sua intenet!',
                                    gravity: Gravity.top,
                                    backgroundColor: Colors.red,
                                    icon: Icons.error,
                                    duration: 2
                                );
                              });
                            },
                            child: Text("Entrar",style: TextStyle(color: Colors.white, fontSize: 14, ),),
                          ),
                        ),
                      ),





                ],
              ),
            ),

            SizedBox(height: 30,),


            InkWell(child: Text("Política de Privacidade",style: TextStyle(color: Colors.white, fontSize: 16 ),)
              ,onTap: ()async{

                final Uri _url = Uri.parse('https://www.targetsistemas.com.br/');
                await launchUrl(_url);

              },
            ),






          ],
        ),
      ),
    );
  }


}
