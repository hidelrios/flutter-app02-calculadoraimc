import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Calculadora de IMC'),
          backgroundColor: Colors.lime,
        ),
        body: const FormImc(),
        backgroundColor: const Color.fromARGB(255, 236, 241, 176),
      ),
    );
  }
}

class FormImc extends StatefulWidget {
  const FormImc({super.key});

  @override
  State<FormImc> createState() => _FormImcState();
}

class _FormImcState extends State<FormImc> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _pesoController = TextEditingController();
  final TextEditingController _alturaController = TextEditingController();
  String _resultado = '';

  void _calcularImc() {
    final double peso = double.parse(_pesoController.text);
    final double altura = double.parse(_alturaController.text) /
        100; // Convertendo cm para metros
    final double imc = peso / (altura * altura);

    setState(() {
      _resultado = 'Seu IMC é ${imc.toStringAsFixed(2)}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: _pesoController,
              decoration: const InputDecoration(
                hintText: 'Peso (Kg)',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira um valor';
                }
                return null;
              },
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: _alturaController,
              decoration: const InputDecoration(
                hintText: 'Altura (Cm)',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira um valor';
                }
                return null;
              },
              keyboardType: TextInputType.number,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _calcularImc();
                  }
                },
                child: const Text('Calcular'),
              ),
            ),
            Text(
              _resultado,
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
