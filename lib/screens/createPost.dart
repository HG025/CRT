import 'package:crp/screens/customNavigations.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';

class Createpost extends StatefulWidget {
  const Createpost({super.key});

  @override
  State<Createpost> createState() => _CreatepostState();
}

class _CreatepostState extends State<Createpost> {
  String dropdownValue = 'ChooseCrimeType';

  String? _selectedDropdownValue;
  DateTime? _selectedDate;

  late String imagePath;

  void pickImage() async {
    final ImagePicker picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    // print(image?.path);
    // print(image.runtimeType);
    setState(() {
      imagePath = image!.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop(); // Handle back navigation
            },
          ),
          title: const Text('Create Post'),
          foregroundColor: const Color.fromARGB(255, 255, 255, 255),
          backgroundColor: const Color.fromARGB(255, 1, 34, 3),
        ),
        body: Container(
          margin: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _inputField(context),
            ],
          ),
        ),
      ),
    );
  }

  _inputField(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                  onPressed: pickImage,
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                          bottom: Radius.circular(20)),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 17),
                    backgroundColor: const Color.fromARGB(255, 1, 34, 3),
                  ),
                  child:
                      const Column(mainAxisSize: MainAxisSize.min, children: [
                    Icon(
                      Icons.camera,
                      color: Colors.white,
                      size: 32, // Adjust size as needed
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Click Image",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ])),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ElevatedButton(
                  onPressed: pickImage,
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                          bottom: Radius.circular(20)),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 17),
                    backgroundColor: const Color.fromARGB(255, 1, 34, 3),
                  ),
                  child:
                      const Column(mainAxisSize: MainAxisSize.min, children: [
                    Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 32, // Adjust size as needed
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Pick Image",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ])),
            ),
          ],
        ),
        const SizedBox(height: 10),
        DropdownButtonFormField<String>(
          value: _selectedDropdownValue,
          hint: const Text("Select Crime Type"),
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none),
            fillColor: const Color.fromARGB(255, 199, 190, 190),
            filled: true,
          ),
          onChanged: (newValue) {
            setState(() {
              _selectedDropdownValue = newValue;
            });
          },
          items: <String>[
            'ChooseCrimeType',
            'Armed Assault',
            'Assasination',
            'Vehicle Theft',
            'Vehicle Stolen',
            'Drugs',
            'Harassment',
            'Hijacking',
            'Hostage(Kidnapping)',
            'Mobile Snatching',
            'Purse Snatching',
            'Murder',
            'Robery',
          ].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        const SizedBox(height: 10),
        TextFormField(
          readOnly: true,
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2101),
            );

            if (pickedDate != null && pickedDate != _selectedDate) {
              setState(() {
                _selectedDate = pickedDate;
              });
            }
          },
          decoration: InputDecoration(
            hintText: _selectedDate != null
                ? DateFormat('yyyy-MM-dd').format(_selectedDate!)
                : 'Select Date',
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none),
            fillColor: const Color.fromARGB(255, 199, 190, 190),
            filled: true,
            prefixIcon: const Icon(Icons.calendar_today),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Enter Location",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: const Color.fromARGB(255, 199, 190, 190),
                  filled: true,
                  prefixIcon: const Icon(Icons.location_on),
                ),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.location_city_rounded),
              color: const Color.fromARGB(255, 1, 34, 3),
              onPressed: () {},
            ),
          ],
        ),
        const SizedBox(height: 10),
        TextFormField(
          decoration: InputDecoration(
            hintText: "Enter your text",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none),
            fillColor: const Color.fromARGB(255, 199, 190, 190),
            filled: true,
          ),
          maxLines: 5, // To make it a text area
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const Customnavigations()),
            );
          },
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: const Color.fromARGB(255, 1, 34, 3),
          ),
          child: const Text(
            "Submit Post",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}
