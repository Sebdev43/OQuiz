const { Router } = require('express');
const mainController = require('./controllers/mainController');
const levelController = require('./controllers/levelController');
const quizController = require('./controllers/quizController');
const tagsController = require('./controllers/tagController');

const router = Router();

router.get('/', mainController.index);
router.get('/levels', levelController.list);
router.post('/levels', levelController.create);
router.get('/quiz/:id', quizController.displayQuiz);
router.get('/tags', tagsController.displayAllTags);
router.get('/tags/:id', tagsController.displayQuizzesByTag);

module.exports = router;
