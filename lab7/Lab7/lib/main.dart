import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const SmartWaterApp());
}

class SmartWaterApp extends StatelessWidget {
  const SmartWaterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Water Intake Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFF2F9FF),
      ),
      home: const WaterTrackerPage(),
    );
  }
}

class WaterTrackerPage extends StatefulWidget {
  const WaterTrackerPage({super.key});

  @override
  State<WaterTrackerPage> createState() => _WaterTrackerPageState();
}

class _WaterTrackerPageState extends State<WaterTrackerPage> {
  final TextEditingController waterController = TextEditingController();

  // Daily hydration goal
  final double dailyGoal = 2000;

  double totalWater = 0;
  int entryCount = 0;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  // Load saved data from local storage
  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      totalWater = prefs.getDouble('totalWater') ?? 0;
      entryCount = prefs.getInt('entryCount') ?? 0;
    });
  }

  // Save data to local storage
  Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setDouble('totalWater', totalWater);
    await prefs.setInt('entryCount', entryCount);
  }

  // Add water intake
  void addWater() {
    final String input = waterController.text.trim();
    final double? amount = double.tryParse(input);

    // Validation
    if (amount == null || amount <= 0) {
      showMessage(
        'Please enter a valid water amount greater than 0 mL.',
        Colors.red,
      );
      return;
    }

    setState(() {
      totalWater += amount;
      entryCount++;
    });

    saveData();

    waterController.clear();

    showMessage(
      '$amount mL added successfully!',
      Colors.green,
    );
  }

  // Reset water intake
  void confirmReset() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Reset Water Intake'),
          content: const Text(
            'Are you sure you want to reset today\'s water intake?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                resetData();
                Navigator.pop(context);
              },
              child: const Text('Reset'),
            ),
          ],
        );
      },
    );
  }

  // Reset data
  Future<void> resetData() async {
    setState(() {
      totalWater = 0;
      entryCount = 0;
    });

    final prefs = await SharedPreferences.getInstance();

    await prefs.setDouble('totalWater', 0);
    await prefs.setInt('entryCount', 0);

    showMessage(
      'Water intake has been reset.',
      Colors.blue,
    );
  }

  // Display snackbar message
  void showMessage(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }

  @override
  void dispose() {
    waterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Remaining water
    final double remaining =
        (dailyGoal - totalWater).clamp(0, dailyGoal).toDouble();

    // Completion percentage
    final double percentage =
        ((totalWater / dailyGoal) * 100).clamp(0, 100).toDouble();

    // Progress value for LinearProgressIndicator
    final double progress = (totalWater / dailyGoal).clamp(0, 1).toDouble();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Smart Water Tracker',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            onPressed: confirmReset,
            icon: const Icon(
              Icons.refresh,
              color: Colors.white,
            ),
            tooltip: 'Reset',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Water icon
            const Icon(
              Icons.water_drop,
              size: 80,
              color: Colors.blue,
            ),

            const SizedBox(height: 10),

            const Text(
              'Daily Hydration Goal',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            Text(
              '${dailyGoal.toInt()} mL',
              style: const TextStyle(
                fontSize: 28,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 25),

            // Progress Card
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      '${totalWater.toInt()} mL',
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const Text(
                      'Consumed Today',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 20),
                    LinearProgressIndicator(
                      value: progress,
                      minHeight: 12,
                      backgroundColor: Colors.grey.shade300,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '${percentage.toStringAsFixed(0)}% Completed',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Statistics
            Row(
              children: [
                // Remaining
                Expanded(
                  child: Card(
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.local_drink,
                            color: Colors.orange,
                            size: 35,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${remaining.toInt()} mL',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            'Remaining',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                // Entries
                Expanded(
                  child: Card(
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.format_list_numbered,
                            color: Colors.green,
                            size: 35,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '$entryCount',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            'Entries',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            // Input title
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Add Water Intake',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Water input
            TextField(
              controller: waterController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(
                labelText: 'Enter amount in mL',
                hintText: 'Example: 250',
                prefixIcon: const Icon(
                  Icons.water_drop,
                  color: Colors.blue,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 15),

            // Add button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: addWater,
                icon: const Icon(Icons.add),
                label: const Text(
                  'Add Water',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),

            const SizedBox(height: 15),

            // Reset button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton.icon(
                onPressed: confirmReset,
                icon: const Icon(Icons.restart_alt),
                label: const Text(
                  'Reset Today',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Goal completed message
            if (totalWater >= dailyGoal)
              const Card(
                color: Color(0xFFE8F5E9),
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: Colors.green,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Congratulations! You have reached your daily hydration goal.',
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
