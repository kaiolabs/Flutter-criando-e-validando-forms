import 'package:bytebank/models/cliente.dart';
import 'package:bytebank/screens/autenticacao/login.dart';
import 'package:bytebank/screens/dashboard/saldo.dart';
import 'package:bytebank/screens/deposito/formulario.dart';
import 'package:bytebank/screens/extrato/ultimas.dart';
import 'package:bytebank/screens/transferencia/formulario.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bytebank'),
      ),
      body: Column(
        children: <Widget>[

          Consumer<Cliente>(
              builder: (context, cliente, child) {
                if(cliente.nome != null) {

                  return Text('Olá, ${cliente.nome.split(" ")[0]}, o seu saldo de hoje é:',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15
                      )
                  );
                }

                return Text('Olá, o seu saldo de hoje é:',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15
                    )
                );
              }
          ),

          Align(
            alignment: Alignment.topCenter,
            child: SaldoCard(),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                color: Colors.green,
                child: Text('Recebe valor'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return FormularioDeposito();
                    }),
                  );
                },
              ),
              RaisedButton(
                color: Colors.green,
                child: Text('Nova Transferência'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return FormularioTransferencia();
                    }),
                  );
                },
              ),
            ],
          ),
          UltimasTransferencias(),
          RaisedButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => Login()
                ),
                (route) => false
              );
            },
            color: Colors.green,
            child: Text('Sair'),
          ),
        ],
      ),
    );
  }
}
