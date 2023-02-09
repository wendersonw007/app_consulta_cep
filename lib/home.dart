import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
 TextEditingController _controllerCep = TextEditingController();
  String _resultado = "Resultado";

  // comunicação síncrona e assincrona  -
  // Sincrona ao conversar a pessoa já me responde
  // assincrona, mando uma mensagem no whatsapp e a pessoa logo me responde(tempo de resposta desconhecio)
  _recuperarCep() async {
    //metodo recuperar cep e assincrono
    String cepDigitado = _controllerCep.text;
    var urlBase = Uri.parse('https://viacep.com.br/ws/${cepDigitado}/json/');
    http.Response response;
    // abaixo resposta da variavel reponse = await quer dizer que vou aguardar a resposta
    response = await http.get(urlBase);
    //await é esperar a execução
    //json.decode(response.body); ->transformo esse objeto em um MAP chave e valor
    Map<String, dynamic> retorno = json.decode(response.body);
    String logradouro = retorno["logradouro"];
    String bairro = retorno["bairro"];
    String complemento = retorno["complemento"];
    // String numero = retorno["numero"];


    setState(() {
      _resultado = "${logradouro}, ${complemento}, ${bairro}";
    });


    print('***********************');
    print("Resposta logradouro:  ${logradouro} complemento: ${complemento}  bairro: ${bairro} ");
    print('***********************');
    print("responsta status to string: "+ response.statusCode.toString());
    print('***********************');
    print("responsta body: "+ response.body);
    print('***********************');

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Consulta CEP',),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Digite o cep: exemp: 05428200',
              ),
              style: TextStyle(
                fontSize:  20,
              ),
              controller: _controllerCep,
            ),
            ElevatedButton(onPressed: _recuperarCep, child: Text('clique aqui')),
            Text(_resultado),

          ],
        ),
      ),
    );
  }
}
