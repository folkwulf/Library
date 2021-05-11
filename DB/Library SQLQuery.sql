--**************************************************
-- Create Data Base.
--**************************************************
	
	CREATE DATABASE LibraryDB
	ON
	(
		NAME = 'LibraryDB',
		FILENAME = 'D:\Projects\Library\DB\LibraryDB.mdf',
		SIZE = 10MB,
		MAXSIZE = 100MB,
		FILEGROWTH = 10MB
	)
	LOG ON
	(
		NAME = 'LogLibraryDB',
		FILENAME = 'D:\Projects\Library\DB\LibraryDB.ldf',
		SIZE = 5MB,
		MAXSIZE = 50MB,
		FILEGROWTH = 5MB
	)

--**************************************************
-- Get Data Base info.
--**************************************************
	
	EXECUTE sp_helpdb LibraryDB

--**************************************************
-- Connect to Data Base.
--**************************************************
	
	USE LibraryDB
	GO

--**************************************************
-- Create tables to Data Base.
--**************************************************
	
	CREATE TABLE Books
	(
		BookId int UNIQUE IDENTITY NOT NULL,
		Isbn varchar(20),
		Title varchar(50) NOT NULL,
		BriefDescription varchar(1000),
		GenreId tinyint,
		Author varchar(200),
		BookConditionId tinyint NOT NULL,
		Comment varchar(1000),
		RegistrationDate Date NOT NULL
	)
	GO

	CREATE TABLE Users
	(
		UserId int UNIQUE IDENTITY NOT NULL,
		FirstName varchar(50) NOT NULL,
		LastName varchar(50) NOT NULL,
		RegistrationDate Date NOT NULL,
		IsActive bit NOT NULL,
		UserTypeId tinyint NOT NULL,
		UserRatingId tinyint NOT NULL,
		Comment varchar(1000)
	)
	GO

	CREATE TABLE BooksInUse
	(
		BookId int NOT NULL,
		UserId int NOT NULL,
		TakingDate date NOT NULL
	)
	GO

	CREATE TABLE UsingBooksHistory
	(
		BookId int NOT NULL,
		UserId int NOT NULL,
		TimesNumber smallint NOT NULL,
		TakingDate date NOT NULL,
		ReturnDate date NOT NULL,
		TakenBookConditionId tinyint NOT NULL,
		ReturnedBookConditionId tinyint NOT NULL
	)
	GO

	CREATE TABLE Genres
	(
		GenreId tinyint NOT NULL,
		Name varchar(20) NOT NULL
	)
	GO

	CREATE TABLE BookConditions
	(
		BookConditionId tinyint NOT NULL,
		Name varchar(20) NOT NULL
	)
	GO

	CREATE TABLE UserTypes
	(
		UserTypeId tinyint NOT NULL,
		Name varchar(20) NOT NULL
	)
	GO

	CREATE TABLE UserRating
	(
		UserRatingId tinyint NOT NULL,
		Name varchar(20) NOT NULL
	)
	GO

--**************************************************
-- Insert data to tables.
--**************************************************
	
	INSERT INTO Genres
	(GenreId, Name)
	VALUES
	(1, 'Fantasy'),
	(2, 'Mystery'),
	(3, 'Thriller'),
	(4, 'Romance'),
	(5, 'Westerns'),
	(6, 'Dystopian'),
	(7, 'Contemporary');
	GO

	INSERT INTO BookConditions
	(BookConditionId, Name)
	VALUES
	(1, 'Excellent'),
	(2, 'Good'),
	(3, 'Normal'),
	(4, 'Poor');
	GO

	INSERT INTO UserTypes
	(UserTypeId, Name)
	VALUES
	(1, 'Visitor'),
	(2, 'Client');
	GO

	INSERT INTO UserRating
	(UserRatingId, Name)
	VALUES
	(1, 'Top'),
	(2, 'Hight'),
	(3, 'Middle'),
	(4, 'Low');
	GO
	
	INSERT INTO Books
	(Isbn, Title, BriefDescription, GenreId, Author, BookConditionId, Comment, RegistrationDate)
	VALUES
	('978-1-940313-09-2', 'Some Title of Book', 'Some brief description', 1, 'Some Author', 1, 'Some comment', '01/01/2021');
	GO

	INSERT INTO Books
	(Isbn, Title, BriefDescription, GenreId, Author, BookConditionId, Comment, RegistrationDate)
	VALUES
	('978-1-940313-09-3', 'Best car', NULL, 5, 'Gretch A.', 1, NULL, '01/01/2021'),
	('978-1-940313-09-4', 'Dark', NULL, 6, 'Pink S.', 1, NULL, '01/01/2021');
	GO

	INSERT INTO Users
	(FirstName, LastName, RegistrationDate, IsActive, UserTypeId, UserRatingId, Comment)
	VALUES
	('Joe', 'Jonson', '01/01/2021', 1, 1, 3, 'Some comment');
	GO

	INSERT INTO Users
	(FirstName, LastName, RegistrationDate, IsActive, UserTypeId, UserRatingId, Comment)
	VALUES
	('Barbara', 'Jonson', '01/01/2021', 1, 1, 3, NULL),
	('Sebastian', 'Green', '01/01/2021', 1, 1, 3, NULL);
	GO

