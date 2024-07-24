# OQuiz

Bienvenue sur OQuiz, un projet développé dans le cadre de ma formation à l'école O'clock. Ce projet, proposé par l'école pour nous tester, est un site web de quiz permettant aux utilisateurs de s'inscrire, de se connecter, et de répondre à des questions réparties par niveaux et tags.

## Description

OQuiz est une application web conçue pour offrir une expérience ludique et éducative à ses utilisateurs. Le projet utilise Express.js pour le backend et EJS pour le rendu côté serveur. Les données sont stockées dans une base de données PostgreSQL, et l'authentification des utilisateurs est gérée avec des sessions.

## Fonctionnalités

- Inscription et connexion des utilisateurs
- Affichage des quiz par niveaux et tags
- Réponse aux questions avec un feedback immédiat
- Page de profil utilisateur

## Technologies Utilisées

![PostgreSQL](https://img.shields.io/badge/PostgreSQL-336791?style=for-the-badge&logo=postgresql&logoColor=white)
![Node.js](https://img.shields.io/badge/Node.js-339933?style=for-the-badge&logo=nodedotjs&logoColor=white)
![Express.js](https://img.shields.io/badge/Express.js-000000?style=for-the-badge&logo=express&logoColor=white)
![EJS](https://img.shields.io/badge/EJS-000000?style=for-the-badge&logo=ejs&logoColor=white)
![Sequelize](https://img.shields.io/badge/Sequelize-52B0E7?style=for-the-badge&logo=sequelize&logoColor=white)
![JavaScript](https://img.shields.io/badge/JavaScript-F7DF1E?style=for-the-badge&logo=javascript&logoColor=black)

## Structure du Projet

Modèles

- User : Représente les utilisateurs inscrits sur la plateforme.
- Quiz : Contient les informations sur les quiz disponibles.
- Question : Les questions appartenant aux quiz.
- Answer : Les réponses possibles pour chaque question.
- Level : Les niveaux de difficulté des questions.
- Tag : Les tags associés aux quiz pour une meilleure classification.

Relations entre Modèles

- Un User peut créer plusieurs Quiz.
- Un Quiz peut contenir plusieurs Question.
- Une Question peut avoir plusieurs Answer mais une seule bonne réponse.
- Une Question est associée à un Level.
- Un Quiz peut être associé à plusieurs Tag et vice versa.

Contrôleurs

- mainController : Gère la page d'accueil et l'affichage des quiz.
- levelController : Gère les niveaux de quiz.
- quizController : Gère l'affichage détaillé des quiz.
- tagController : Gère les tags
- userController : Gère les users

## Installation

1. Clonez le dépôt :

```bash
git clone https://github.com/Sebdev43/OQuiz.git
```

2. Installez les dépendances :

```bash
cd OQuiz
npm install
```

3. Configurez la base de données en utilisant le fichier `.env.example` pour créer un fichier `.env` avec vos propres paramètres.

4. Créez les tables et insérez les données initiales :

```bash
npm run create-db
npm run populate-db
```

5. Lancez l'application :

```bash
npm start
```

6. Accédez à l'application via http://localhost:3000.

## Auteur

Ce projet a été réalisé par Sebdev43 dans le cadre de ma formation à l'école O'clock.
