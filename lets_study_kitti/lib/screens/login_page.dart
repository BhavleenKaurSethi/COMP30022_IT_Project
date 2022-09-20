import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:lets_study_kitti/Main.dart';
import 'package:lets_study_kitti/routes.dart';
import 'package:lets_study_kitti/screens/review_form.dart';
import 'package:lets_study_kitti/screens/review_form_page.dart';

const outlineColor = Color.fromARGB(100, 0, 0, 0);
const boxColor = Color.fromARGB(255, 254, 244, 225);
const boundarySize = 300.0;
const hOffset = 80.0;
const boxWidth = 250.0;
const boxHeight = 50.0;
const vOffset = 20.0;
const sectionFont = TextStyle(fontSize: 24);
const labelFont = TextStyle(fontSize: 16);
const linkFont = TextStyle(fontSize: 16, decoration: TextDecoration.underline);

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  bool isLoading = false;
  bool error = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: ListView(shrinkWrap: true, children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              padding: const EdgeInsets.fromLTRB(0, 25, 0, 25),
              child: const Text("Let's Study Kitti",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
            ),
          ),
          Center(
              child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width - 2 * boundarySize,
                  child: Card(
                      elevation: 10,
                      child: Column(children: [
                        FormBuilder(
                            key: _formKey,
                            child: ListView(shrinkWrap: true, children: [
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          hOffset, 2 * vOffset, 0, 10),
                                      child: const Text('Log In',
                                          style: sectionFont))),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: hOffset, vertical: vOffset),
                                alignment: Alignment.centerLeft,
                                child: Container(
                                    height: boxHeight,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    decoration: const BoxDecoration(
                                      color: boxColor,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    ),
                                    child: FormBuilderTextField(
                                        cursorColor: Colors.black,
                                        name: 'email',
                                        decoration: const InputDecoration(
                                          hintText: "email",
                                          hintStyle: labelFont,
                                          contentPadding: EdgeInsets.only(
                                              top: 5.0, bottom: 5.0),
                                          border: InputBorder.none,
                                        ),
                                        validator:
                                            FormBuilderValidators.compose([
                                          FormBuilderValidators.required(),
                                          FormBuilderValidators.email(),
                                        ]))),
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                    left: hOffset,
                                    right: hOffset,
                                    bottom: vOffset),
                                alignment: Alignment.centerLeft,
                                child: Container(
                                    height: boxHeight,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    decoration: const BoxDecoration(
                                      color: boxColor,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    ),
                                    child: FormBuilderTextField(
                                        cursorColor: Colors.black,
                                        name: 'password',
                                        decoration: const InputDecoration(
                                          hintText: "password",
                                          hintStyle: labelFont,
                                          contentPadding: EdgeInsets.only(
                                              top: 5.0, bottom: 5.0),
                                          border: InputBorder.none,
                                        ),
                                        validator:
                                            FormBuilderValidators.compose([
                                          FormBuilderValidators.required(),
                                        ]))),
                              ),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        width: boxWidth,
                                        padding:
                                            const EdgeInsets.only(bottom: 20.0),
                                        child: Container(
                                            decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    255, 250, 172, 26),
                                                border: Border.all(
                                                    color: outlineColor)),
                                            child: isLoading
                                                ? const LinearProgressIndicator(
                                                    color: Colors.orange,
                                                    backgroundColor:
                                                        Colors.white)
                                                : MaterialButton(
                                                    child: const Text("LOG IN",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        )),
                                                    onPressed: () async {
                                                      setState(() {
                                                        isLoading = true;
                                                      });
                                                      final validationSuccess =
                                                          _formKey.currentState!
                                                              .validate();
                                                      if (validationSuccess ==
                                                          true) {
                                                        _formKey.currentState
                                                            ?.save();
                                                        try {
                                                          await FirebaseAuth
                                                              .instance
                                                              .signInWithEmailAndPassword(
                                                                  email: _formKey
                                                                          .currentState
                                                                          ?.value[
                                                                      'email'],
                                                                  password: _formKey
                                                                          .currentState
                                                                          ?.value[
                                                                      'password']);
                                                        } on FirebaseAuthException catch (e) {
                                                          error = true;
                                                          if (e.code ==
                                                              'user-not-found') {
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                barrierDismissible:
                                                                    false, // disables popup to close if tapped outside popup (need a button to close)
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  return AlertDialog(
                                                                    title:
                                                                        const Text(
                                                                      "Log In Unsuccessful",
                                                                    ),
                                                                    content:
                                                                        const Text(
                                                                            "User Not Found"),
                                                                    //buttons?
                                                                    actions: <
                                                                        Widget>[
                                                                      MaterialButton(
                                                                        child: const Text(
                                                                            "Close"),
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                        }, //closes popup
                                                                      ),
                                                                    ],
                                                                  );
                                                                });
                                                          } else if (e.code ==
                                                              'wrong-password') {
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                barrierDismissible:
                                                                    false, // disables popup to close if tapped outside popup (need a button to close)
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  return AlertDialog(
                                                                    title:
                                                                        const Text(
                                                                      "Log In Unsuccessful",
                                                                    ),
                                                                    content:
                                                                        const Text(
                                                                            "Wrong Password"),
                                                                    //buttons?
                                                                    actions: <
                                                                        Widget>[
                                                                      MaterialButton(
                                                                        child: const Text(
                                                                            "Close"),
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                        }, //closes popup
                                                                      ),
                                                                    ],
                                                                  );
                                                                });
                                                          }
                                                        }

                                                        setState(() {
                                                          isLoading = false;
                                                        });
                                                      } else {
                                                        error = true;
                                                        debugPrint(_formKey
                                                            .currentState?.value
                                                            .toString());
                                                        debugPrint(
                                                            'validation failed');
                                                        setState(() {
                                                          isLoading = false;
                                                        });
                                                      }
                                                      if (!mounted || error) {
                                                        error = false;
                                                        return;
                                                      }
                                                      Navigator.pushNamed(
                                                          context,
                                                          Routes
                                                              .reviewFormPage);
                                                    })))
                                  ]),
                              Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: hOffset),
                                  child: const Text(
                                    "don't have an account? Sign Up",
                                    style: linkFont,
                                  )),
                              Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: hOffset),
                                  child: const Text(
                                    "forgot your password?",
                                    style: linkFont,
                                  )),
                              const SizedBox(height: 2 * vOffset)
                            ]))
                      ]))))
        ]));
  }
}