--**************************************************
-- Select.
--**************************************************
	
	SELECT * FROM Books
	GO

	SELECT * FROM Books
	WHERE BookId < 2
	GO

	SELECT Title FROM Books
	WHERE BookId BETWEEN 2 AND 3
	GO

	SELECT Title, Author FROM Books
	WHERE GenreId = 5 OR GenreId = 6
	GO

	SELECT Title, GenreId FROM Books
	WHERE NOT GenreId = 1
	GO

	SELECT Title, Author FROM Books
	WHERE Author LIKE '%Some______r%'
	GO

	SELECT BookId, Title FROM Books
	WHERE BookId IN (1, 3)
	GO

--**************************************************
-- Order by.
--**************************************************
	
	SELECT * FROM Books
	ORDER BY Title
	GO

	SELECT * FROM Books
	ORDER BY Title DESC
	GO

--**************************************************
-- Group by.
--**************************************************
	
	INSERT INTO BooksInUse
	(BookId, UserId, TakingDate)
	VALUES
	(1, 1, '02/01/2021'),
	(2, 2, '03/01/2021'),
	(3, 2, '03/01/2021'),
	(4, 3, '03/01/2021')
	GO

	SELECT UserId, COUNT(BookId) AS BooksCount FROM BooksInUse
	GROUP BY UserId
	GO

	SELECT UserId, COUNT(BookId) AS BooksCount FROM BooksInUse
	GROUP BY UserId HAVING COUNT(BookId) > 1
	GO

--**************************************************
-- Update data.
--**************************************************
	
	UPDATE Users
	SET Comment = 'Test'
	WHERE LastName = 'Green'
	GO
	SELECT * FROM Users
	GO

	UPDATE Users
	SET Comment = NULL
	GO
	SELECT * FROM Users
	GO

--**************************************************
-- Delete data.
--**************************************************

	SELECT * FROM BooksInUse
	GO
	DELETE BooksInUse
	WHERE UserId = 2
	GO
	SELECT * FROM BooksInUse
	GO

	SELECT * FROM BooksInUse
	GO
	TRUNCATE TABLE BooksInUse
	SELECT * FROM BooksInUse
	GO

--**************************************************
-- Data Definition Language (DDL).
--**************************************************
	
	EXEC sp_helpdb LibraryDB
	
	ALTER DATABASE LibraryDB
	MODIFY FILE
	(
		NAME = 'LibraryDB',
		MAXSIZE = 20MB,
		FILEGROWTH = 5MB
	)
	GO

	SELECT * FROM UsingBooksHistory
	GO
	ALTER TABLE UsingBooksHistory
	ADD
	NewTestField tinyint NULL
	GO
	SELECT * FROM UsingBooksHistory
	GO

	SELECT * FROM UsingBooksHistory
	GO
	ALTER TABLE UsingBooksHistory
	DROP COLUMN
	NewTestField
	GO
	SELECT * FROM UsingBooksHistory
	GO

	ALTER TABLE Books
	ADD CONSTRAINT PK_Books
	PRIMARY KEY (BookId)
	GO
	
	ALTER TABLE Users
	ADD CONSTRAINT PK_Users
	PRIMARY KEY (UserId)
	GO

	ALTER TABLE BooksInUse
	ADD CONSTRAINT PK_BooksInUse
	PRIMARY KEY (BookId, UserId)
	GO

	ALTER TABLE BooksInUse
	DROP CONSTRAINT PK_BooksInUse
	GO

	ALTER TABLE BooksInUse
	ADD CONSTRAINT FK_BookId
	FOREIGN KEY (BookId) REFERENCES Books(BookId)
	ON UPDATE CASCADE
	ON DELETE CASCADE
	GO

	ALTER TABLE BooksInUse
	ADD CONSTRAINT FK_UserId
	FOREIGN KEY (UserId) REFERENCES Users(UserId)
	ON UPDATE CASCADE
	ON DELETE CASCADE
	GO

	SELECT * FROM sys.foreign_keys
	GO

	ALTER TABLE UsingBooksHistory
	ADD CONSTRAINT PK_UsingBooksHistory
	PRIMARY KEY (BookId, UserId, TimesNumber)
	GO

	ALTER TABLE Genres
	ADD CONSTRAINT PK_Genres
	PRIMARY KEY (GenreId)
	GO

	ALTER TABLE BookConditions
	ADD CONSTRAINT PK_BookConditions
	PRIMARY KEY (BookConditionId)
	GO

	ALTER TABLE UserTypes
	ADD CONSTRAINT PK_UserTypes
	PRIMARY KEY (UserTypeId)
	GO

	ALTER TABLE UserRating
	ADD CONSTRAINT PK_UserRating
	PRIMARY KEY (UserRatingId)
	GO

	SELECT * FROM Books
	GO
	ALTER TABLE Books
	ADD CHECK (Isbn LIKE '[0-9][0-9][0-9]-[0-9]-[0-9][0-9][0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9]')
	GO

