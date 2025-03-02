USE moviedb;

-- ===========================
-- Table: MotionPicture
-- ===========================
CREATE TABLE MotionPicture (
    -- A unique ID for each motion picture
    id INT PRIMARY KEY,
    -- The movie or series title
    name VARCHAR(255) NOT NULL,
    -- Rating on a 0 to 10 scale
    rating DECIMAL(3,1) CHECK (rating >= 0 AND rating <= 10),
    -- Production studio or company
    production VARCHAR(255),
    -- Movie budget (must be > 0)
    budget INT UNSIGNED CHECK (budget > 0)
);

-- ===========================
-- Table: Users
-- ===========================
CREATE TABLE Users (
    -- Email is the unique identifier for the user
    email VARCHAR(255) PRIMARY KEY,
    -- User’s name
    name VARCHAR(255) NOT NULL,
    -- Age (must be >= 0)
    age INT CHECK (age >= 0)
);

-- ===========================
-- Table: Likes
-- ===========================
CREATE TABLE Likes (
    -- Foreign keys referencing Users.email and MotionPicture.id
    uemail VARCHAR(255),
    mpid INT,
    -- Composite primary key: a user cannot like the same movie more than once
    PRIMARY KEY (uemail, mpid),
    -- Delete a like if the user is removed
    FOREIGN KEY (uemail) REFERENCES Users(email) ON DELETE CASCADE,
    -- Delete a like if the movie is removed
    FOREIGN KEY (mpid) REFERENCES MotionPicture(id) ON DELETE CASCADE
);

-- ===========================
-- Table: Movie
-- ===========================
CREATE TABLE Movie (
    -- Links to a MotionPicture record
    mpid INT PRIMARY KEY,
    -- Box office collection must be >= 0
    boxoffice_collection INT UNSIGNED CHECK (boxoffice_collection >= 0),
    -- If the motion picture is removed, remove this record too
    FOREIGN KEY (mpid) REFERENCES MotionPicture(id) ON DELETE CASCADE
);

-- ===========================
-- Table: Series
-- ===========================
CREATE TABLE Series (
    -- Links to a MotionPicture record
    mpid INT PRIMARY KEY,
    -- Must have at least 1 season
    season_count INT CHECK (season_count >= 1),
    FOREIGN KEY (mpid) REFERENCES MotionPicture(id) ON DELETE CASCADE
);

-- ===========================
-- Table: People
-- ===========================
CREATE TABLE People (
    -- A unique ID for each person (actor, director, etc.)
    id INT PRIMARY KEY,
    -- Person’s full name
    name VARCHAR(255) NOT NULL,
    -- Nationality
    nationality VARCHAR(100),
    -- Date of birth
    dob DATE,
    -- Gender is restricted to enum values
    gender ENUM('M', 'F', 'Other')
);

-- ===========================
-- Table: Role
-- ===========================
CREATE TABLE Role (
    -- Foreign key to MotionPicture
    mpid INT,
    -- Foreign key to People
    pid INT,
    -- Name of the role (e.g. ‘actor’, ‘director’, etc.)
    role_name VARCHAR(255),
    -- Composite key: one person, one movie, one role
    PRIMARY KEY (mpid, pid, role_name),

    FOREIGN KEY (mpid) REFERENCES MotionPicture(id) ON DELETE CASCADE,
    FOREIGN KEY (pid) REFERENCES People(id) ON DELETE CASCADE
);

-- ===========================
-- Table: Award
-- ===========================
CREATE TABLE Award (
    -- Movie or series ID
    mpid INT,
    -- Person ID
    pid INT,
    -- Name of the award
    award_name VARCHAR(255),
    -- Year the award was given
    award_year INT,
    -- Composite key: a person, a movie, an award name, and an award year
    PRIMARY KEY (mpid, pid, award_name, award_year),

    FOREIGN KEY (mpid) REFERENCES MotionPicture(id) ON DELETE CASCADE,
    FOREIGN KEY (pid) REFERENCES People(id) ON DELETE CASCADE
);

-- ===========================
-- Table: Genre
-- ===========================
CREATE TABLE Genre (
    -- Links to MotionPicture
    mpid INT,
    -- Genre name
    genre_name VARCHAR(255),
    -- Composite key: each movie can have multiple genres, but no duplicates
    PRIMARY KEY (mpid, genre_name),
    
    FOREIGN KEY (mpid) REFERENCES MotionPicture(id) ON DELETE CASCADE
);

-- ===========================
-- Table: Location
-- ===========================
CREATE TABLE Location (
    -- Links to MotionPicture
    mpid INT,
    -- ZIP code
    zip VARCHAR(20),
    -- City name
    city VARCHAR(255),
    -- Country name
    country VARCHAR(255),
    -- Composite key: each movie can have multiple locations
    PRIMARY KEY (mpid, zip),
    
    FOREIGN KEY (mpid) REFERENCES MotionPicture(id) ON DELETE CASCADE
);
