import 'package:flutter/material.dart';

exibirAlerta({context, titulo, content}) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(titulo),
          content: Text(content),
          actions: [
            FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Fechar')
            ),
          ],
        );
      }
  );
}