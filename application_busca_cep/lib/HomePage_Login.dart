import 'package:application_busca_cep/BuscarCep.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<Login> {
  bool ocultar = true;
  IconData Iconpassword = Icons.visibility;
  final loading = ValueNotifier(false);
  final GlobalKey<FormState> _formKey = GlobalKey();

  // Função de ver a senha
  visibilityPassword() {
    if (ocultar == true) {
      setState(() {
        ocultar = false;
        Iconpassword = Icons.visibility_off;
      });
    } else {
      setState(() {
        ocultar = true;
        Iconpassword = Icons.visibility;
      });
    }
  }

  String email = '';
  String password = '';

  logar() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    if (email == 'teste@gmail.com' && password == '2022') {
      setState(() {
        Navigator.of(context).push(
          //pushReplacement
          MaterialPageRoute(builder: (context) => const BuscarCep()),
        );
      });
    }
  }

  Color buttonHoverColor = const Color(0xff707070);

  void _onEnter(PointerEvent details) {
    setState(() {
      buttonHoverColor = Colors.deepOrange;
    });
  }

  void _onExit(PointerEvent details) {
    setState(() {
      buttonHoverColor = Color(0xff707070);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final bool wIsMobile = size.width < 600;
    final bool hIsMobile = size.height < 600;
    final bool wIsTablet = size.width >= 600 && size.width < 1200;
    final bool hIsTablet = size.height >= 600 && size.height < 767;
    final bool wIsDesktop = size.width >= 1024;
    final bool hIsDesktop = size.height >= 768;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Buscar CEP"),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
      ),
      body: Form(
        key: _formKey,
        child: Stack(
          children: [
            Row(
            children: [
              Container(
                height: double.infinity,
                width: size.width / 2,
                color: Colors.deepOrange,
              ),
              Container(
                height: double.infinity,
                width: size.width / 2,
                color: Colors.white,
              ),
            ],
          ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Login", style: TextStyle(fontSize: 25)),
                    TextFormField(
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Coloque seu e-mail';
                        }
                        return null;
                      },
                      onChanged: (text) {
                        email = text;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: "Digite seu e-mail",
                        prefixIcon: Icon(Icons.email),
                      ),
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: (senha) {
                        if (senha == null || senha.isEmpty) {
                          return 'Coloque sua senha';
                        }
                        return null;
                      },
                      onChanged: (senha) {
                        password = senha;
                      },
                      obscureText: ocultar,
                      decoration: InputDecoration(
                          labelText: "Digite sua senha",
                          prefixIcon: const Icon(
                            Icons.password_sharp,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              visibilityPassword();
                            },
                            icon: Icon(Iconpassword),
                          )
                        ),
                      textInputAction: TextInputAction.done,
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (loading.value) return;
                          setState(() => loading.value = true);
                          await Future.delayed(
                              const Duration(milliseconds: 5000));
                          setState(() => loading.value = false);
                          await logar();
                        },
                        style: ButtonStyle(
                          shape: MaterialStateProperty.resolveWith(
                            (states) => RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          elevation: MaterialStateProperty.all(0.0),
                          backgroundColor: MaterialStateProperty.resolveWith(
                            (states) => Colors.deepOrange,
                          ),
                          padding: MaterialStateProperty.resolveWith(
                            (states) => const EdgeInsets.fromLTRB(32, 16, 32, 16),
                          ),
                        ),
                        child: AnimatedBuilder(
                            animation: loading,
                            builder: (context, _) {
                              return loading.value
                                  ? const MouseRegion(
                                    cursor: SystemMouseCursors.forbidden,
                                    child: SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          valueColor: AlwaysStoppedAnimation<Color>(
                                              Colors.deepOrange),
                                          backgroundColor: Colors.white,
                                          strokeWidth: 5,
                                        ),
                                      ),
                                  )
                                  : const Text("Entrar no App");
                            }),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: wIsMobile
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  "Não possui conta? ",
                                  style: TextStyle(
                                    color: Color(0xff707070),
                                    fontSize: 14,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    onEnter: _onEnter,
                                    onExit: _onExit,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Text("Cadastre-se",
                                            style: TextStyle(
                                              color: Colors.deepOrange,
                                              fontSize: 14,
                                            )),
                                        const SizedBox(width: 3),
                                        Icon(
                                          Icons.email_outlined,
                                          color: buttonHoverColor,
                                          size: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Não possui conta? ",
                                  style: TextStyle(
                                      color: Color(0xff707070), fontSize: 14),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    // Get.offAndToNamed("/sigUpWeb");
                                  },
                                  child: MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    onEnter: _onEnter,
                                    onExit: _onExit,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Text("Cadastre-se",
                                            style: TextStyle(
                                              color: Colors.deepOrange,
                                              fontSize: 14,
                                            )),
                                        const SizedBox(width: 3),
                                        Icon(
                                          Icons.email_outlined,
                                          color: buttonHoverColor,
                                          size: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
