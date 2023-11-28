import 'dart:ffi';

import 'package:app/classes/LoginApp.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';




class apis {
  //os endreço agora fica na pasta lib/assets/config


  static String serial="ModeloApp";

  static Future<LoginApp> Loginapp(
      {
        String usuario="",
        String senha=""
      }
      ) async {
      String apisUrl= "http://appmodelo.opusnet.app.br/";
      String url = "${apisUrl}apis/LoginApp";
      final headers = {"Content-Type": "application/json",
      "Access-Control-Allow-Origin":"*",
      "Access-Control-Allow-Methods":"POST, GET, OPTIONS, PUT, DELETE, HEAD",
      };
      print(url);
      final _script = {
      "serial": serial,
      "usuario":"$usuario",
      "senha":"$senha",
    };
      print(_script);
    final body = json.encode(_script);
    final response = await http.post(Uri.parse(url), headers: headers, body: body);
      LoginApp _LoginApp = LoginApp();
      final map_LoginApp = json.decode(response.body).cast<Map<String, dynamic>>();
      if ( map_LoginApp[0]["retorno"]==1){
        _LoginApp.retorno=1;
        _LoginApp.id=map_LoginApp[0]["id"] as String;
        _LoginApp.usuario=map_LoginApp[0]["usuario"] as String;
        _LoginApp.data=map_LoginApp[0]["data"] as String;

        print(_LoginApp);
      }else{
        _LoginApp.retorno=0;
      }
      print(_LoginApp);
      return _LoginApp;
  }




}