--**************************************************
-- Join.
--**************************************************
	
	UPDATE Users
	SET UserRatingId = 2
	WHERE FirstName = 'Joe'
	GO
	UPDATE Users
	SET UserRatingId = 1
	WHERE FirstName = 'Barbara'
	GO
	SELECT * FROM Users
	GO

	SELECT Users.FirstName, Users.LastName, UserRating.Name AS RatingName FROM Users
	INNER JOIN UserRating
	ON Users.UserRatingId = UserRating.UserRatingId
	GO
	SELECT * FROM Users
	GO

	SELECT Users.FirstName, Users.LastName, UserRating.Name AS RatingName FROM Users
	LEFT OUTER JOIN UserRating
	ON Users.UserRatingId = UserRating.UserRatingId
	GO
	SELECT * FROM Users
	GO

	SELECT Users.FirstName, Users.LastName, UserRating.Name AS RatingName FROM Users
	RIGHT OUTER JOIN UserRating
	ON Users.UserRatingId = UserRating.UserRatingId
	GO
	SELECT * FROM Users
	GO

	SELECT Users.FirstName, Users.LastName, UserRating.Name AS RatingName FROM Users
	FULL OUTER JOIN UserRating
	ON Users.UserRatingId = UserRating.UserRatingId
	GO
	SELECT * FROM Users
	GO

	SELECT Users.UserId, Users.FirstName, Users.LastName, UserRating.Name AS RatingName FROM Users
	CROSS JOIN UserRating
	GO
	SELECT * FROM Users
	GO

--**************************************************
-- View.
--**************************************************
	
	CREATE VIEW BookView AS
	SELECT Isbn, Title, Author FROM Books
	GO
	SELECT * FROM BookView
	GO

	ALTER VIEW BookView AS
	SELECT Isbn, Title, Author FROM Books
	WHERE Books.BookConditionId = 1
	GO
	SELECT * FROM BookView
	GO

	DROP VIEW BookView
	GO

--**************************************************
-- Procedure.
--**************************************************
	
	CREATE PROC spUsers AS
	SELECT * FROM Users
	GO
	EXEC spUsers
	GO

	ALTER PROC spUsers AS
	SELECT * FROM Users
	WHERE UserRatingId = 1
	GO
	EXEC spUsers
	GO

	DROP PROC spUsers
	GO

	CREATE PROC spBooks
		@Title nvarchar(50) = ''
	AS
	SELECT * FROM Books
	WHERE Title LIKE @Title + '%'
	GO
	EXEC spBooks
	GO

	EXEC spBooks 'Some'
	GO

	DROP PROC spBooks
	GO

	CREATE PROC spTestReturn AS
	BEGIN
		DECLARE @TestVar tinyint = 255;
		RETURN @TestVar;
	END
	GO
	DECLARE @TestReturned tinyint
	EXEC @TestReturned = spTestReturn
	PRINT CAST(@TestReturned as varchar)
	GO
	DROP PROC spTestReturn
	GO

--**************************************************
-- Trigger.
--**************************************************
	
	CREATE TRIGGER BooksInUseTrigger
		ON BooksInUse
		FOR INSERT, UPDATE
	AS
		IF EXISTS
		(
			SELECT * FROM Inserted AS i
			JOIN Users u
			ON i.UserId = u.UserId
			WHERE u.UserRatingId > 2
		)
		BEGIN
			RAISERROR('The book cannot be provided - the rating of user is too low.', 1, 16)
			ROLLBACK TRAN
		END
	GO