import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: FormExample()));
}

class FormExample extends StatefulWidget {
  @override
  FormExampleState createState() => FormExampleState();
}

class FormExampleState extends State<FormExample> {
  // 1. Create a GlobalKey for the form
  final formKey = GlobalKey<FormState>();

  // 2. Create controllers to retrieve values
  final nameController = TextEditingController();
  final emailController = TextEditingController();

  // 3. Dispose controllers
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  void submitForm() {
    // 4. Validate and submit
    if (formKey.currentState!.validate()) {
      String name = nameController.text;
      String email = emailController.text;

      // Example: Show a snackbar or send to API
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Submitting: $name, $email")));

      nameController.clear();
      emailController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flutter Form Example")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: formKey, // Attach the key
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Name"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your name";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: "Email"),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your email";
                  }
                  if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                    return "Please enter a valid email";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(onPressed: submitForm, child: Text("Submit")),
            ],
          ),
        ),
      ),
    );
  }
}
