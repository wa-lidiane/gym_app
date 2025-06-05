import 'package:flutter/material.dart';
import 'package:gym_app/_comum/meu_snackbar.dart';
import 'package:gym_app/_comum/minhas_cores.dart';
import 'package:gym_app/componentes/decoracao_campo_autenticacao.dart';
import 'package:gym_app/servicos/autenticacao_servico.dart';

class AutenticacaoTela extends StatefulWidget {
  const AutenticacaoTela({super.key});

  @override
  State<AutenticacaoTela> createState() => _AutenticacaoTelaState();
}

class _AutenticacaoTelaState extends State<AutenticacaoTela> {
  bool queroEntrar = true;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _nomeController = TextEditingController();

  AutenticacaoServico _autenServico = AutenticacaoServico();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  MinhasCores.azulTopoGradiente,
                  MinhasCores.azulBaixoGradiente,
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image.asset('assets/logo.png', height: 128),
                      Text(
                        'GymApp',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 32),
                      TextFormField(
                        controller: _emailController,
                        decoration: getAuthenticatorInputDecoration('Email'),
                        validator: (String? value) {
                          if (value == null) {
                            return 'O email não pode ser vazio';
                          }
                          if (value.length < 5) {
                            return 'O email é muito curto';
                          }
                          if (!value.contains('@')) {
                            return 'O email não é válido';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        controller: _senhaController,
                        decoration: getAuthenticatorInputDecoration('Senha'),
                        validator: (String? value) {
                          if (value == null) {
                            return 'A senha não pode ser vazia';
                          }
                          if (value.length < 5) {
                            return 'A senha é muito curta';
                          }
                          return null;
                        },
                        obscureText: true,
                      ),
                      SizedBox(height: 8),
                      Visibility(
                        visible: !queroEntrar,
                        child: Column(
                          children: [
                            TextFormField(
                              decoration: getAuthenticatorInputDecoration(
                                'Confirme a senha',
                              ),
                              validator: (String? value) {
                                if (value == null) {
                                  return 'A confirmação de senha não pode ser vazia';
                                }
                                if (value.length < 5) {
                                  return 'A confirmação de senha é muito curta';
                                }
                                return null;
                              },
                              obscureText: true,
                            ),
                            SizedBox(height: 8),
                            TextFormField(
                              controller: _nomeController,
                              decoration: getAuthenticatorInputDecoration(
                                'Nome',
                              ),
                              validator: (String? value) {
                                if (value == null) {
                                  return 'O nome não pode ser vazio';
                                }
                                if (value.length < 5) {
                                  return 'O nome é muito curto';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          botaoPrincipalClicado();
                        },
                        child: Text((queroEntrar) ? 'Entrar' : 'Cadastrar'),
                      ),
                      Divider(),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            queroEntrar = !queroEntrar;
                          });
                        },
                        child: Text(
                          (queroEntrar)
                              ? 'Ainda não tem uma conta? Cadastre-se!'
                              : 'Já tem uma conta? Entre!',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  botaoPrincipalClicado() {
    String nome = _nomeController.text;
    String email = _emailController.text;
    String senha = _senhaController.text;
    if (_formKey.currentState!.validate()) {
      if (queroEntrar) {
        print('Entrada Validada');
        _autenServico.logarUsuarios(email: email, senha: senha).then((
          String? erro,
        ) {
          if (erro != null) {
            mostrarSnackBar(context: context, texto: erro);
          }
        });
      } else {
        print('Cadastro Validado');
        print(
          '${_emailController.text}, ${_senhaController.text}, ${_nomeController.text}',
        );
        _autenServico
            .cadastrarUsuario(nome: nome, senha: senha, email: email)
            .then((String? erro) {
              if (erro != null) {
                //voltou com erro
                mostrarSnackBar(context: context, texto: erro);
              } 
            });
      }
    } else {
      print('Form Inválido');
    }
  }
}
