import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dropcomum extends StatefulWidget {
  final List<String> opcoes;

  final String rotulo;
  //String  valorDrop;
  String valorc;

  Dropcomum({
    this.opcoes,
    this.rotulo,
    this.valorc,
  });

  @override
  _DropcomumState createState() => _DropcomumState();
}

class _DropcomumState extends State<Dropcomum> {
  String valor;
  var v3;
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(28.0, 10.0, 28.0, 0.0),
      child: DropdownButton<String>(
        value: valor,
        hint: Text(widget.rotulo,
            style: TextStyle(
              fontSize: 16,
            )),
        icon: Icon(
          Icons.keyboard_arrow_down,
          textDirection: TextDirection.rtl,
        ),
        iconSize: 27,
        iconEnabledColor: Color(0xFF06bb48),
        elevation: 16,
        isExpanded: true,
        style: TextStyle(
          color: Color(0xFF06bb48),
          fontSize: 16,
        ),
        underline: Container(
          height: 1,
          color: Color(0xFF06bb48),
        ),
        onChanged: (newValue) {
          setState(() {
            valor = newValue;
            debugPrint(valor);
            v3 = valor;
            widget.valorc = v3;
            debugPrint(widget.valorc);
          });
        },
        items: widget.opcoes.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
