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
    --add colume userID FK to users(userID):
    ALTER TABLE watchhistory ADD COLUME UserID;
    ALTER TABLE watchhistory ADD CONSTRAINT ALTER TABLE watchhistory ADD CONSTRAINT FOREIGN KEY (UserID) REFERENCES users(UserID);

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