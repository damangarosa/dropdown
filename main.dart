import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dropDownComum.dart';
import 'estadoCidade.dart';
import 'formulario.dart';

void main() => runApp(AberturaSimples());

class AberturaSimples extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Color(0xFF06bb48),
          accentColor: Colors.amber[600],
          buttonTheme: ButtonThemeData(
              buttonColor: Colors.amber[600],
              textTheme: ButtonTextTheme.primary)),
      home: Scaffold(
        body: ListaLeads(),
      ),
    );
  }
}

class FormularioCad extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FormularioCadState();
  }
}

class FormularioCadState extends State<FormularioCad> {
  final TextEditingController _controllerFieldName = TextEditingController();
  final TextEditingController _controllerFieldEmail = TextEditingController();
  final TextEditingController _controllerFieldPhone = TextEditingController();
  //final TextEditingController _controllerFieldCity = TextEditingController();
  //final TextEditingController _controllerFieldIdentify =TextEditingController();
  //final TextEditingController _controllerFieldRevenues =TextEditingController();
  //final TextEditingController _controllerFieldTypeEnterprise =TextEditingController();
  final TextEditingController _controllerFieldNiche = TextEditingController();
  final _controller = TextEditingController();
  final TextEditingController _ctipoempresa = TextEditingController();
  final TextEditingController _cfaturamento = TextEditingController();
  final TextEditingController _cidentificacao = TextEditingController();

  bool _validate = false;

  //FormularioCadState(this._cidentificacao, this._ctipoempresa, this._cfaturamento);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String dropdownValue;
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: Text('Cadastrar Lead'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Formulario(
              controller: _controllerFieldName,
              rotulo: 'Nome',
              dica: 'Mariana Lima',
              icone: Icons.person,
              validate: _validate ? '' : null,
            ),
            Formulario(
              controller: _controllerFieldEmail,
              rotulo: 'E-Mail',
              dica: 'marilima@mail.com',
              icone: Icons.email,
              teclado: TextInputType.emailAddress,
              validate: _validate ? '' : null,
            ),
            Formulario(
              controller: _controllerFieldPhone,
              rotulo: 'Telefone',
              dica: '11965783200',
              icone: Icons.phone_android,
              teclado: TextInputType.phone,
              validate: _validate ? '' : null,
            ),
            Addrs(),
            Dropcomum(
              rotulo: 'Identificador',
              opcoes: ['WhatsApp', 'Telefone', 'Presencial', 'Outros'],
              valorc: _cidentificacao.text,
            ),
            Dropcomum(
              rotulo: 'Faturamento',
              opcoes: ['0 a 7 mil', '7 a 50 mil', '50 a 100mil', '+100mil'],
              //valorc: _controllerFieldRevenues,
              valorc: _cfaturamento.text,
            ),
            Dropcomum(
              rotulo: 'Tipo de Empresa',
              opcoes: ['Comércio', 'Serviços', 'Indústria'],
              // valorc: _controllerFieldTypeEnterprise,
              valorc: _ctipoempresa.text,
              //valorDrop: kj,
            ),
            Formulario(
              controller: _controllerFieldNiche,
              rotulo: 'Nicho',
              dica: 'Ex: Loja de Sapatos',
              icone: Icons.category,
              validate: _validate ? '' : null,
            ),
            RaisedButton(
                child: Text('Cadastrar'),
                onPressed: () {
                  cadEfetuado(context);
                  debugPrint(_controllerFieldEmail.text);

                  setState(() {
                    _controllerFieldName.text.isEmpty
                        ? _validate = true
                        : _validate = false;
                  });
                }),
          ],
        ),
      ),
    );
  }

  void cadEfetuado(BuildContext context) {
    debugPrint('clicou Salvar');
    final String nomeLead = _controllerFieldName.text;
    int.tryParse(_controllerFieldName.text);
    final String telLead = _controllerFieldPhone.text;
    final String emailLead = _controllerFieldEmail.text;
    //final String cidadeLead = _controllerFieldCity.text;
    //final String estadoLead = mesa;
    final String identificadorLead =
        _cidentificacao.text; //_controllerFieldIdentify.text;
    final String faturamentoLead =
        _cfaturamento.text; //_controllerFieldRevenues.text;
    final String tipoEmpresaLead =
        _ctipoempresa.text; //kj; //_controllerFieldTypeEnterprise.text;
    final String nichoLead = _controllerFieldNiche.text;

    if (nomeLead.isNotEmpty &&
        telLead.isNotEmpty &&
        emailLead != '' &&
        //cidadeLead != '' &&
        //estadoLead != '' &&-
        // identificadorLead != '' &&
        //faturamentoLead != '' &&
        //tipoEmpresaLead != '' &&
        nichoLead != '') {
      final pacoteLead = Cadastro(
          nomeLead,
          telLead,
          emailLead,
          //cidadeLead,
          //estadoLead,
          identificadorLead,
          faturamentoLead,
          tipoEmpresaLead,
          nichoLead);
      debugPrint('Criando Lead');
      debugPrint('$pacoteLead');
      Navigator.pop(context, pacoteLead);
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Processing Data')));
    } else {
      debugPrint('Usuario errou!!!');
    }
  }
}

