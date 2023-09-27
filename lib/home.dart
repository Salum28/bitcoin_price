import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Atributos
  String _value = 'R\$ 0';
  late Uri _url;
  late http.Response _response;
  late Map<String, dynamic> _result;

  // Métodos
  void _updateValue() async {
    _url = Uri.parse('https://blockchain.info/ticker');
    _response = await http.get(_url);
    _result = json.decode(_response.body);

    setState(() {
      _value = 'R\$ ${_result['BRL']['buy'].toString()}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Image.asset('images/bitcoin.png'),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Text(
                  _value,
                  style: const TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              FilledButton(
                  onPressed: _updateValue,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.orange),
                    padding: MaterialStateProperty.resolveWith(
                      (states) => const EdgeInsets.symmetric(vertical: 15, horizontal: 30)
                    )
                  ),
                  child: const Text(
                    'Atualizar',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white
                    ),
                  )
              )
            ],
          ),
        )
      )
    );
  }
}
