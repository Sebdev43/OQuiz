const {
  Quiz, Question, Level, Tag, Answer, User
} = require('../models/index');

const quizController = {
  async displayQuiz(req, res) {
    try {
      const quiz = await Quiz.findByPk(req.params.id, {
        include: [
          {
            model: Question,
            as: 'questions',
            include: [
              { model: Level, as: 'level' },
              { model: Answer, as: 'answers' },
            ],
          },
          {
            model: Tag,
            as: 'tags',
          },
          {
            model: User,
            as: 'author'
          }
        ],
      });
      if (!quiz) {
        res.status(404).send('Quiz not found');
      } else {
        res.render('quiz', { quiz });
      }
    } catch (error) {
      console.error('Error fetching quiz details', error);
      res.status(500).send('Error fetching quiz details');
    }
  },
};

module.exports = quizController;
