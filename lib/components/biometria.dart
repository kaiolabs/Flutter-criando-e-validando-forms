import 'package:bytebank/models/cliente.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';

class Biometria extends StatelessWidget {

  final LocalAuthentication _autenticacaoLocal = LocalAuthentication();

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: _biometriaDisponivel(),
      builder: (context, snapshot) {
        if(snapshot.data == true) {
          return Padding(
            padding: EdgeInsets.only(top: 15, bottom: 15),
            child: Column(
              children: [
                Text(
                  'Detectamos que você tem sensor biométrico no seu smartphone, deseja cadastrar o acesso biométrico?',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 20),
                RaisedButton(
                  onPressed: () async {
                    await _autenticarCliente(context);
                  },
                  child: Text('Habilitar impressão digital'),
                )
              ],
            ),
          );
        }

        return Container();
      }
    );

  }

  Future<bool> _biometriaDisponivel() async {
    try {
      return await _autenticacaoLocal.canCheckBiometrics;
    } on PlatformException catch(erro) {
      print(erro);
    }
  }

  Future<void> _autenticarCliente(context) async {
    bool autenticado = false;
    autenticado = await _autenticacaoLocal.authenticateWithBiometrics(
      localizedReason: 'Por favor, autentique-se via biometria para acessar o Bytebank',
      useErrorDialogs: true,
    );

    Provider.of<Cliente>(context).biometria = autenticado;
  }
}
