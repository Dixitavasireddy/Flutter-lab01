import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const StudentDashboard(),
    );
  }
}

class StudentDashboard extends StatefulWidget {
  const StudentDashboard({super.key});

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  bool notifications = false;
  int counter = 0;

  Widget featureItem(IconData icon, String text) {
    return Column(
      children: [
        Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            color: Colors.blue.shade100,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Icon(
            icon,
            size: 35,
            color: Colors.blue,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          text,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Dashboard"),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //================ Banner =================
            Stack(
              children: [
                Image.asset(
                  "assets/images-cse.png",
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  left: 20,
                  bottom: 20,
                  child: CircleAvatar(
                    radius: 42,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 42,
                      backgroundImage: AssetImage("assets/logooo.jpg"),
                    ),
                  ),
                ),
                const Positioned(
                  left: 120,
                  bottom: 25,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "V.Dixita",
                        style: TextStyle(
                          color: Color(0xffd92323),
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Computer Science Student",
                        style: TextStyle(
                          color: Color(0xffd51a1a),
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            //================ Feature Icons =================

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                featureItem(Icons.menu_book, "Books"),
                featureItem(Icons.assignment, "Tasks"),
                featureItem(Icons.school, "Marks"),
                featureItem(Icons.person, "Profile"),
              ],
            ),

            const SizedBox(height: 30),

            //================ Buttons =================

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Login"),
                ),
                OutlinedButton(
                  onPressed: () {},
                  child: const Text("Register"),
                ),
              ],
            ),

            const SizedBox(height: 30),

            //================ Switch =================

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Notifications",
                  style: TextStyle(fontSize: 22),
                ),
                Switch(
                  value: notifications,
                  onChanged: (value) {
                    setState(() {
                      notifications = value;
                    });
                  },
                ),
              ],
            ),

            const SizedBox(height: 20),

            //================ Counter =================

            const Text(
              "Counter",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              "$counter",
              style: const TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      counter--;
                    });
                  },
                  icon: const Icon(Icons.remove),
                  label: const Text("Decrement"),
                ),
                const SizedBox(width: 20),
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      counter++;
                    });
                  },
                  icon: const Icon(Icons.add),
                  label: const Text("Increment"),
                ),
              ],
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
