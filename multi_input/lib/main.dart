import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: MultiInputForm()));

class MultiInputForm extends StatefulWidget {
  @override
  _MultiInputFormState createState() => _MultiInputFormState();
}

class _MultiInputFormState extends State<MultiInputForm> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  String? _selectedGender;
  DateTime? _selectedDate;
  String? _maritalStatus;
  double _userRating = 5.0;
  Map<String, bool> _interests = {
    'Reading': false,
    'Music': false,
    'Sports': false,
    'Travel': false,
  };

  // 🗓️ Date Picker
  Future<void> _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      List<String> selectedInterests =
          _interests.entries
              .where((entry) => entry.value)
              .map((entry) => entry.key)
              .toList();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Form submitted successfully!"),
          duration: Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.green,
        ),
      );

      showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              title: Text("Form Submitted"),
              content: Text(
                "Name: ${_nameController.text}\n"
                "Gender: $_selectedGender\n"
                "DOB: ${_selectedDate?.toLocal().toString().split(' ')[0] ?? "Not selected"}\n"
                "Marital Status: $_maritalStatus\n"
                "Rating: $_userRating\n"
                "Interests: ${selectedInterests.join(', ')}",
              ),
              actions: [
                TextButton(
                  child: Text("OK"),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Multi-Input Form")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: "Name"),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Enter your name'
                            : null,
              ),
              SizedBox(height: 16),

              DropdownButtonFormField<String>(
                value: _selectedGender,
                decoration: InputDecoration(labelText: "Gender"),
                items:
                    ['Male', 'Female', 'Other']
                        .map(
                          (gender) => DropdownMenuItem(
                            value: gender,
                            child: Text(gender),
                          ),
                        )
                        .toList(),
                onChanged: (value) => setState(() => _selectedGender = value),
                validator: (value) => value == null ? 'Select a gender' : null,
              ),
              SizedBox(height: 16),

              // 🗓️ Date Picker
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? "No date chosen!"
                          : "Date of Birth: ${_selectedDate!.toLocal().toString().split(' ')[0]}",
                    ),
                  ),
                  TextButton(onPressed: _pickDate, child: Text("Pick Date")),
                ],
              ),
              SizedBox(height: 16),

              // 🔘 Radio buttons
              Text(
                "Marital Status:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              RadioListTile<String>(
                title: Text("Single"),
                value: "Single",
                groupValue: _maritalStatus,
                onChanged: (value) => setState(() => _maritalStatus = value),
              ),
              RadioListTile<String>(
                title: Text("Married"),
                value: "Married",
                groupValue: _maritalStatus,
                onChanged: (value) => setState(() => _maritalStatus = value),
              ),
              RadioListTile<String>(
                title: Text("Other"),
                value: "Other",
                groupValue: _maritalStatus,
                onChanged: (value) => setState(() => _maritalStatus = value),
              ),
              SizedBox(height: 16),

              // ☑️ Checkboxes
              Text("Interests:", style: TextStyle(fontWeight: FontWeight.bold)),
              ..._interests.keys.map((interest) {
                return CheckboxListTile(
                  title: Text(interest),
                  value: _interests[interest],
                  onChanged: (value) {
                    setState(() {
                      _interests[interest] = value!;
                    });
                  },
                );
              }).toList(),

              SizedBox(height: 16),

              // 🎚️ Slider
              Text("Rate this form: ${_userRating.toStringAsFixed(1)}"),
              Slider(
                min: 0,
                max: 10,
                divisions: 20,
                value: _userRating,
                label: _userRating.toStringAsFixed(1),
                onChanged: (val) => setState(() => _userRating = val),
              ),

              SizedBox(height: 20),
              ElevatedButton(onPressed: _submitForm, child: Text("Submit")),
            ],
          ),
        ),
      ),
    );
  }
}
