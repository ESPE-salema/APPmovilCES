import 'package:app_movil_ces/src/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_movil_ces/src/bloc/login_bloc.dart';
import 'package:app_movil_ces/src/models/usuario_model.dart';
import 'package:app_movil_ces/src/providers/main_provider.dart';
import 'package:app_movil_ces/src/services/usuario_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;
  final LoginBloc _loginBloc = LoginBloc();

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.height;
    final mainProvider = Provider.of<MainProvider>(context);

    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
      child: Stack(
        children: [
          Container(
            color: Palette.color,
            height: size * 0.9,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 35.0, right: 35.0),
            child: Column(
              children: [
                Image.asset("assets/images/logo.png", scale: 2.2),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text("Inicio de sesión",
                      style: Theme.of(context).textTheme.headlineSmall!.apply(
                          color: Theme.of(context).scaffoldBackgroundColor)),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).hintColor, width: 2.0),
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        StreamBuilder<String>(
                            stream: _loginBloc.emailStream,
                            builder: (context, snapshot) {
                              return TextField(
                                  keyboardType: TextInputType.emailAddress,
                                  onChanged: _loginBloc.changeEmail,
                                  decoration: InputDecoration(
                                      errorText: snapshot.error?.toString(),
                                      icon: const Icon(Icons.email),
                                      labelText: "Correo electrónico",
                                      hintText: "admin@kaizen.com"));
                            }),
                        StreamBuilder<String>(
                            stream: _loginBloc.passwordStream,
                            builder: (context, snapshot) {
                              return TextField(
                                  onChanged: _loginBloc.changePassword,
                                  obscureText: _obscureText,
                                  decoration: InputDecoration(
                                      errorText: snapshot.error?.toString(),
                                      suffixIcon: IconButton(
                                          onPressed: () {
                                            _obscureText = !_obscureText;
                                            setState(() {});
                                          },
                                          icon: Icon(
                                            _obscureText
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                          )),
                                      icon: const Icon(Icons.lock),
                                      labelText: "Contraseña"));
                            }),
                        Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: StreamBuilder<bool>(
                              stream: _loginBloc.formLoginStream,
                              builder: (context, snapshot) {
                                return ElevatedButton.icon(
                                    onPressed: snapshot.hasData
                                        ? () async {
                                            final usrSrv =
                                                UsuarioService(); //Servicio
                                            final usr = Usuario(
                                                //Modelo
                                                email: _loginBloc.email,
                                                password: _loginBloc.password);

                                            Map<String, dynamic> resp =
                                                await usrSrv.login(usr);
                                            if (resp.containsKey("idToken")) {
                                              mainProvider.token =
                                                  resp['idToken'];
                                            }
                                            if (resp['idToken'] == null) {
                                              // ignore: use_build_context_synchronously
                                              showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      AlertDialog(
                                                        title: const Text(
                                                            "Correo o contraseña incorrectos"),
                                                        content: const Text(
                                                            "Intente nuevamente."),
                                                        actions: <Widget>[
                                                          // ignore: deprecated_member_use
                                                          TextButton(
                                                              //color: Palette.color,
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: const Text(
                                                                  'Ok'))
                                                        ],
                                                      ));
                                            }
                                          }
                                        : null,
                                    icon: const Icon(Icons.login),
                                    label: const Text("Ingresar"));
                              }),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              heightFactor: MediaQuery.of(context).size.height / 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("¿No tiene cuenta?"),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/signup");
                      },
                      child: const Text("Registrarse"))
                ],
              ))
        ],
      ),
    )));
  }
}
