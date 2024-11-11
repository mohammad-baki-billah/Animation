import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class RiveLoginScreen extends StatefulWidget {
  const RiveLoginScreen({super.key});

  @override
  State<RiveLoginScreen> createState() => _RiveLoginScreenState();
}

class _RiveLoginScreenState extends State<RiveLoginScreen> {
  SMIInput<bool>? isChecking;
  SMINumber? numLook;
  SMIInput<bool>? isHandsUp;
  SMIInput<bool>? trigSuccess;
  SMIInput<bool>? trigFail;

  StateMachineController? stateMachineController;

  final _formKey = GlobalKey<FormState>();

  // Define the function to handle failed check animation
  void isCheckFailed() {
    isChecking?.change(true);
    isHandsUp?.change(false);
    trigFail?.change(true);
    trigSuccess?.change(false);
    numLook?.change(0);
  }

  // Define function to move eyeball animation
  void moveEyesBall(String value) {
    numLook?.change(value.length.toDouble());
  }

  // Define function to trigger the hands-up animation for password
  void hidePassword() {
    isHandsUp?.change(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 300,
              child: RiveAnimation.asset(
                  'assets/images/animated_login_character.riv',
                  stateMachines: const ['Login Machine'], onInit: (artBoard) {
                stateMachineController = StateMachineController.fromArtboard(
                    artBoard, 'Login Machine');

                if (stateMachineController != null) {
                  artBoard.addController(stateMachineController!);
                  isChecking =
                      stateMachineController?.findInput<bool>('isChecking');
                  isHandsUp =
                      stateMachineController?.findInput<bool>('isHandsUp');
                  trigSuccess =
                      stateMachineController?.findInput<bool>('trigSuccess');
                  trigFail =
                      stateMachineController?.findInput<bool>('trigFail');
                  numLook = stateMachineController!.findInput<double>('numLook')
                      as SMINumber?;
                }
              }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                alignment: Alignment.center,
                width: 400,
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.grey, blurRadius: 5, spreadRadius: 5)
                  ],
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Form(
                    key: _formKey, // Attach the form key
                    child: Column(
                      children: [
                        TextFormField(
                          onChanged: moveEyesBall,
                          onTap: isCheckFailed,
                          style: const TextStyle(fontSize: 20),
                          keyboardType: TextInputType.emailAddress,
                          cursorColor: const Color.fromARGB(255, 176, 72, 99),
                          decoration: const InputDecoration(
                              labelText: 'Email',
                              hintText: 'Email',
                              labelStyle: TextStyle(
                                color: Color.fromARGB(255, 176, 72, 99),
                                fontSize: 20,
                              ),
                               border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 176, 72, 99),
                                  width: 2),
                            ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 176, 72, 99),
                                    width: 2),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 176, 72, 99),
                                    width: 2),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 176, 72, 99),
                                    width: 2),
                              )),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          onTap: hidePassword,
                          style: const TextStyle(fontSize: 20),
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          cursorColor: const Color.fromARGB(255, 176, 72, 99),
                          decoration: const InputDecoration(
                            labelText: 'Password',
                            hintText: 'Password',
                            labelStyle: TextStyle(
                              color: Color.fromARGB(255, 176, 72, 99),
                              fontSize: 20,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 176, 72, 99),
                                  width: 2),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 176, 72, 99),
                                  width: 2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 176, 72, 99),
                                  width: 2),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 176, 72, 99),
                                  width: 2),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            } else if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        Container(
                          height: 50,
                          width: 300,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.pink),
                          child: Center(
                            child: InkWell(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  isChecking?.change(true);
                                  isHandsUp?.change(false);
                                  trigSuccess?.change(true);
                                  trigFail?.change(false);
                                  numLook?.change(0);
                                } else {
                                  isCheckFailed();
                                }
                              },
                              child: const Text(
                                'LogIn',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
