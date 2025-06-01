--This query selects the usernames of users who made comments, the message text of those comments, and the title of the content on which the comments were made by joining the Comments, Users, and Content tables.
SELECT Users.Username, Comments.MessageText, Content.Title
FROM Comments
JOIN Users ON Comments.UserID = Users.UserID
JOIN Content ON Comments.ContentID = Content.ContentID;

--This query joins the Playlists table with the Users table based on the UserID column to link each playlist with its creator. It selects the playlist name, the username of the creator, and the update date of each playlist.
SELECT Playlists.Name, Users.Username, Playlists.UpdateDate
FROM Playlists
JOIN Users ON Playlists.UserID = Users.UserID;

--This query joins the Users table with the UserViewedContent table based on the UserID column to link each user with the content they've viewed. Then it joins the Content table to retrieve information about the viewed content, including its title and type. Finally, it selects the username of the user, the title of the content, and the type of content.
SELECT Users.Username, Content.Title, Content.Type
FROM Users
JOIN UserViewedContent ON Users.UserID = UserViewedContent.UserID
JOIN Content ON UserViewedContent.ContentID = Content.ContentID;

--This query joins the Users table with the UserAdvertisements table based on the UserID column to link each user with the advertisements they've interacted with. Then it joins the Advertisements table to retrieve information about the advertisements, including their type and the number of clicks. Finally, it selects the username of the user, the type of advertisement, and the number of clicks.
SELECT Users.Username, Advertisements.Type, Advertisements.Clicks
FROM Users
JOIN UserAdvertisements ON Users.UserID = UserAdvertisements.UserID
JOIN Advertisements ON UserAdvertisements.AdID = Advertisements.AdID;

--This query joins the Users table with the Reports table based on the UserID column to link each user with the reports they've made. Then it joins the Videos table to retrieve information about the reported videos, and finally, it joins the Content table to fetch the title of the reported video. The query selects the username of the user, the title of the reported video, and the description of the report.
SELECT Users.Username, Content.Title, Reports.Description
FROM Users
JOIN Reports ON Users.UserID = Reports.UserID
JOIN Videos ON Reports.VideoID = Videos.VideoID
JOIN Content ON Videos.ContentID = Content.ContentID;

--This query joins the Comments table with the Users table based on the UserID column to associate each comment with its commenter. Then it joins the Content table to link the comment with the content it belongs to. Finally, it selects the username of the commenter, the message text of the comment, and the title of the content.
SELECT Users.Username, Comments.MessageText, Content.Title
FROM Comments
JOIN Users ON Comments.UserID = Users.UserID
JOIN Content ON Comments.ContentID = Content.ContentID;

--This query joins the Channels table with the ChannelContent table based on the ChannelID column to link each channel with the content they have created. Then it joins the Content table to retrieve information about the content, including its title and type. Finally, it selects the channel name, the title of the content, and the type of content.
SELECT Channels.ChannelName, Content.Title, Content.Type
FROM Channels
JOIN ChannelContent ON Channels.ChannelID = ChannelContent.ChannelID
JOIN Content ON ChannelContent.ContentID = Content.ContentID;

--This query links the Users table with the UserAddedContent table to associate each user with the videos they've added to their playlists. Then it joins the Videos table to retrieve information about the added videos. It also joins the ContentPlaylists table to link the added videos with their playlists, and finally, it joins the Playlists table to fetch the names of the playlists. The query selects the username of the user, the title of the video, and the name of the playlist.
SELECT Users.Username, Videos.Subtitles, Playlists.Name
FROM Users
JOIN UserAddedContent ON Users.UserID = UserAddedContent.UserID
JOIN Videos ON UserAddedContent.ContentID = Videos.VideoID
JOIN ContentPlaylists ON UserAddedContent.ContentID = ContentPlaylists.ContentID
JOIN Playlists ON ContentPlaylists.PlaylistID = Playlists.PlaylistID;


-------------------------------------------------------- inner join
--This query combines data from multiple tables using nested SELECT and JOIN statements to provide a comprehensive view of users and their associated channels, playlists, and videos has age more than 18.
SELECT u.UserID, u.Username, u.Email, u.Age, ch.ChannelID, ch.ChannelName,ch.CreateDate AS ChannelCreationDate, pl.PlaylistID,pl.Name AS PlaylistName,  pl.UpdateDate AS PlaylistUpdateDate, v.VideoID,  v.ContentID,   c.Title AS VideoTitle,  c.Description AS VideoDescription,  c.CreationDate AS VideoCreationDate
FROM Users u JOIN Channels ch ON u.UserID = ch.UserID
JOIN Playlists pl ON u.UserID = pl.UserID
JOIN ContentPlaylists cp ON pl.PlaylistID = cp.PlaylistID
JOIN Content c ON cp.ContentID = c.ContentID
JOIN  Videos v ON c.ContentID = v.ContentID
WHERE  u.UserID IN (
        SELECT UserID 
        FROM  Users 
        WHERE 
            Age > 18
    );

