class Exam {
  final String id;
  final String name;
  final String description;
  final String createdBy;
  final int usedTimes;

  Exam({
    this.id = '',
    required this.name,
    required this.description,
    required this.createdBy,
    required this.usedTimes,
  });

  factory Exam.fromMap(Map<String, dynamic> data) {
    return Exam(
      id: data['_id'],
      name: data['name'],
      description: data['description'],
      createdBy: data['createdBy'],
      usedTimes: data['usedTimes'],
    );
  }
}

List<Exam> exams = [
  Exam(
    name: 'Bài kiểm tra số 1',
    description: 'Kiểm tra 15p, tuần 2',
    createdBy: '',
    usedTimes: 5,
  ),
  Exam(
    name: 'Bài kiểm tra số 2',
    description: 'Kiểm tra 15p, tuần 5',
    createdBy: '',
    usedTimes: 4,
  ),
  Exam(
    name: 'Bài kiểm tra số 3',
    description: 'Kiểm tra 45p, tuần 7',
    createdBy: '',
    usedTimes: 1,
  ),
];
