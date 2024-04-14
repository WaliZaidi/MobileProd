// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:frontend/models/user_modal.dart';
import 'package:frontend/screens/home_screen.dart';
import 'package:frontend/screens/settings_screen.dart';
import 'package:frontend/store/store.dart';
import 'package:frontend/theme/theme.dart';
import 'package:frontend/widgets/app_nav_bar.dart';
import 'package:frontend/widgets/loader_bars.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginSignupPage extends StatefulWidget {
  final int dynamicModifierLoginSignupPage;

  const LoginSignupPage(
      {Key? key, required this.dynamicModifierLoginSignupPage})
      : super(key: key);

  @override
  _LoginSignupPageState createState() => _LoginSignupPageState();
}

class _LoginSignupPageState extends State<LoginSignupPage> {
  bool _isLoginForm = true;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _loginformKey = GlobalKey<FormState>();
  final _signupformKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailControllerSignUp = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _passwordControllerSignUp = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _cnicController = TextEditingController();

  Future<void> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await GoogleSignIn().signIn();
      if (googleSignInAccount != null) {
        AppDataStore.currentUser = UserInfo(
          id: googleSignInAccount.id,
          name: googleSignInAccount.displayName!,
          email: googleSignInAccount.email,
          phone: '',
          date: '',
          time: '',
          status: '',
          password: '',
          confirmPassword: '',
          cnic: '',
        );

        print('User logged in successfully');

        LoaderBar.showMessage(context, "User logged in successfully");

        AppDataStore.loggedInNotifier.value = true;

        setState(() {});
      }
    } catch (error) {
      LoaderBar.showMessage(context, "Failed to login user");
      LoaderBar.showMessage(
          context, "Google Sign-In error! Try logging in normally.");

      print('Google Sign-In error: $error');
    }
  }

  void _toggleFormMode() {
    setState(() {
      _isLoginForm = !_isLoginForm;
    });
  }

  Widget _buildLoggedOutPage() {
    return Theme(
      data: CustomTheme.theme,
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Login',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16.0),
              Form(
                key: _loginformKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () async {
                        if (_loginformKey.currentState!.validate()) {
                          LoaderBar.showLoading(context, "Logging in...");
                          bool loggedIn = await AppDataStore.loginUser(
                              _emailController.text, _passwordController.text);
                          if (loggedIn) {
                            if (widget.dynamicModifierLoginSignupPage == 1) {
                              LoaderBar.showMessage(context, "Logged in!");
                              GoRouter.of(context).go('/');
                              setState(() {});
                              AppDataStore.loggedInNotifier.value = true;
                            } else {
                              LoaderBar.showMessage(context, "Logged in!");
                              setState(() {});
                              Navigator.of(context).pop();
                            }
                          } else {
                            LoaderBar.showMessage(
                                context, "Login failed! Try again.");
                          }
                        } else {
                          LoaderBar.showMessage(
                              context, "Login failed! Try again.");
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 0),
                        foregroundColor: Colors.white,
                        backgroundColor: const Color.fromARGB(255, 255, 0, 0),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  const Text(
                    "OR",
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _signInWithGoogle();
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: const BorderSide(color: Colors.black),
                      ),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(width: 8),
                        Text(
                          'Sign in with Google',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(
                color: Colors.black,
                thickness: 1,
              ),
              Row(
                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) {
                          return SingleChildScrollView(
                            padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom,
                            ),
                            child: Form(
                              key: _signupformKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(16.0),
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(color: Colors.grey),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Sign Up',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.close),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text('Name'),
                                        TextFormField(
                                          controller: _nameController,
                                          decoration: const InputDecoration(
                                            labelText: 'Name',
                                            border: OutlineInputBorder(),
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter your name';
                                            }
                                            return null;
                                          },
                                        ),
                                        const SizedBox(height: 16.0),
                                        const Text('Email'),
                                        TextFormField(
                                          controller: _emailControllerSignUp,
                                          decoration: const InputDecoration(
                                            labelText: 'Email',
                                            border: OutlineInputBorder(),
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter your email';
                                            }
                                            return null;
                                          },
                                        ),
                                        const SizedBox(height: 16.0),
                                        const Text('Phone Number'),
                                        TextFormField(
                                          controller: _phoneNumberController,
                                          decoration: const InputDecoration(
                                            labelText: 'Phone Number',
                                            border: OutlineInputBorder(),
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter your phone number';
                                            }
                                            return null;
                                          },
                                        ),
                                        const SizedBox(height: 16.0),
                                        const Text('Password'),
                                        TextFormField(
                                          controller: _passwordControllerSignUp,
                                          decoration: const InputDecoration(
                                            labelText: 'Password',
                                            border: OutlineInputBorder(),
                                          ),
                                          obscureText: true,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter your password';
                                            }
                                            return null;
                                          },
                                        ),
                                        const SizedBox(height: 16.0),
                                        const Text('Confirm Password'),
                                        TextFormField(
                                          controller:
                                              _confirmPasswordController,
                                          decoration: const InputDecoration(
                                            labelText: 'Confirm Password',
                                            border: OutlineInputBorder(),
                                          ),
                                          obscureText: true,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please confirm your password';
                                            }
                                            return null;
                                          },
                                        ),
                                        const SizedBox(height: 16.0),
                                        const Text('CNIC'),
                                        TextFormField(
                                          controller: _cnicController,
                                          decoration: const InputDecoration(
                                            labelText: 'CNIC',
                                            border: OutlineInputBorder(),
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter your CNIC';
                                            }
                                            return null;
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      if (_signupformKey.currentState!
                                          .validate()) {
                                        final name = _nameController.text;
                                        final email =
                                            _emailControllerSignUp.text;
                                        final phoneNumber =
                                            _phoneNumberController.text;
                                        final password =
                                            _passwordControllerSignUp.text;
                                        final confirmPassword =
                                            _confirmPasswordController.text;
                                        final cnic = _cnicController.text;

                                        if (name.isNotEmpty &&
                                            email.isNotEmpty &&
                                            phoneNumber.isNotEmpty &&
                                            password.isNotEmpty &&
                                            confirmPassword.isNotEmpty &&
                                            cnic.isNotEmpty) {
                                          try {
                                            final success =
                                                await AppDataStore.signInUser(
                                              name,
                                              email,
                                              phoneNumber,
                                              password,
                                              confirmPassword,
                                              cnic,
                                            );
                                            print(success);
                                            if (success) {
                                              LoaderBar.showMessage(context,
                                                  "User registered successfully");
                                              Navigator.pop(context);
                                            } else {
                                              LoaderBar.showMessage(context,
                                                  "Failed to register user");
                                            }
                                          } catch (e) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(e.toString()),
                                              ),
                                            );
                                          }
                                        } else {
                                          LoaderBar.showMessage(context,
                                              "Please fill in all fields");
                                        }
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 16.0,
                                      ),
                                      backgroundColor: Colors.black,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: const Text(
                                      'Sign Up',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 32.0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: const BorderSide(color: Colors.black),
                      ),
                    ),
                    child: const Text(
                      'Sign up',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingsScreen(),
                    ),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.settings),
                    Text('Settings'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoggedInPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Logged In',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16.0),
          const Divider(
            color: Colors.black,
            thickness: 1,
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              LoaderBar.showLoading(context, "Logging out...");
              AppDataStore.loggedInNotifier.value = false;
              setState(() {});
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 12), // Adjust padding as needed
              minimumSize: const Size(
                  double.infinity, 28), // Adjust minimumSize as needed
              foregroundColor: Colors.white,
              backgroundColor: const Color.fromARGB(255, 255, 0, 0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            child: const Text(
              'Sign Out',
              style: TextStyle(fontSize: 20),
            ),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsScreen(),
                ),
              );
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.black),
            ),
            child: const Row(
              children: [
                Icon(Icons.settings),
                Text('Settings'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = AppDataStore.loggedInNotifier.value;

    return Theme(
      data: CustomTheme.theme,
      child: Scaffold(
        body: isLoggedIn ? _buildLoggedInPage() : _buildLoggedOutPage(),
        bottomNavigationBar: const AppNavBar(),
      ),
    );
  }
}
