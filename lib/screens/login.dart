import 'package:flutter/material.dart';

class loginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(80),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome',
                style: Theme.of(context).textTheme.headline1,
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: 'User name'),
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: 'Password'),
                obscureText: true,
              ),
              const SizedBox(
                height: 24,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/catalog');
                  },
                  child: const Text("Enter")),
            ],
          ),
        ),
      ),
    );
  }
}
