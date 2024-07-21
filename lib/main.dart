import 'package:flutter/material.dart';
import 'quiz_model.dart';

void main() => runApp(QuizApp());

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.transparent, // Ensure transparency for gradient backgrounds
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<Quiz> quizzes = [
    Quiz(title: 'General Knowledge', questions: [
      Question(
        text: 'What is the primary language used for Android app development?',
        answers: [
          Answer(text: 'Python'),
          Answer(text: 'Java'),
          Answer(text: 'C++'),
          Answer(text: 'JavaScript'),
        ],
        correctAnswerIndex: 1,
      ),
      Question(
        text: 'Which component is used to handle user interactions in an Android app?',
        answers: [
          Answer(text: 'Service'),
          Answer(text: 'Broadcast Receiver'),
          Answer(text: 'Activity'),
          Answer(text: 'Content Provider'),
        ],
        correctAnswerIndex: 2,
      ),
      Question(
        text: "What is the purpose of an Android 'Intent'?",
        answers: [
          Answer(text: 'To handle background tasks'),
          Answer(text: 'To create user interfaces'),
          Answer(text: 'To start new activities or communicate between components'),
          Answer(text: 'To manage data storage'),
        ],
        correctAnswerIndex: 2,
      ),
      Question(
        text: 'Which file is used to declare app permissions in an Android app?',
        answers: [
          Answer(text: 'style.xml'),
          Answer(text: 'AndroidManifest.xml'),
          Answer(text: 'build.gradle'),
          Answer(text: 'string.xml'),
        ],
        correctAnswerIndex: 1,
      ),
      Question(
        text: "What is the purpose of the 'RecyclerView' in Android development?",
        answers: [
          Answer(text: 'To display a list of items efficiently'),
          Answer(text: 'To handle network operations'),
          Answer(text: 'To create custom views'),
          Answer(text: 'To manage app preferences'),
        ],
        correctAnswerIndex: 0,
      ),
      Question(
        text: "Which Android component is used for running background tasks?",
        answers: [
          Answer(text: 'Activity'),
          Answer(text: 'Service'),
          Answer(text: 'Content Provider'),
          Answer(text: 'Broadcast Receiver'),
        ],
        correctAnswerIndex: 1,
      ),
      Question(
        text: "What is the use of 'ViewMode'l in Android architecture?",
        answers: [
          Answer(text: 'To handle UI updates and manage UI-related data'),
          Answer(text: 'To manage background threads'),
          Answer(text: 'To handle network communications'),
          Answer(text: 'To store application preferences'),
        ],
        correctAnswerIndex: 0,
      ),
      Question(
        text: "What does the 'Gradle' build system manage in an Android project?",
        answers: [
          Answer(text: 'User interface design'),
          Answer(text: 'Data storage'),
          Answer(text: 'App dependencies and build configurations'),
          Answer(text: 'Network operations'),
        ],
        correctAnswerIndex: 2,
      ),
      Question(
        text: "Which method is called when an activity is first created in Android?",
        answers: [
          Answer(text: 'onStart()'),
          Answer(text: 'onResume()'),
          Answer(text: 'onCreate()'),
          Answer(text: 'onDestroy()'),
        ],
        correctAnswerIndex: 2,
      ),
      Question(
        text: "What is an 'Adapter' used for in Android?",
        answers: [
          Answer(text: 'To handle data binding in UI components'),
          Answer(text: 'To manage network requests'),
          Answer(text: 'To create custom views'),
          Answer(text: 'To manage user authentication'),
        ],
        correctAnswerIndex: 0,
      ),
      // Add more questions here
    ]),
    // Add more quizzes here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.blue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/logo.png',
                height: 250,
              ),
              SizedBox(height: 25),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuizScreen(quiz: quizzes.first),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  textStyle: TextStyle(fontSize: 20),
                  backgroundColor: Colors.blueAccent, // Button color
                ),
                child: Text('Start a Quiz', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class QuizListScreen extends StatelessWidget {
  final List<Quiz> quizzes;

  QuizListScreen({required this.quizzes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.blue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView.builder(
          itemCount: quizzes.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(quizzes[index].title, style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizScreen(quiz: quizzes[index]),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class QuizScreen extends StatefulWidget {
  final Quiz quiz;

  QuizScreen({required this.quiz});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestionIndex = 0;
  int score = 0;
  List<bool> correctAnswers = [];

  void _submitAnswer(int selectedAnswerIndex) {
    if (selectedAnswerIndex == widget.quiz.questions[currentQuestionIndex].correctAnswerIndex) {
      score++;
      correctAnswers.add(true);
    } else {
      correctAnswers.add(false);
    }

    setState(() {
      if (currentQuestionIndex < widget.quiz.questions.length - 1) {
        currentQuestionIndex++;
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ResultScreen(
              score: score,
              total: widget.quiz.questions.length,
              correctAnswers: correctAnswers,
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.quiz.questions[currentQuestionIndex];

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.blue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center content vertically
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Question ${currentQuestionIndex + 1}/${widget.quiz.questions.length}', // Display question number and total
                textAlign: TextAlign.center, // Center text horizontally
                style: TextStyle(
                  fontSize: 20.0, // Adjusted font size for question number
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Text color to stand out on gradient background
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                question.text,
                textAlign: TextAlign.center, // Center text horizontally
                style: TextStyle(
                  fontSize: 28.0, // Increased font size for the question
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Text color to stand out on gradient background
                ),
              ),
              SizedBox(height: 20.0),
              for (int i = 0; i < question.answers.length; i++)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ElevatedButton(
                    onPressed: () => _submitAnswer(i),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      textStyle: TextStyle(fontSize: 18),
                      backgroundColor: Colors.blueAccent, // Button color
                    ),
                    child: Text(question.answers[i].text, style: TextStyle(color: Colors.white)),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class ResultScreen extends StatelessWidget {
  final int score;
  final int total;
  final List<bool> correctAnswers;

  ResultScreen({
    required this.score,
    required this.total,
    required this.correctAnswers,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.blue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 55,),
              Text('Score: $score / $total', style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold, color: Colors.white)),
              SizedBox(height: 20.0),
              for (int i = 0; i < correctAnswers.length; i++)
                ListTile(
                  title: Text('Question ${i + 1}', style: TextStyle(fontSize: 18.0, color: Colors.white)),
                  trailing: Icon(
                    correctAnswers[i] ? Icons.check_circle : Icons.cancel,
                    color: correctAnswers[i] ? Colors.green : Colors.red,
                    size: 24.0,
                  ),
                ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  textStyle: TextStyle(fontSize: 20),
                  backgroundColor: Colors.blueAccent, // Button color
                ),
                child: Text('Restart the quiz', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
