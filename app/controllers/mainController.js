const { Quiz, User, Tag } = require('../models/index');

const mainController = {
  async index(req, res) {
    try {
      const quizzes = await Quiz.findAll({
        include: [{
          model: User,
          as: 'author',
        },
        {
          model: Tag,
          as: 'tags',
        },
        ],
      });
      res.render('home', { quizzes });
    } catch (error) {
      console.error('Error fecthing quizzes', error);
      res.status(500).send('Error fecthing quizzes');
    }
  },
};

module.exports = mainController;
