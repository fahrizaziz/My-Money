import 'package:d_view/d_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mymoney/Model/Utils/assets.dart';
import 'package:mymoney/Model/Utils/colors.dart';
import 'package:mymoney/Model/Utils/strings.dart';
import 'package:responsive_framework/responsive_framework.dart';

class RegisterScreens extends StatefulWidget {
  const RegisterScreens({super.key});

  @override
  State<RegisterScreens> createState() => _RegisterScreensState();
}

class _RegisterScreensState extends State<RegisterScreens> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool valid = false;
  bool isValidEmail = false;
  bool isOnchange = false;
  bool isValidPassword = false;
  bool isOnchangePassword = false;
  bool _toggleVisibility = true;

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        height:
            (ResponsiveBreakpoints.of(context).smallerThan(MOBILE)) ? 200 : 500,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.close,
                  ),
                ),
              ],
            ),
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
                          : 100,
                    ),
                    DView.height(40),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: TextFormField(
                        controller: nameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return Strings.isi;
                          }
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          fillColor: CustomColor.primary.withOpacity(0.5),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          hintText: Strings.nama,
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 16,
                          ),
                        ),
                      ),
                    ),
                    DView.height(),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: TextFormField(
                        controller: emailController,
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
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        style: const TextStyle(color: Colors.white),
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
                    ),
                    DView.height(),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: TextFormField(
                        controller: passwordController,
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
                        autovalidateMode: AutovalidateMode.onUserInteraction,
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
                    ),
                    DView.height(30),
                    Container(
                      color: CustomColor.secondary,
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: Material(
                        color: CustomColor.primary,
                        borderRadius: BorderRadius.circular(10),
                        child: InkWell(
                          // onTap: () => register(),
                          onTap: () {},
                          borderRadius: BorderRadius.circular(10),
                          child: Center(
                            child: Text(
                              Strings.daftar,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
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
