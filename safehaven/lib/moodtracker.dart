import 'package:flutter/material.dart';

class MoodTrackerScreen extends StatefulWidget {
  const MoodTrackerScreen({super.key});

  @override
  _MoodTrackerScreenState createState() => _MoodTrackerScreenState();
}

class _MoodTrackerScreenState extends State<MoodTrackerScreen> {
  String _selectedMood = 'Neutral'; // Default mood

  // List of moods to select from
  final List<String> _moodList = ['Happy', 'Sad', 'Angry', 'Neutral', 'Excited', 'Stressed'];

  // Simulating a mood log (you can integrate Firebase/Database for real storage)
  final List<Map<String, String>> _moodLog = [];

  // Function to log the mood
  void _logMood() {
    setState(() {
      // Log mood with current timestamp
      _moodLog.add({
        'mood': _selectedMood,
        'time': DateTime.now().toLocal().toString(),
      });
    });

    // Show a success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Mood logged as $_selectedMood!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mood Tracker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'How are you feeling today?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            
            // Dropdown to select mood
            DropdownButton<String>(
              value: _selectedMood,
              items: _moodList.map((mood) {
                return DropdownMenuItem(
                  value: mood,
                  child: Text(mood),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedMood = newValue!;
                });
              },
            ),
            const SizedBox(height: 20),
            
            // Button to log the mood
            ElevatedButton(
              onPressed: _logMood,
              child: const Text('Log Mood'),
            ),
            const SizedBox(height: 30),
            
            // Display mood log
            const Text(
              'Mood Log',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: _moodLog.isNotEmpty
                  ? ListView.builder(
                      itemCount: _moodLog.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(_moodLog[index]['mood']!),
                          subtitle: Text(_moodLog[index]['time']!),
                        );
                      },
                    )
                  : const Center(
                      child: Text('No moods logged yet.'),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
