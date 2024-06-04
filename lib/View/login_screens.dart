import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:mymoney/Model/Utils/assets.dart';
import 'package:mymoney/Model/Utils/colors.dart';
import 'package:mymoney/Model/Utils/strings.dart';
import 'package:mymoney/View/register_screens.dart';
import 'package:mymoney/ViewModel/auth_providers.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreens extends StatefulWidget {
  const LoginScreens({super.key});

  @override
  State<LoginScreens> createState() => _LoginScreensState();
}

class _LoginScreensState extends State<LoginScreens> {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _toggleVisibility = true;
  bool checkedValue = false;
  bool isValidEmail = false;
  bool isValidPassword = false;
  bool isOnchange = false;
  bool isOnchangePassword = false;

  Color buttonColor = CustomColor.primary;
  Color buttonDisableColor = CustomColor.greyColor;

  void _loadUsernamePassword() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var username = prefs.getString('email') ?? '';
      var password = prefs.getString('password') ?? '';
      var rememberMe = prefs.getBool('remember_me') ?? false;
      if (rememberMe) {
        setState(() {
          checkedValue = true;
        });
        emailController.text = username;
        passwordController.text = password;
      }
    } catch (e) {
      print(e);
    }
  }

  void actionRememberMe(bool value) {
    checkedValue = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool("remember_me", value);
      prefs.setString('email', emailController.text);
      prefs.setString('password', passwordController.text);
    });
    setState(() {
      checkedValue = value;
    });
  }

  @override
  void initState() {
    _loadUsernamePassword();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.bg,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DView.nothing(),
                  Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                      ),
                      child: Column(
                        children: [
                          Image.asset(
                            AppAsset.logo,
                            height: (ResponsiveBreakpoints.of(context)
                                    .smallerThan(MOBILE))
                                ? 200
                                : 120,
                            width: (ResponsiveBreakpoints.of(context)
                                    .smallerThan(MOBILE))
                                ? 200
                                : 120,
                          ),
                          DView.height(40),
                          TextFormField(
                            controller: emailController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (value) {
                              setState(() {
                                isValidEmail = false;
                                isOnchange = true;
                              });
                              RegExp regex = RegExp(
                                  r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
                              bool isEmailValid = regex.hasMatch(value);
                              if (isEmailValid) {
                                setState(() {
                                  isValidEmail = true;
                                });
                              }
                            },
                            validator: (value) {
                              if (value!.isEmpty && isOnchange) {
                                return Strings.isi;
                              }
                              if (!isValidEmail && isOnchange) {
                                return Strings.format;
                              }
                            },
                            decoration: InputDecoration(
                              fillColor: CustomColor.primary.withOpacity(0.5),
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              hintText: Strings.email,
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 16,
                              ),
                            ),
                          ),
                          DView.height(),
                          TextFormField(
                            controller: passwordController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            onChanged: (value) {
                              if (value!.isEmpty) {
                                setState(() {
                                  isValidPassword = false;
                                });
                                return;
                              }
                              setState(() {
                                isValidPassword = true;
                                isOnchangePassword = true;
                              });
                            },
                            validator: (value) {
                              if (value!.isEmpty && isOnchangePassword) {
                                return Strings.isi;
                              } else {
                                return null;
                              }
                            },
                            obscureText: _toggleVisibility,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              fillColor: CustomColor.primary.withOpacity(0.5),
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              hintText: Strings.password,
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 16,
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _toggleVisibility = !_toggleVisibility;
                                  });
                                },
                                icon: _toggleVisibility
                                    ? const Icon(
                                        Icons.visibility_off,
                                        color: Colors.black,
                                      )
                                    : const Icon(
                                        Icons.visibility,
                                        color: Colors.black,
                                      ),
                              ),
                            ),
                          ),
                          DView.height(),
                          CheckboxListTile(
                            title: Text(
                              Strings.ingat,
                            ),
                            value: checkedValue,
                            onChanged: (newValue) {
                              setState(() {
                                actionRememberMe(newValue!);
                              });
                            },
                            // onChanged: actionRememberMe(checkedValue),
                            controlAffinity: ListTileControlAffinity
                                .leading, //  <-- leading Checkbox
                          ),
                          DView.height(30),
                          Consumer<AuthProviders>(
                            builder: (context, value, child) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                  right: 20,
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    value.login(
                                      context: context,
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim(),
                                    );
                                  },
                                  child: Container(
                                    height: 50.0,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      color: isValidEmail && isValidPassword
                                          ? buttonColor
                                          : buttonDisableColor,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(
                                          10,
                                        ),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        Strings.masuk,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      16,
                      16,
                      16,
                      20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          Strings.belum,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => const RegisterScreens(),
                            );
                            // Get.to(() => const RegisterPage());
                          },
                          child: Text(
                            Strings.daftar,
                            style: const TextStyle(
                              color: CustomColor.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
