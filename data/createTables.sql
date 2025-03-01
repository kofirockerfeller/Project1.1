USE moviedb;

CREATE TABLE MotionPicture (
    id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    rating DECIMAL(3,1) CHECK (rating >= 0 AND rating <= 10),
    production VARCHAR(255),
    budget INT UNSIGNED CHECK (budget > 0)
);

CREATE TABLE Users (
    email VARCHAR(255) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    age INT CHECK (age >= 0)
);

CREATE TABLE Likes (
    uemail VARCHAR(255),
    mpid INT,
    PRIMARY KEY (uemail, mpid),
    FOREIGN KEY (uemail) REFERENCES Users(email) ON DELETE CASCADE,
    FOREIGN KEY (mpid) REFERENCES MotionPicture(id) ON DELETE CASCADE
);

CREATE TABLE Movie (
    mpid INT PRIMARY KEY,
    boxoffice_collection INT UNSIGNED CHECK (boxoffice_collection >= 0),
    FOREIGN KEY (mpid) REFERENCES MotionPicture(id) ON DELETE CASCADE
);

CREATE TABLE Series (
    mpid INT PRIMARY KEY,
    season_count INT CHECK (season_count >= 1),
    FOREIGN KEY (mpid) REFERENCES MotionPicture(id) ON DELETE CASCADE
);

CREATE TABLE People (
    id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    nationality VARCHAR(100),
    dob DATE,
    gender ENUM('M', 'F', 'Other')
);

CREATE TABLE Role (
    mpid INT,
    pid INT,
    role_name VARCHAR(255),
    PRIMARY KEY (mpid, pid, role_name),
    FOREIGN KEY (mpid) REFERENCES MotionPicture(id) ON DELETE CASCADE,
    FOREIGN KEY (pid) REFERENCES People(id) ON DELETE CASCADE
);

CREATE TABLE Award (
    mpid INT,
    pid INT,
    award_name VARCHAR(255),
    award_year INT,
    PRIMARY KEY (mpid, pid, award_name, award_year),
    FOREIGN KEY (mpid) REFERENCES MotionPicture(id) ON DELETE CASCADE,
    FOREIGN KEY (pid) REFERENCES People(id) ON DELETE CASCADE
);

CREATE TABLE Genre (
    mpid INT,
    genre_name VARCHAR(255),
    PRIMARY KEY (mpid, genre_name),
    FOREIGN KEY (mpid) REFERENCES MotionPicture(id) ON DELETE CASCADE
);

CREATE TABLE Location (
    mpid INT,
    zip VARCHAR(20),
    city VARCHAR(255),
    country VARCHAR(255),
    PRIMARY KEY (mpid, zip),
    FOREIGN KEY (mpid) REFERENCES MotionPicture(id) ON DELETE CASCADE
);
