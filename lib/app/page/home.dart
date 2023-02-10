import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _controllerCep = TextEditingController();
  String _resultado = "Resultado";

  _recuperarCep() async {
    String cepDigitado = _controllerCep.text;
    var urlBase = Uri.parse('https://viacep.com.br/ws/$cepDigitado/json/');
    http.Response response;

    response = await http.get(urlBase);

    Map<String, dynamic> retorno = json.decode(response.body);
    String logradouro = retorno["logradouro"];
    String bairro = retorno["bairro"];
    String complemento = retorno["complemento"];
    String localidade = retorno["localidade"];
    String uf = retorno["uf"];


    setState(() {
      _resultado = "$logradouro, $complemento, $bairro, $localidade $uf";
    });
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Consulta CEP',
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            digiteoCep(),
            botaoCliqueAqui(),
            Text(_resultado),
          ],
        ),
      ),
    );
  }

  digiteoCep() {
    return TextField(
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        labelText: 'Digite o cep: exemp: 05428200',
      ),
      style: const TextStyle(
        fontSize: 20,
      ),
      controller: _controllerCep,
    );
  }

  botaoCliqueAqui() {
    return ElevatedButton(
      onPressed: _recuperarCep,
      child: const Text(
        'Clique aqui',
      ),
    );
  }

}
