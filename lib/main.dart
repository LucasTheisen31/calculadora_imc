import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(), //instanciando tela principal
  ));
}

class Home extends StatefulWidget {
  ///StatefulWidget pois nossa tela possuira widget editavel
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  //atributos
  ///declarando 2 objetos controladores para os 2 campos de peso e altura
  TextEditingController pesoController = new TextEditingController();
  TextEditingController alturaController = new TextEditingController();

  GlobalKey<FormState> _chaveGlobal = new GlobalKey<FormState>();

  String _infoTexto = "Informe seus dados!";


  //metodos
  void _resetarCampos(){
      pesoController.text = "";
      alturaController.text = "";
      setState(() {
        _infoTexto = "Informe seus dados!";
        _chaveGlobal = new GlobalKey<FormState>();
      });
  }

  void _calcularIMC(){
    setState(() { ///set state nosso widget será reconstruído já com o novo valor das variáveis
      double altura = double.parse(alturaController.text)/100;
      double peso = double.parse(pesoController.text);
      double imc = (peso / (altura * altura));

      if(imc < 18.6){
        _infoTexto = "Abaixo do Peso (IMC : ${imc.toStringAsPrecision(4)})"; ///transforma imc em uma string com precisao de 4 digitos
      }else if(imc >= 18.6 && imc < 24.9){
        _infoTexto = "Peso Ideal (IMC : ${imc.toStringAsPrecision(4)})";
      }else if(imc >= 24.9 && imc < 29.9){
        _infoTexto = "Levemente Acima do Peso (IMC : ${imc.toStringAsPrecision(4)})";
      } else if(imc >= 29.9 && imc < 34.9){
        _infoTexto = "Obesidade Grau 1 (IMC : ${imc.toStringAsPrecision(4)})";
      } else if(imc >= 34.9 && imc < 39.9){
        _infoTexto = "Obesidade Grau 2 (IMC : ${imc.toStringAsPrecision(4)})";
      }else if(imc >= 40){
        _infoTexto = "Obesidade Grau 3 (IMC : ${imc.toStringAsPrecision(4)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///Widget Scaffold
      appBar: AppBar(///instanciando uma appBar AppBar appBar = new AppBar();
        title: Text("Calculadora de IMC"),///titulo da appBar
        centerTitle: true,///centraliza o titulo
        backgroundColor: Colors.green,
        actions: [///adiciona acoes a barra de titulo
          IconButton(icon: Icon(Icons.refresh),///adicionando um botao
            onPressed: _resetarCampos,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(///torna rolavel a view, possui somente 1 filho que no caso sera a coluna com os alementos
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),///espaçamento na coluna abaixo(10 na esquerda e 10 na direita)
        child: Form(
          key: _chaveGlobal,
          child: Column(// column pois vamos agrupar as coisa na verical
            crossAxisAlignment: CrossAxisAlignment.stretch,///stretch tenta ocupar toda a largura, centraliza os elementos da coluna
            children: [///filhos que estarao dentro da coluna
              Icon(Icons.account_circle, size:120, color: Colors.green,),
              TextFormField(keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Peso (Kg):",
                  labelStyle: TextStyle(color: Colors.green),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25, fontWeight: FontWeight.bold),
                controller: pesoController,
                validator: (value){///valida os campos
                  if(value!.isEmpty){
                    return "Insira o Peso!";
                  }
                },
              ),

              TextFormField(keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Altura (cm):",
                  labelStyle: TextStyle(color: Colors.green),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25, fontWeight: FontWeight.bold),
                controller: alturaController,
                validator: (value){///valida os campos
                  if(value!.isEmpty){
                      return "Insira a Altura!";
                  }
                },
              ),
              Padding(///espacamemto
                padding: EdgeInsets.only(top: 10, bottom: 10),///adiciona espacamento de 10 em cima e em baixo
                child: Container(///colocar o botao dentro de um container para definir s altura
                  height: 50,
                  child: TextButton(
                    onPressed: (){//evento de click do botao
                      if(_chaveGlobal.currentState!.validate()){
                          _calcularIMC();
                      }
                    },
                    child: Text("Calcular",style: TextStyle(color: Colors.white, fontSize: 25),), //texto dentro do botao
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.green)),
                  ),
                ),
              ),
              Text(_infoTexto, textAlign: TextAlign.center, style: TextStyle(color: Colors.green, fontSize: 25),),
            ],
          ),
        ),
      ),
    );
  }
}
