
import 'package:flutter_quiz_app/data/json_file_reader.dart';
import 'package:flutter_quiz_app/data/quiz_interface.dart';
import 'package:flutter_quiz_app/data/quiz_question.dart';

class QuizModel implements QuizModelInterface{
  QuizModel({required this.filepath}) {
    makeQuestionBank();
  }

  String filepath;
  List<QuizQuestion> _questionBank = [];

  List<QuizQuestion> getQuestionBank() {
    return _questionBank;
  }

  void makeQuestionBank() async {
    _questionBank = await _makeQuestionBankFromJson(JsonFileReader().loadJsonFromAssets(filepath));
  }

  Future<List<QuizQuestion>> _makeQuestionBankFromJson(Future<List<dynamic>> decoded) async {

    List<QuizQuestion> bank = [];
    var awaitedDecode = await decoded;

    for (int i = 0; i < awaitedDecode.length; i++) {
      var item = awaitedDecode[i];
      QuizQuestion question = QuizQuestion(questionText: item['q'] as String,
          choice1: item['c1'] as String,
          choice2: item['c2'] as String,
          choice3: item['c3'] as String,
          choice4: item['c4'] as String,
          answer: QuizChoice.values[(item['a'] as int) - 1],
          explanation: item['e'] as String);
      bank.add(question);
    }
    return bank;
  }

  @override
  QuizQuestion getQuestion(int index) {
    try {
      return _questionBank[index];
    } catch(e) {
      print(e);
    }
    return QuizQuestion(questionText: 'Empty question', choice1: 'continue', answer: QuizChoice.Choice1);
  }


}