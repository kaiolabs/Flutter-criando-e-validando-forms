import 'package:brasil_fields/brasil_fields.dart';
import 'package:bytebank/components/mensagem.dart';
import 'package:bytebank/screens/autenticacao/registrar.dart';
import 'package:bytebank/screens/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flux_validator_dart/flux_validator_dart.dart';

class Login extends StatelessWidget {

  TextEditingController _cpfController = TextEditingController();
  TextEditingController _senhaController = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 40),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  'assets/images/bytebank_logo.png',
                  width: 200,
                ),
              ),

              SizedBox(height: 30,),

              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 300,
                  height: 455,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)
                  ),

                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: _construirFormulario(context),
                  ),
                ),
              ),

              SizedBox(height: 20,)
            ],
          ),
        ),
      ),
      backgroundColor: Theme.of(context).accentColor,
    );
  }

  Widget _construirFormulario(context) {
    return Form(
      key: _formkey,
      child: Column(
        children: [
          Text(
            'Faça seu Login',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 15,),

          TextFormField(
            decoration: InputDecoration(
              labelText: 'CPF',
            ),
            maxLength: 14,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              CpfInputFormatter(),
            ],
            validator: (value) => Validator.cpf(value) ? 'CPF inválido' : null,
            keyboardType: TextInputType.number,
            controller: _cpfController,
          ),

          SizedBox(height: 20,),

          TextFormField(
            decoration: InputDecoration(
              labelText: 'Senha',
            ),
            maxLength: 15,
            validator: (value) {
              if(value.length == 0)
                return 'Informe uma senha!';

              return null;
            },
            keyboardType: TextInputType.text,
            controller: _senhaController,
          ),

          SizedBox(height: 30,),

          SizedBox(
            width: double.infinity,
            child: OutlineButton(
              textColor: Theme.of(context).accentColor,
              highlightColor: Color.fromRGBO(
                  71, 161, 56, 0.2
              ),
              borderSide: BorderSide(
                  width: 2,
                  color: Theme.of(context).accentColor
              ),
              child: Text('CONTINUAR'),
              onPressed: () {
                if(_formkey.currentState.validate()) {

                  if(_cpfController.text == '267.168.570-01' && _senhaController.text == 'abc123') {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Dashboard(),
                        ),
                            (route) => false
                    );
                  } else {
                    exibirAlerta(
                        context: context,
                        titulo: 'ATENÇÃO',
                        content: 'CPF ou Senha incorretos!'
                    );
                  }
                }
              },
            ),
          ),

          SizedBox(height: 15),

          Text(
            'Esqueci minha senha >',
            style: TextStyle(
              color: Theme.of(context).accentColor,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 25),
          OutlineButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Registrar()
                ),
              );
            },
            highlightColor: Color.fromRGBO(71, 161, 56, 0.2),
            borderSide: BorderSide(
                width: 2,
                color: Theme.of(context).accentColor
            ),
            textColor: Theme.of(context).accentColor,
            child: Text(
              'Criar uma conta >',
              style: TextStyle(
                color: Theme.of(context).accentColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
