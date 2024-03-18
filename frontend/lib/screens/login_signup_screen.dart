// // ignore_for_file: use_build_context_synchronously

// import 'package:flutter/material.dart';
// import 'package:frontend/models/user_modal.dart';
// import 'package:frontend/screens/home_screen.dart';
// import 'package:frontend/screens/settings_screen.dart';
// import 'package:frontend/store/store.dart';
// import 'package:frontend/theme/theme.dart';
// import 'package:frontend/widgets/app_nav_bar.dart';
// import 'package:frontend/widgets/loader_bars.dart';
// import 'package:go_router/go_router.dart';
// // import 'package:google_sign_in/google_sign_in.dart';

// class LoginSignupPage extends StatefulWidget {
//   final int dynamicModifierLoginSignupPage;

//   const LoginSignupPage(
//       {Key? key, required this.dynamicModifierLoginSignupPage})
//       : super(key: key);

//   @override
//   _LoginSignupPageState createState() => _LoginSignupPageState();
// }

// class _LoginSignupPageState extends State<LoginSignupPage> {
//   bool _isLoginForm = true;

//   // Text editing controllers for email and password fields
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   final _nameController = TextEditingController();
//   final _emailControllerSignUp = TextEditingController();
//   final _phoneNumberController = TextEditingController();
//   final _passwordControllerSignUp = TextEditingController();
//   final _confirmPasswordController = TextEditingController();
//   final _cnicController = TextEditingController();

