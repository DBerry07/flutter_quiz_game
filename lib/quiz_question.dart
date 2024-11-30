class QuizQuestion {

  String questionText;

  Map<QuizChoice, String> choices = {};
  QuizChoice answer;

  QuizQuestion({
    required this.questionText,
    required String choice1,
    required String choice2,
    String? choice3,
    String? choice4,
    required this.answer,
  }) {
    choices[QuizChoice.Choice1] = choice1;
    choices[QuizChoice.Choice2] = choice2;
    choice3 != null ? choices[QuizChoice.Choice3] = choice3: '';
    choice4 != null ? choices[QuizChoice.Choice4] = choice4: '';
  }

}

enum QuizChoice {
  Choice1,
  Choice2,
  Choice3,
  Choice4,
}