--Retrieve all videos uploaded by users who are aged 25 or younger:
SELECT *
FROM Videos
WHERE ContentID IN (
    SELECT ContentID
    FROM Content
    WHERE ContentID IN (
        SELECT ContentID
        FROM Users
        WHERE Age <= 25
    )
);

--Get all playlists created by users with the theme "dark":
SELECT *
FROM Playlists
WHERE UserID IN (
    SELECT UserID
    FROM Users
    WHERE Theme = 'dark'
);

--Retrieve the usernames of users who have reported videos:
SELECT Username
FROM Users
WHERE UserID IN (
    SELECT UserID
    FROM Reports
);

--Retrieve all comments on videos with more than 100 likes:

SELECT *
FROM Comments
WHERE ContentID IN (
    SELECT ContentID
    FROM Videos
    WHERE VideoID IN (
        SELECT VideoID
        FROM Content
        WHERE Likes > 100
    )
);

--Find all users who have added content to their watch later list:
SELECT *
FROM Users
WHERE UserID IN (
    SELECT UserID
    FROM UserWatchLater
);

----------------------------------------------------- views 

--This view will display the comments number of likes along with the associated message text.
CREATE VIEW PopularComments AS
SELECT MessageText, LikesCount
FROM Comments

--This view will list users who have interacted with the platform frequently, showing their usernames and the total number of comments they have posted.

CREATE VIEW ActiveUsers AS
SELECT u.Username, COUNT(c.UserID) AS TotalComments
FROM Users u
LEFT JOIN Comments c ON u.UserID = c.UserID
GROUP BY u.UserID, u.Username

--This View Will list Top 10 Trnding
CREATE VIEW TopTenTrending AS
SELECT top 10 *
FROM [dbo].[Trending]

--This view will display channels that are currently trending based on the number of subscribers.
CREATE VIEW TrendingChannels AS
SELECT c.ChannelName, a.SubscribersCount
FROM Channels c
JOIN Analytics a ON c.AnalyticsID = a.AnalyticsID

--This view will provide a breakdown of the types of content available on the platform along with the count of each type.
CREATE VIEW ContentTypes AS
SELECT Type, COUNT(ContentID) AS Count
FROM Content
GROUP BY Type;

-------------------------------------------------------------- procedure
--This script will alter the stored procedure sp_AddVideo and comment out the execution of the stored procedure so that it does not run immediately. 
ALTER PROCEDURE sp_AddVideo
    @VideoID INT, 
    @Subtitles VARCHAR(55)
WITH ENCRYPTION
AS
    INSERT INTO Videos (VideoID, Subtitles)
    VALUES (@VideoID, @Subtitles);

EXEC dbo.sp_AddVideo 54, 'English';


--Insert User Procedure: This procedure will insert a new user into the Users table.

CREATE PROCEDURE InsertUser
    @UserID INT,
    @Username CHAR(255),
    @Email VARCHAR(255),
    @Age INT,
    @Theme VARCHAR(6),
    @Password VARCHAR(55)
AS
    INSERT INTO Users (UserID, Username, Email, Age, Theme, Password)
    VALUES (@UserID, @Username, @Email, @Age, @Theme, @Password)

EXEC InsertUser @UserID = 101, @Username = 'example_user', @Email = 'user@example.com', @Age = 25, @Theme = 'light', @Password = 'password123'

--Insert Comment Procedure: This procedure will insert a new comment into the Comments table.

CREATE PROCEDURE InsertComment
    @CommentID INT,
    @LikesCount VARCHAR(55),
    @MessageText VARCHAR(55),
    @UserID INT,
    @ContentID INT
AS
    INSERT INTO Comments (CommentID, LikesCount, MessageText, UserID, ContentID)
    VALUES (@CommentID, @LikesCount, @MessageText, @UserID, @ContentID)

EXEC InsertComment @CommentID = 32, @LikesCount = '10', @MessageText = 'Great video!', @UserID = 1, @ContentID = 1

--Insert Advertisement Procedure: This procedure will insert a new advertisement into the Advertisements table.

CREATE PROCEDURE InsertAdvertisement
    @AdID INT,
    @Type VARCHAR(55),
    @Duration VARCHAR(55),
    @StartDate VARCHAR(55),
    @EndDate VARCHAR(55),
    @Cost DECIMAL(10,5),
    @Clicks VARCHAR(55)
AS
    INSERT INTO Advertisements (AdID, Type, Duration, StartDate, EndDate, Cost, Clicks)
    VALUES (@AdID, @Type, @Duration, @StartDate, @EndDate, @Cost, @Clicks)

EXEC InsertAdvertisement @AdID = 31, @Type = 'banner', @Duration = '30 seconds', @StartDate = '2024-05-29', @EndDate = '2024-06-29', @Cost = 100.00, @Clicks = '50'






