class ListaLeads extends StatefulWidget {
  final List<Cadastro> _cadastros = List();

  @override
  State<StatefulWidget> createState() {
    return ListaLeadsState();
  }
}

class ListaLeadsState extends State<ListaLeads> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Abertura Simples'),
      ),
      body: ListView.builder(
        itemCount: widget._cadastros.length,
        itemBuilder: (context, indice) {
          final cadastro = widget._cadastros[indice];
          return UniLeads(cadastro);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          final Future<Cadastro> future =
              Navigator.push(context, MaterialPageRoute(builder: (context) {
            return FormularioCad();
          }));
          future.then((pacoteLead) {
            debugPrint('Já chegou o disco voador');
            debugPrint('$pacoteLead');
            if (pacoteLead != null) {
              widget._cadastros.add(pacoteLead);
            }
          });
        },
      ),
    );
  }
}

class UniLeads extends StatelessWidget {
  final Cadastro _cadastro;

  UniLeads(this._cadastro);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(
                Icons.person,
                size: 34.0,
              ),
              title: Text(
                _cadastro.nomeLead,
                style: TextStyle(fontSize: 22.0),
              ),
              subtitle: Text(
                _cadastro.emailLead,
                style: TextStyle(fontSize: 16.0),
              ),
              trailing: Text(
                _cadastro.nichoLead,
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            ButtonTheme.bar(
              child: ButtonBar(
                children: <Widget>[
                  FlatButton.icon(
                    icon: Icon(Icons.phone),
                    label: Text(
                      'Ligar',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    onPressed: () {/* ... */},
                  ),
                  FlatButton.icon(
                    icon: const Icon(Icons.pageview, size: 18.0),
                    label: Text(
                      'Dados',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    onPressed: () {/* ... */},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Cadastro {
  final String nomeLead;
  final String telLead;
  final String emailLead;
  //final String cidadeLead;
  //final String estadoLead;
  final String identificadorLead;
  final String faturamentoLead;
  final String tipoEmpresaLead;
  final String nichoLead;

  Cadastro(
      this.nomeLead,
      this.telLead,
      this.emailLead,
      //this.cidadeLead,
      //this.estadoLead,
      this.identificadorLead,
      this.faturamentoLead,
      this.tipoEmpresaLead,
      this.nichoLead);
  //$cidadeLead, UF: $estadoLead
  @override
  String toString() {
    return 'Cadastro{nome: $nomeLead, tel: $telLead,  , Ide: $identificadorLead, email: $emailLead, Faturamento: $faturamentoLead, TipoEmpresa: $tipoEmpresaLead, Nicho: $nichoLead }';
  }
}
