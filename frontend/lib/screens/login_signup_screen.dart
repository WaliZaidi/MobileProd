import 'package:flutter/material.dart';
import 'package:frontend/models/user_modal.dart';
import 'package:frontend/screens/home_screen.dart';
import 'package:frontend/screens/settings_screen.dart';
import 'package:frontend/store/store.dart';
import 'package:frontend/theme/theme.dart';
import 'package:frontend/widgets/loader_bars.dart';
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

  // Text editing controllers for email and password fields
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
        AppDataStore.loggedInUser = 'true';

        setState(() {});
      }
    } catch (error) {
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
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  if (widget.dynamicModifierLoginSignupPage == 1) {
                    LoaderBar.showLoading(context, "Logging in...");
                    if (await AppDataStore.loginUser(
                        _emailController.text, _passwordController.text)) {
                      setState(() {});
                      // ignore: use_build_context_synchronously
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
                    }
                  } else {
                    LoaderBar.showLoading(context, "Checking progress...");
                    Navigator.of(context).pop();
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 0),
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromARGB(255, 255, 0, 0),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(height: 16.0),
              const Divider(
                color: Colors.black,
                thickness: 1,
              ),
              ElevatedButton(
                onPressed: _signInWithGoogle,
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
                      'https://1000logos.net/wp-content/uploads/2016/11/New-Google-Logo.jpg', // URL to your Google logo image
                      height: 15, // Adjust the height as needed
                    ),
                    const SizedBox(
                        width: 8), // Add some spacing between the logo and text
                    const Text(
                      'Sign in with Google',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
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
                child: const Row(
                  children: [
                    Icon(Icons.settings), // Changed icon to settings
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
}
