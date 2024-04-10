const bcrypt = require('bcrypt');
const { Quiz, User, Tag } = require('../models/index');

exports.showSignup = (req, res) => {
  res.render('signup');
};

exports.signup = async (req, res) => {
  const {
    fisrtname, lastname, email, password, confirmation,
  } = req.body;

  if (password !== confirmation) {
    return res.render('signup', { error: 'les mots passe ne corresponde pas.' });
  }
  try {
    const hashPassword = await bcrypt.hash(password, 10);
    await User.create({
      firstname,
      lastname,
      email,
      password: hashPassword,
    });
    res.redirect('/profile');
  } catch (error) {
    console.error('Error creating user:', error);
    res.render('signup', { error: 'Erreur lors de la création de user' });
  }
};

exports.showLogin = (req, res) => {
  res.render('login');
};

exports.login = async (req, res) => {
  const { email, password } = req.body;
  const user = await User.findOne({ where: { email } });
  if (user && await bcrypt.compare(password, user.password)) {
    req.session.userId = user.id;
    res.redirect('/profile');
  } else {
    res.redirect('/login');
  }
};

exports.showProfile = async (req, res) => {
  const { userId } = req.session;

  if (userId) {
    try {
      const user = await User.findByPk(userId);
      if (!user) {
        return res.redirect('/login');
      }
      res.render('profile', { user });
    } catch (error) {
      console.error('Error fetching user:', error);
      res.status(500).send('Erreur serveur');
    }
  } else {
    res.redirect('/login');
  }
};
