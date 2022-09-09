import 'package:blocapptest/exceptions/app_exception.dart';
import 'package:blocapptest/presentation/login/blog/login_cubit.dart';
import 'package:blocapptest/presentation/login/blog/login_state.dart';
import 'package:blocapptest/utils/prefs_service.dart';
import 'package:blocapptest/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static const String _title = 'Login Screeen';
  @protected
  @mustCallSuper
  void initState() {
    PrefsService.init();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(_title),
          automaticallyImplyLeading: false,
        ),
        body: BlocProvider(
            create: (ctx) => LoginCubit(),
            child:
                BlocBuilder<LoginCubit, LoginState>(builder: (context, state) {
              if (state is LoginSuccess) {
                SchedulerBinding.instance?.addPostFrameCallback((_) {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed("/home");
                });
              }
              return StateStreamLayout(
                  stream: context.read<LoginCubit>().stateStream,
                  retry: () {},
                  textEmpty: "Error",
                  error: context.read<LoginCubit>().errMsg,
                  child: const LoginScreenStatefulWidget());
            })));
  }
}

class LoginScreenStatefulWidget extends StatefulWidget {
  const LoginScreenStatefulWidget({Key? key}) : super(key: key);

  @override
  State<LoginScreenStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<LoginScreenStatefulWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'CVHT Login',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Sign in',
                  style: TextStyle(fontSize: 20),
                )),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'User Name',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                //forgot password screen
              },
              child: const Text(
                'Forgot Password',
              ),
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child: const Text('Login'),
                  onPressed: () {
                    BlocProvider.of<LoginCubit>(context)
                        .login(nameController.text, passwordController.text);
                  },
                )),
            Row(
              children: <Widget>[
                const Text('Does not have account?'),
                TextButton(
                  child: const Text(
                    'Sign in',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    //signup screen
                  },
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ],
        ));
  }
}
