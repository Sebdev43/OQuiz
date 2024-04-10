-- -----------------------------------------------------
-- Schemas oquiz
-- -----------------------------------------------------

-- Note 1 : par convention on va nommer toutes les tables au singulier, en minuscule et en anglais.

-- Note 2 : Chaque table contiendra un champs created_at contenant la date de création d'un enregistrement
-- et un champ updated_at contenant la date de mise à jour de cet enregistrement


BEGIN;
-- Note : BEGIN déclare le début d'une transaction : un groupe d'instructions SQL qui rend celles-ci dépendantes les unes des autres. 
-- Si au moins une des instructions génère une erreur, alors toutes les commandes sont invalidées.


-- Comme c'est un script de création de tables, on s'assure que celles-ci sont bien supprimées avant de les créer. 
-- On peut supprimer plusieurs tables en même temps
-- Note : attention à ne pas lancer ce script en production en revanche :wink:
DROP TABLE IF EXISTS "level",
"answer",
"user",
"quiz",
"question",
"tag",
"quiz_has_tag";

-- -----------------------------------------------------
-- Table "level"
-- -----------------------------------------------------
CREATE TABLE "level" (
  "id" INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,  -- SERIAL est deprécated en Postgres récent
  "name" TEXT NOT NULL,
  "created_at" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Date où l'on insère un enregistrement dans la base
  "updated_at" TIMESTAMPTZ
);

/*
Notes :
  - id : 
    - La clé primaire est automatiquement NOT NULL. Pas besoin de le préciser.
    - On spécifie que la colonne sera générée automatiquement par la BDD en suivant une séquence numérique prédéfinie, s'incrémentant de 1 en 1.
    - On peut définir 'BY DEFAULT' (surcharge de la valeur possible) ou 'ALWAYS' (surcharge de la valeur impossible)
    - Ici on utilise BY DEFAULT, car on définit nous même les valeurs des clés primaires (dans le fichier de seeding).
    - Mais on utilisera plus généralement ALWAYS afin de sécurisé l'incrémentation des valeurs du champ
  - created_at 
    - CURRENT_TIMESTAMP : on peut aussi utiliser now()
*/


-- -----------------------------------------------------
-- Table "answer"
-- -----------------------------------------------------
CREATE TABLE "answer" (
  "id" INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "description" TEXT NOT NULL,
  "question_id" INTEGER NOT NULL,
  "created_at" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_at" TIMESTAMPTZ
);
-- Note : On ne peut pas référencé le champ id de la table question ici, car la table n'existe pas encore. On fera une modification à la fin du script pour ajouter la référence.

-- -----------------------------------------------------
-- Table "app_user"
-- -----------------------------------------------------
CREATE TABLE "user" (
  "id" INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "email" TEXT NOT NULL,
  "password" TEXT NOT NULL,
  "firstname" TEXT NULL,
  "lastname" TEXT NULL,
  "created_at" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_at" TIMESTAMPTZ
);

-- -----------------------------------------------------
-- Table "quiz"
-- -----------------------------------------------------
CREATE TABLE "quiz" (
  "id" INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "title" TEXT NOT NULL,
  "description" TEXT NULL,
  "author_id" INTEGER NOT NULL REFERENCES "user"("id"), -- auteur du quiz
  "created_at" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_at" TIMESTAMPTZ
);

-- -----------------------------------------------------
-- Table "question"
-- -----------------------------------------------------
CREATE TABLE "question" (
  "id" INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "description" TEXT NOT NULL,
  "anecdote" TEXT NULL,
  "wiki" TEXT NULL,
  "level_id" INTEGER NOT NULL REFERENCES "level"("id"),
  "answer_id" INTEGER NOT NULL REFERENCES "answer"("id"), -- 'La BONNE réponse du quiz',
  "quiz_id" INTEGER NOT NULL REFERENCES "quiz"("id"),
  "created_at" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_at" TIMESTAMPTZ
);

-- -----------------------------------------------------
-- Table "tag"
-- -----------------------------------------------------
CREATE TABLE "tag" (
  "id" INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "name" TEXT NOT NULL,
  "created_at" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_at" TIMESTAMPTZ
);

-- -----------------------------------------------------
-- Table "quiz_has_tag"
-- -----------------------------------------------------
CREATE TABLE "quiz_has_tag" (
  "id" INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "quiz_id" INTEGER NOT NULL REFERENCES "quiz"("id"),
  "tag_id" INTEGER NOT NULL REFERENCES "tag"("id"),
  "created_at" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_at" TIMESTAMPTZ,
  UNIQUE ("quiz_id", "tag_id")
);
-- UNIQUE créé une contrainte sur le coupe quiz_id/tag_id qui doit alors être unique au sein de la BDD. 



-- Maintenant, on peut créer la référence vers la table 'question' pour le champ "question_id" dans la table "answer" afin de réprésenter notre clé étrangère.
-- On remarquera ici la présence de l'instruction FOREIGN KEY qui dit explicitement que cette colonne sert de clé étrangère faisant référence à la colonne id de la table question
-- Autrement, lors de la création d'une table avec le mot clef "REFERENCES", cette opération est implicite.
ALTER TABLE "answer" ADD FOREIGN KEY ("question_id") REFERENCES "question"("id");


COMMIT; -- Pour mettre fin à au bloc de transaction et l'exécuter
