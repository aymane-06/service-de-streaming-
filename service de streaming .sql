--Full Name: Himame Aymane ;
-- email   : aymane.himame@gmail.com;

--Create DataBase:
CREATE DATABASE service_de_streaming ;
--USE DataBase:
use service_de_streaming;
--Create Tabels:
        -- users:

CREATE TABLE Users(
    UserID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    RegistrationDate DATE NOT NULL);
    --add colume SubscriptionID FK to subscrition(subscriptionID):
    ALTER TABLE users ADD COLUME subscriptionID INT;
    ALTER TABLE users ADD CONSTRAINT fk_subscriptionID FOREIGN KEY (subscriptionID) REFERENCES subscription(subscriptionID);

        --movie:

CREATE TABLE movie(
    MovieID INT AUTO_INCREMENT PRIMARY KEY,
    Titel VARCHAR(255) UNIQUE NOT NULL,
    Genre VARCHAR(100) NOT NULL,
    ReleaseYear INT NOT NULL,
    Duration INT NOT NULL,
    Rating VARCHAR(10) NOT NULL);

        --watchhistory:

CREATE TABLE watchhistory(
    WatchHistoryID INT AUTO_INCREMENT PRIMARY KEY,
    WatchDate DATE NOT NULL,
    ComplitionPercentage int NOT NUll);
    --ComplitionPercentage add check:
    ALTER TABLE watchhistory
    ADD CONSTRAINT CHECK(ComplitionPercentage BETWEEN 0 AND 100); 
    --add colume userID FK to users(userID):
    ALTER TABLE watchhistory ADD COLUME UserID;
    ALTER TABLE watchhistory ADD CONSTRAINT ALTER TABLE watchhistory ADD CONSTRAINT FOREIGN KEY (UserID) REFERENCES users(UserID);
    --add colume movieID FK to movie(movieID):
    ALTER TABLE watchhistory ADD COLUMN movieID INT NOT NULL;
    ALTER TABLE watchhistory ADD CONSTRAINT FK_movieID FOREIGN KEY(movieID) REFERENCES movie(movieID);

        --Subscription:

CREATE TABLE subscription(
    SubscriptionID INT AUTO_INCREMENT PRIMARY KEY,
    SubscriptionType VARCHAR(50),
    CHECK (SubscriptionType='Basic'OR SubscriptionType='Premium'),
    MonthlyFee DECIMAL(10,2) NOT NULL);

        --Review:

CREATE TABLE review(
    ReviewID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT NOT NULL,
    FOREIGN KEY(UserID) REFERENCES users(UserID),
    MovieID INT NOT NULL,
    FOREIGN KEY(MovieID) REFERENCES movie(MovieID),
    Rating INT NOT NULL,
    ReviewText TEXT,
    ReviewDate Date);


    --1.Insérer un film:
    INSERT INTO movie(Titel,Genre,Duration,Rating,ReleaseYear) 
    VALUES('I Am Legend','Science Adventures',101,'PG-13',2007); 

    --2.Rechercher des films:
    SELECT * 
    FROM movie
    WHERE Genre='Comedy'AND ReleaseYear>2020;
    --3.Mise à jour des abonnements:
    UPDATE users 
    SET subscriptionID=1
    WHERE subscriptionID=2;
    --4.Afficher les abonnements :
    SELECT u.FirstName,u.LastName, S.SubscriptionType
    FROM users u INNER JOIN subscription s
    ON u.subscriptionID=s.SubscriptionID;
    --5.Filtrer les visionnages:
    SELECT users.FirstName,users.LastName,watchhistory.ComplitionPercentage
    FROM users INNER JOIN watchhistory
    ON users.UserID=WatchHistory.UserID
    WHERE watchhistory.ComplitionPercentage=100;
    --6.Trier et limiter:
    SELECT Titel,Duration
    FROM movie
    ORDER BY Duration DESC
    LIMIT 5;
    --7.Agrégation :
    SELECT Movie.MovieID,movie.Titel,AVG(ComplitionPercentage)
    FROM movie INNER JOIN watchhistory
    ON movie.MovieID=watchhistory.movieID
    GROUP BY watchhistory.movieID;
    --8.Group By :
    SELECT COUNT(u.UserID) , s.SubscriptionType 
    FROM users u 
    INNER JOIN subscription s 
    ON s.SubscriptionID= u.subscriptionID 
    GROUP BY s.SubscriptionType
    ORDER BY COUNT(u.UserID);

