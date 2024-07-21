class Quiz {
  final String title;
  final List<Question> questions;

  Quiz({required this.title, required this.questions});
}

class Question {
  final String text;
  final List<Answer> answers;
  final int correctAnswerIndex;

  Question({required this.text, required this.answers, required this.correctAnswerIndex});
}

class Answer {
  final String text;

  Answer({required this.text});
}
