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
      title: 'Menu App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

// Home Page
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),

      // Menu List
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),

            // Home
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                );
              },
            ),

            // Services
            ListTile(
              leading: const Icon(Icons.miscellaneous_services),
              title: const Text('Services'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ServicesPage(),
                  ),
                );
              },
            ),

            // Feedback
            ListTile(
              leading: const Icon(Icons.feedback),
              title: const Text('Feedback'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FeedbackPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),

      body: const Center(
        child: Text(
          'Welcome to the Home Page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

// Services Page
class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Services Page'),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            'We provide various services including '
            'web development, mobile app development, '
            'software solutions, and technical support.',
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

// Feedback Page
class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  // TextEditingController to read feedback
  final TextEditingController feedbackController = TextEditingController();

  String message = '';

  @override
  void dispose() {
    feedbackController.dispose();
    super.dispose();
  }

  void submitFeedback() {
    String feedback = feedbackController.text;

    setState(() {
      message = 'Feedback Submitted';
    });

    // Feedback can be accessed using:
    print(feedback);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: feedbackController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Enter your feedback',
                hintText: 'Type your feedback here...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: submitFeedback,
              child: const Text('Submit'),
            ),
            const SizedBox(height: 20),
            Text(
              message,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
