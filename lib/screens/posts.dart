import 'package:flutter/material.dart';

class Posts extends StatefulWidget {
  const Posts({super.key});

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ListView(
          //   scrollDirection: Axis.vertical,
          children: [
            _userDetailHeader(context),
            _userDetailHeader(context),
            _userDetailHeader(context),
          ],
        ),
      ),
    );
  }
}

_userDetailHeader(context) {
  return Container(
    padding: const EdgeInsets.all(5.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
            elevation: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ListTile(
                  leading: Icon(Icons.account_circle, size: 50),
                  title: Text(
                    'Username',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      letterSpacing: 0.5,
                      height: 1.2,
                    ),
                  ),
                  subtitle: Text(
                    'timeAge',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Crime Type", style: TextStyle(fontSize: 18)),
                    const Text("Crime Date", style: TextStyle(fontSize: 18)),
                    const Text("Crime Location",
                        style: TextStyle(fontSize: 18)),
                    const SizedBox(height: 10),
                    Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          // width: 200.0,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('lib/assets/CRT-logo.png'),
                              //  fit: BoxFit.fill,
                              fit: BoxFit.fill,
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildActionButton(icon: Icons.thumb_up, label: 'Like'),
                        _buildActionButton(
                            icon: Icons.thumb_down, label: 'DisLike'),
                      ],
                    )
                  ],
                )
              ],
            )),
      ],
    ),
  );
}

_buildActionButton({required IconData icon, required String label}) {
  return TextButton.icon(
    icon: Icon(icon, color: const Color.fromARGB(255, 1, 34, 3)),
    label: Text(
      label,
      style: const TextStyle(color: Color.fromARGB(255, 1, 34, 3)),
    ),
    onPressed: () {
      // Handle action
    },
  );
}
