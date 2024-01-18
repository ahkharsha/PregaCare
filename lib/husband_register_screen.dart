import 'package:flutter/material.dart';
import 'package:pregacare/buttons/sub_button.dart';
import 'package:pregacare/login_screen.dart';
import 'package:pregacare/utils/constants.dart';
import 'package:pregacare/buttons/main_button.dart';
import 'package:pregacare/widgets/home/bottom_page.dart';
import 'package:pregacare/widgets/textfield.dart';

class HusbandRegisterScreen extends StatefulWidget {
  @override
  State<HusbandRegisterScreen> createState() => _HusbandRegisterScreenState();
}

class _HusbandRegisterScreenState extends State<HusbandRegisterScreen> {
  bool isPasswordHidden = true;
  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();

  _onSubmit() {
    _formKey.currentState!.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Husband User Register',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Image.asset(
                        'assets/images/login/husband.png',
                        height: 100,
                        width: 100,
                      ),
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomTextField(
                          hintText: 'Enter Name',
                          textInputAction: TextInputAction.next,
                          keyboardtype: TextInputType.name,
                          prefix: Icon(Icons.person),
                          onsave: (name) {
                            _formData['name'] = name ?? '';
                          },
                          // validate: (name) {
                          //   if (name!.isEmpty || name.length < 2) {
                          //     return 'Name should contain atleast 2 characters';
                          //   } else {
                          //     return null;
                          //   }
                          // },
                        ),
                        CustomTextField(
                          hintText: 'Enter Phone',
                          textInputAction: TextInputAction.next,
                          keyboardtype: TextInputType.phone,
                          prefix: Icon(Icons.phone),
                          onsave: (phone) {
                            _formData['phone'] = phone ?? '';
                          },
                          // validate: (phone) {
                          //   if (phone!.isEmpty || phone.length < 10) {
                          //     return 'Phone number should contain 10 digits';
                          //   } else {
                          //     return null;
                          //   }
                          // },
                        ),
                        CustomTextField(
                          hintText: 'Enter Email',
                          textInputAction: TextInputAction.next,
                          keyboardtype: TextInputType.emailAddress,
                          prefix: Icon(Icons.alternate_email_rounded),
                          onsave: (email) {
                            _formData['email'] = email ?? '';
                          },
                          // validate: (email) {
                          //   if (email!.isEmpty ||
                          //       email.length < 3 ||
                          //       !email.contains('@')) {
                          //     return 'Enter correct email';
                          //   } else {
                          //     return null;
                          //   }
                          // },
                        ),
                        CustomTextField(
                          hintText: 'Enter Emergency mail',
                          textInputAction: TextInputAction.next,
                          keyboardtype: TextInputType.emailAddress,
                          prefix: Icon(Icons.alternate_email_rounded),
                          onsave: (emergency_email) {
                            _formData['emergency_email'] = emergency_email ?? '';
                          },
                          // validate: (emergency_email) {
                          //   if (emergency_email!.isEmpty ||
                          //       emergency_email.length < 3 ||
                          //       !emergency_email.contains('@')) {
                          //     return 'Enter correct email';
                          //   } else {
                          //     return null;
                          //   }
                          // },
                        ),
                        CustomTextField(
                          hintText: 'Enter Password',
                          isPassword: isPasswordHidden,
                          prefix: Icon(Icons.vpn_key_rounded),
                          onsave: (password) {
                            _formData['password'] = password ?? '';
                          },
                          suffix: IconButton(
                              onPressed: () {
                                setState(() {
                                  isPasswordHidden = !isPasswordHidden;
                                });
                              },
                              icon: isPasswordHidden
                                  ? Icon(Icons.visibility)
                                  : Icon(Icons.visibility_off)),
                          // validate: (password) {
                          //   if (password!.isEmpty || password.length < 8) {
                          //     return 'Enter correct password';
                          //   } else {
                          //     return null;
                          //   }
                          // },
                        ),
                        CustomTextField(
                          hintText: 'Retype Password',
                          isPassword: isPasswordHidden,
                          prefix: Icon(Icons.vpn_key_rounded),
                          onsave: (re_password) {
                            _formData['re_password'] = re_password ?? '';
                          },
                          suffix: IconButton(
                              onPressed: () {
                                setState(() {
                                  isPasswordHidden = !isPasswordHidden;
                                });
                              },
                              icon: isPasswordHidden
                                  ? Icon(Icons.visibility)
                                  : Icon(Icons.visibility_off)),
                          // validate: (re_password) {
                          //   if (re_password!.isEmpty ||
                          //       re_password.length < 8) {
                          //     return 'Retype correct password';
                          //   } else {
                          //     return null;
                          //   }
                          // },
                        ),
                        MainButton(
                            title: 'Register',
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _onSubmit();
                              }
                              goTo(context, BottomPage());
                            }),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SubButton(
                          title: 'Already have an account? Login',
                          onPressed: () {
                            goTo(context, LoginScreen());
                          }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
