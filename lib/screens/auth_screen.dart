import 'package:flutter/material.dart';
import 'package:flutter_first_app/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLogin = true;

  void _toggleForm() {
    setState(() {
      _isLogin = !_isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(_isLogin ? 'Login' : 'Register'),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedSwitcher(
                duration: Duration(milliseconds: 500),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return ScaleTransition(scale: animation, child: child);
                },
                child: _isLogin ? LoginForm() : RegistrationForm(),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: _toggleForm,
                child: Text(
                  _isLogin
                      ? 'Don\'t have an account? Register'
                      : 'Have an account? Login',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context, listen: false);

    void showErrorSnackbar(String message) {
      final snackBar = SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      );
      // Use ScaffoldMessenger to show the SnackBar
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    void submit() {
      // Here you would make the API call or handle the login logic
      print(
          'Login with: ${_emailController.text}, ${_passwordController.text}');
      // Implement your API call here
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      if (email.isNotEmpty && password.isNotEmpty) {
        // Call login method from authProvider
        authProvider.login(email, password);
      } else {
        showErrorSnackbar('Please enter valid email and password');
        // Show error message
      }
    }

    return Column(
      key: ValueKey('LoginForm'),
      children: <Widget>[
        TextFormField(
          controller: _emailController,
          decoration: InputDecoration(labelText: 'Email'),
        ),
        TextFormField(
          controller: _passwordController,
          decoration: InputDecoration(labelText: 'Password'),
          obscureText: true,
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: submit,
          child: Text('Login'),
        ),
      ],
    );
  }
}

class RegistrationForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      key: ValueKey('RegistrationForm'),
      children: <Widget>[
        TextFormField(
          decoration: InputDecoration(labelText: 'Email'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Password'),
          obscureText: true,
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Confirm Password'),
          obscureText: true,
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            // Implement registration functionality
          },
          child: Text('Register'),
        ),
      ],
    );
  }
}
