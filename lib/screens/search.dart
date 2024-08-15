import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String dropdownValue = 'Search By Crime Type';

  String? _selectedDropdownValue;
  String? _selectedDropdownValue1;
  String selectedValue = "Search By Crime Type";

  DateTime? _selectedDate;

  String? _selectedCrimeType;
  String? _selectedCrimeType1;
  TextEditingController _crimeLocationController = TextEditingController();

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
          title: const Text('Search'),
          foregroundColor: const Color.fromARGB(255, 255, 255, 255),
          backgroundColor: const Color.fromARGB(255, 1, 34, 3),
        ),
        body: Container(
          margin: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(height: 50),
              _inputField(context),
              if (_selectedDropdownValue == 'Search By Crime Type')
                _inputadditionalFieldforCrimeType(),
              if (_selectedDropdownValue == 'Search By Crime Date')
                _inputadditionalFieldforCrimeDate(),
              if (_selectedDropdownValue == 'Search By Crime Location')
                _inputadditionalFieldforCrimeLocation(),
              _inputButton(context),
              const SizedBox(height: 50)
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
        const SizedBox(height: 10),
        DropdownButtonFormField<String>(
          value: _selectedDropdownValue,
          hint: const Text("Select Search Option"),
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
              _selectedCrimeType = null;
              _selectedDate = null;
              _crimeLocationController.clear();
            });
          },
          items: <String>[
            'Search By Crime Type',
            'Search By Crime Date',
            'Search By Crime Location',
          ].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  _inputadditionalFieldforCrimeType() {
    return Column(
      children: [
        DropdownButtonFormField<String>(
          value: _selectedDropdownValue1,
          hint: const Text("ChooseCrimeType"),
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none),
            fillColor: const Color.fromARGB(255, 199, 190, 190),
            filled: true,
          ),
          onChanged: (newValue) {
            setState(() {
              _selectedDropdownValue1 = newValue;
              _selectedDropdownValue1 = 'ChooseCrimeType';
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
        )
      ],
    );
  }

  _inputadditionalFieldforCrimeDate() {
    return Column(
      children: [
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
        )
      ],
    );
  }

  _inputadditionalFieldforCrimeLocation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
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
        )
      ],
    );
  }

  _inputButton(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => ),
            // );
          },
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: const Color.fromARGB(255, 1, 34, 3),
          ),
          child: const Text(
            "Search",
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
