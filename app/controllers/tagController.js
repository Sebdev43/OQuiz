const {
  Quiz, Question, Level, Tag, Answer, User,
} = require('../models/index');

const tagsController = {
  async displayAllTags(req, res) {
    try {
      const tags = await Tag.findAll({
        include: [{
            model: Quiz,
            as: 'quizzes'
        }]
      });
      res.render('tags', { tags });
    } catch (error) {
      console.error('Error fetching tags:', error);
      res.status(500).send('Error fetching tags');
    }
  },
  async displayQuizzesByTag(req, res) {
    try {
      const tag = await Tag.findByPk(req.params.id, {
        include: [{
          model: Quiz,
          as: 'quizzes',
        }],
      });
      if (!tag) {
        res.status(404).send('Tag not found');
      } else {
        res.render('tagQuizzes', { tag });
      }
    } catch (error) {
      console.error('Error fecthing quizzs for tag:', error);
      res.status(500).send('Error fecthing quizzes for tag');
    }
  },
};

module.exports = tagsController;