//   void _toggleFormMode() {
//     setState(() {
//       _isLoginForm = !_isLoginForm;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Theme(
//       data: CustomTheme.theme,
//       child: Scaffold(
//         appBar: AppBar(),
//         body: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               const Text(
//                 'Login',
//                 style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 16.0),
//               TextFormField(
//                 controller: _emailController,
//                 decoration: const InputDecoration(
//                   labelText: 'Email',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 16.0),
//               TextFormField(
//                 controller: _passwordController,
//                 decoration: const InputDecoration(
//                   labelText: 'Password',
//                   border: OutlineInputBorder(),
//                 ),
//                 obscureText: true,
//               ),
//               const SizedBox(height: 16.0),
//               ElevatedButton(
//                 onPressed: () async {
//                   if (widget.dynamicModifierLoginSignupPage == 1) {
//                     LoaderBar.showLoading(context, "Logging in...");
//                     if (await AppDataStore.loginUser(
//                         _emailController.text, _passwordController.text)) {
//                       setState(() {});
//                       // ignore: use_build_context_synchronously
//                       GoRouter.of(context).go('/');
//                     }
//                   } else {
//                     LoaderBar.showLoading(context, "Checking progress...");
//                     Navigator.of(context).pop();
//                   }
//                 },
//                 style: ElevatedButton.styleFrom(
//                   minimumSize: const Size(double.infinity, 0),
//                   foregroundColor: Colors.white,
//                   backgroundColor: const Color.fromARGB(255, 255, 0, 0),
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(24),
//                   ),
//                 ),
//                 child: const Text(
//                   'Login',
//                   style: TextStyle(fontSize: 20),
//                 ),
//               ),
//               const SizedBox(height: 16.0),
//               Row(
//                 children: [
//                   const Text(
//                     "OR",
//                     style: TextStyle(fontSize: 16),
//                   ),
//                   const SizedBox(
//                     width: 8,
//                   ),
//                   ElevatedButton(
//                     onPressed: () {},
//                     style: ElevatedButton.styleFrom(
//                       foregroundColor: Colors.black,
//                       backgroundColor: const Color.fromARGB(255, 255, 255, 255),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                         side: const BorderSide(color: Colors.black),
//                       ),
//                     ),
//                     child: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Image.network(
//                           'https://1000logos.net/wp-content/uploads/2016/11/New-Google-Logo.jpg', // URL to your Google logo image
//                           height: 15, // Adjust the height as needed
//                         ),
//                         const SizedBox(
//                             width:
//                                 8), // Add some spacing between the logo and text
//                         const Text(
//                           'Sign in with Google',
//                           style: TextStyle(fontSize: 16),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               const Divider(
//                 color: Colors.black,
//                 thickness: 1,
//               ),
//               Row(
//                 children: [
//                   const Text(
//                     "Don't have an account?",
//                     style: TextStyle(fontSize: 16),
//                   ),
//                   const SizedBox(
//                     width: 12,
//                   ),
//                   ElevatedButton(
//                     onPressed: () {
//                       showModalBottomSheet(
//                         context: context,
//                         isScrollControlled: true,
//                         builder: (context) {
//                           return SingleChildScrollView(
//                             padding: EdgeInsets.only(
//                               bottom: MediaQuery.of(context).viewInsets.bottom,
//                             ),
//                             child: Form(
//                               key: _formKey,
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                                 children: [
//                                   Container(
//                                     padding: const EdgeInsets.all(16.0),
//                                     decoration: const BoxDecoration(
//                                       border: Border(
//                                         bottom: BorderSide(color: Colors.grey),
//                                       ),
//                                     ),
//                                     child: const Text(
//                                       'Sign Up',
//                                       style: TextStyle(
//                                         fontSize: 20,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.all(16.0),
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         const Text('Name'),
//                                         TextFormField(
//                                           controller: _nameController,
//                                           // Add your text field properties here
//                                         ),
//                                         const SizedBox(height: 16.0),
//                                         const Text('Email'),
//                                         TextFormField(
//                                           controller: _emailControllerSignUp,
//                                           // Add your text field properties here
//                                         ),
//                                         const SizedBox(height: 16.0),
//                                         const Text('Phone Number'),
//                                         TextFormField(
//                                           controller: _phoneNumberController,
//                                           // Add your text field properties here
//                                         ),
//                                         const SizedBox(height: 16.0),
//                                         const Text('Password'),
//                                         TextFormField(
//                                           controller: _passwordControllerSignUp,
//                                           // Add your text field properties here
//                                           obscureText: true,
//                                         ),
//                                         const SizedBox(height: 16.0),
//                                         const Text('Confirm Password'),
//                                         TextFormField(
//                                           controller:
//                                               _confirmPasswordController,
//                                           // Add your text field properties here
//                                           obscureText: true,
//                                         ),
//                                         const SizedBox(height: 16.0),
//                                         const Text('CNIC'),
//                                         TextFormField(
//                                           controller: _cnicController,
//                                           // Add your text field properties here
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   ElevatedButton(
//                                     onPressed: () async {
//                                       if (_formKey.currentState!.validate()) {
//                                         final name = _nameController.text;
//                                         final email =
//                                             _emailControllerSignUp.text;
//                                         final phoneNumber =
//                                             _phoneNumberController.text;
//                                         final password =
//                                             _passwordControllerSignUp.text;
//                                         final confirmPassword =
//                                             _confirmPasswordController.text;
//                                         final cnic = _cnicController.text;

//                                         if (name.isNotEmpty &&
//                                             email.isNotEmpty &&
//                                             phoneNumber.isNotEmpty &&
//                                             password.isNotEmpty &&
//                                             confirmPassword.isNotEmpty &&
//                                             cnic.isNotEmpty) {
//                                           try {
//                                             final success =
//                                                 await AppDataStore.signInUser(
//                                               name,
//                                               email,
//                                               phoneNumber,
//                                               password,
//                                               confirmPassword,
//                                               cnic,
//                                             );
//                                             print(success);
//                                             if (success) {
//                                               LoaderBar.showMessage(context,
//                                                   "User registered successfully");
//                                               Navigator.pop(context);
//                                             } else {
//                                               LoaderBar.showMessage(context,
//                                                   "Failed to register user");
//                                             }
//                                           } catch (e) {
//                                             ScaffoldMessenger.of(context)
//                                                 .showSnackBar(
//                                               SnackBar(
//                                                 content: Text(e.toString()),
//                                               ),
//                                             );
//                                           }
//                                         } else {
//                                           LoaderBar.showMessage(context,
//                                               "Please fill in all fields");
//                                         }
//                                       }
//                                     },
//                                     style: ElevatedButton.styleFrom(
//                                       padding: const EdgeInsets.symmetric(
//                                         vertical: 16.0,
//                                       ),
//                                       backgroundColor: Colors.black,
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(8),
//                                       ),
//                                     ),
//                                     child: const Text(
//                                       'Sign Up',
//                                       style: TextStyle(
//                                         fontSize: 16,
//                                         color: Colors.white,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           );
//                         },
//                       );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       foregroundColor: Colors.black,
//                       backgroundColor: Colors.white,
//                       padding: const EdgeInsets.symmetric(
//                         vertical: 16.0,
//                         horizontal: 32.0,
//                       ),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                         side: const BorderSide(color: Colors.black),
//                       ),
//                     ),
//                     child: const Text(
//                       'Sign up',
//                       style: TextStyle(fontSize: 16),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 36.0),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => const SettingsScreen(),
//                     ),
//                   );
//                 },
//                 child: const Row(
//                   children: [
//                     Icon(Icons.settings), // Changed icon to settings
//                     Text('Settings'),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//         bottomNavigationBar: const AppNavBar(),
//       ),
//     );
//   }
// }

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

  @override
  Widget build(BuildContext context) {
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
                            LoaderBar.showMessage(context, "Logged in!");
                            setState(() {});
                            GoRouter.of(context).go('/');
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
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.network(
                          'https://1000logos.net/wp-content/uploads/2016/11/New-Google-Logo.jpg',
                          height: 15,
                        ),
                        const SizedBox(width: 8),
                        const Text(
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
        bottomNavigationBar: const AppNavBar(),
      ),
    );
  }
}
