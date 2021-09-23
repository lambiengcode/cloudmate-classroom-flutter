class Question {
  final String? question;
  final int? duration;

  Question({
    this.duration,
    this.question,
  });
}

List<Question> questions = [
  Question(
    question: 'Flutter là gì?',
    duration: 30,
  ),
  Question(
    question: 'Dependency Injection là gì?',
    duration: 30,
  ),
  Question(
    question: 'Mô hình bảo mật truyền thống trên server?',
    duration: 45,
  ),
];
