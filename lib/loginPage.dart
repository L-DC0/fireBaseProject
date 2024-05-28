import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:filezy/thirdPage.dart';

class SecondScreen extends StatefulWidget {
  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool submiting = false;
  Future<void> loginOrRegister() async {
    try {
      setState(() {
        submiting = true;
      });
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _usernameController.text,
        password: _passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        try {
          final credential =
              await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _usernameController.text,
            password: _passwordController.text,
          );
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            print('No user found for that email.');
          } else if (e.code == 'wrong-password') {
            print('Wrong password provided for that user.');
          }
        }
      }
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        submiting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 34, 82, 253),
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          backgroundColor: const Color.fromARGB(255, 34, 82, 253),
          title: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //padding: const EdgeInsets.all(4.0),
                Image.asset(
                  "assets/icons/folder.png",
                  fit: BoxFit.contain,
                  height: 32,
                ),
                const Text(
                  "Filezy",
                  style: TextStyle(
                      fontSize: 28,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          actions: const [
            SizedBox(
              width: 50,
              height: 50,
            )
          ],
        ),
        body: ListView(
          children: [
            // add sizeBox to give space on the top
            SizedBox(
              height: size.height * 0.02,
            ),
            Container(
              height: size.height,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Container(
                      width: size.width,
                      height: size.height * 0.075,
                      decoration: BoxDecoration(
                          color: const Color(0xFFf2f2f2),
                          borderRadius: BorderRadius.circular(25)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: size.width * 0.42,
                              decoration: BoxDecoration(
                                  color: const Color(0xFF2252fd),
                                  borderRadius: BorderRadius.circular(15)),
                              child: const Center(
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: size.width * 0.42,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15)),
                              child: const Center(
                                child: Text(
                                  "Register",
                                  style: TextStyle(
                                    color: Color(0xFF2252fd),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.045,
                    ),
                    const Row(
                      children: [
                        Text(
                          "Username or Email",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.black54),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    // form field
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(),
                          ),
                          TextFormField(
                            controller: _usernameController,
                            decoration: const InputDecoration(
                              fillColor: Color(0xFFf2f2f2),
                              filled: true,
                              hintText: "username ",
                              hintStyle: TextStyle(
                                color: Colors.black54,
                                fontSize: 14,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your username or email';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          const Row(
                            children: [
                              Text(
                                "Password",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black54),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          TextFormField(
                            obscureText: true,
                            controller: _passwordController,
                            decoration: const InputDecoration(
                              fillColor: Color(0xFFf2f2f2),
                              filled: true,
                              hintText: "Enter your password",
                              hintStyle: TextStyle(
                                color: Colors.black54,
                                fontSize: 14,
                              ),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          SizedBox(
                            width: size.width * 0.9,
                            height: size.height * 0.06,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                //primary: const Color(0xFF2252fd),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                backgroundColor: const Color(0xFF2252fd),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  // If the form is valid, display a Snackbar.
                                  // ScaffoldMessenger.of(context)
                                  //     .showSnackBar(SnackBar(content: Text('Processing Data')));
                                  // TODO: Implement your form submission logic.
                                  await loginOrRegister();
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      transitionDuration: Duration(seconds: 1),
                                      pageBuilder: (context, animation,
                                              secondaryAnimation) =>
                                          ThirdPage(),
                                      transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) {
                                        var begin = Offset(1.0, 0.0);
                                        var end = Offset.zero;
                                        var curve = Curves.easeInOutBack;

                                        var tween = Tween(
                                                begin: begin, end: end)
                                            .chain(CurveTween(curve: curve));

                                        return SlideTransition(
                                          position: animation.drive(tween),
                                          child: child,
                                        );
                                      },
                                    ),
                                  );
                                }
                              },
                              child: Center(
                                child: submiting
                                    ? CircularProgressIndicator()
                                    : Text(
                                        "Login",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.04,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: size.width * 0.4,
                          child: Divider(
                            color: Colors.grey,
                            height: 2,
                          ),
                        ),
                        Text(
                          "  or  ",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Container(
                          width: size.width * 0.4,
                          child: Divider(
                            color: Colors.grey,
                            height: 2,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.04,
                    ),
                    LoginOptions(
                      size: size,
                      loginOption: "Continue with Google",
                      image: "assets/icons/google.png",
                    ),
                    SizedBox(
                      height: size.height * 0.04,
                    ),
                    LoginOptions(
                      size: size,
                      loginOption: "Continue with Facebook",
                      image: "assets/icons/facebook.png",
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}

class LoginOptions extends StatelessWidget {
  const LoginOptions({
    super.key,
    required this.size,
    required this.loginOption,
    required this.image,
  });

  final Size size;
  final String loginOption;
  final String image;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: size.height * 0.07,
      decoration: BoxDecoration(
        //color: const Color(0xFF2252fd),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: const Color(0xffe3e0e0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.asset(
              image,
              fit: BoxFit.contain,
              height: 32,
            ),
          ),
          Text(
            loginOption,
            style: TextStyle(
              color: Colors.black54,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
