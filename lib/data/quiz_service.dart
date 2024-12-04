
import 'dart:math';

import 'package:flutter_quiz_app/data/quiz_interface.dart';
import 'package:flutter_quiz_app/data/quiz_question.dart';

class QuizService {
  QuizService({required QuizModelInterface quizModel}) : _quizModel = quizModel {
    for (int i = 0; i < _quizModel.questionBank.length; i++) {
      _questionOrder.add(i);
    }
    shuffleOrder();
    getQuestion();
  }

  final QuizModelInterface _quizModel;
  int _questionIndex = 0;
  int _correctAnswers = 0;
  int _maxQuestions = 1;
  List<int> _questionOrder = [];
  QuizQuestion? _question;

  void shuffleOrder() {
    _questionOrder.shuffle(Random());
    selectOnlyFirstTenQuestions();
  }

  void selectOnlyFirstTenQuestions() {
    _maxQuestions = 10;
    if (_questionOrder.length < 10) {
      _maxQuestions = _questionOrder.length;
    }

    _questionOrder = _questionOrder.sublist(0, _maxQuestions);
  }

  int getMaxQuestions() {
    return _maxQuestions;
  }

  void getQuestion() {
    int index = 0;
    try {
      index = _questionOrder[_questionIndex];
    } catch (e) {
      print(e);
      _question = QuizQuestion(questionText: 'Error getting question.', choice1: 'Proceed', answer: QuizChoice.Choice1, number: -1);
      return;
    }
    print('index number: $index');
    try {
      _question = _quizModel.getQuestion(index);
    } catch (e) {
      print(e);
      _question = QuizQuestion(questionText: 'Error getting question.', choice1: 'Proceed', answer: QuizChoice.Choice1, number: -1);
    }
  }

  int getQuestionOrderIndex() {
    return _questionIndex;
  }

  String getQuestionText() {
    return _question?.questionText ?? 'null question text';
  }

  String? getChoice1() {
    // print('Getting choice 1');
    String choice = _question?.choices[QuizChoice.Choice1] ?? '';
    // print(choice);
    return choice;
  }
  String? getChoice2() {
    // print('Getting choice 2');
    String? choice = _question?.choices[QuizChoice.Choice2];
    // print(choice);
    return choice;
  }
  String? getChoice3() {
    // print('Getting choice 3');
    String? choice = _question?.choices[QuizChoice.Choice3];
    // print(choice);
    return choice;
  }
  String? getChoice4() {
    // print('Getting choice 4');
    String? choice = _question?.choices[QuizChoice.Choice4];
    // print(choice);
    return choice;
  }

  bool checkPlayerAnswer(QuizChoice playerChoice) {
    bool result = playerChoice == _question?.answer;
    result ? _correctAnswers++ : null;
    print('number of correct answers: $_correctAnswers');
    return result;
  }

  bool nextQuestion() {
    _questionIndex++;
    if (_questionIndex >= _questionOrder.length) {
      _questionIndex = 0;
      return true;
    }
    getQuestion();
    return false;
  }

  void reset() {
    _questionIndex = 0;
    _correctAnswers = 0;
    shuffleOrder();
    getQuestion();
  }

  int getTotalQuestions() {
    int length = 0;
    try {
      length = _quizModel.questionBank.length;
    } catch(e) {
      print(e);
    }
    return length;
  }

  String? getQuestionExplanation() {
    return _question?.explanation;
  }

  int getNumberOfCorrectAnswers() {
    return _correctAnswers;
  }

}