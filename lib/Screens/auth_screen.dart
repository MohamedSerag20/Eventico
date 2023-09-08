import 'package:eventico/Widgets/login_texts.dart' as login;
import 'package:eventico/Widgets/signup_texts.dart' as signup;
import 'package:flutter/material.dart';
import 'package:eventico/Providers/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});
  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  var isLogin = true;
  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    bool? provState = ref.watch(AuthProvider.notifier).errorr;
    print(provState);
    if (provState ?? false) {
      setState(() {
        isLoading = false;
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to Eventico'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                alignment: Alignment.center,
                height: 300,
                child: Image.asset('assets/images/MyLogo.jpg'),
              ),
              const SizedBox(
                height: 20,
              ),
              isLogin ? const login.LoginTexts() : const signup.SignUp(),
              isLogin
                  ? const SizedBox(
                      height: 30,
                    )
                  : const SizedBox(
                      height: 4,
                    ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          if (isLogin) {
                            if (login.formKeyLogin.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              login.formKeyLogin.currentState!.save();
                              ref.read(AuthProvider.notifier).sign_in(
                                  email: login.enteredEmail,
                                  password: login.enteredPassword,
                                  context: context);
                              // ref
                              //     .read(AuthProvider.notifier)
                              //     .gettingNamePick(context);
                            }
                          } else {
                            if (signup.formKeyUp.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              signup.formKeyUp.currentState!.save();
                              if (signup.imageF == null) {
                                ScaffoldMessenger.of(context).clearSnackBars();
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text('You must submit an image.')));
                                setState(() {
                                  isLoading = false;
                                });
                                return;
                              }
                              ref.read(AuthProvider.notifier).sign_up(
                                  email: signup.enteredEmail,
                                  password: signup.enteredPassword,
                                  username: signup.enteredUsername,
                                  imageF: signup.imageF,
                                  context: context);
                            }
                          }
                        },
                        child: Text(isLogin
                            ? (isLoading ? "Loading..." : "Sign-in")
                            : (isLoading ? "Loading..." : "Sign-up"))),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                        autofocus: true,
                        onPressed: () {
                          setState(() {
                            isLogin = !isLogin;
                          });
                        },
                        child: Text(isLogin
                            ? "Create Account"
                            : "Already have an Account"))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
