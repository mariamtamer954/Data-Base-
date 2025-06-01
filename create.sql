CREATE DATABASE Youtube;

CREATE TABLE Users(
    UserID INT PRIMARY KEY,
    Username CHAR(255),
    Email VARCHAR(255),
    Age INT,
    Theme VARCHAR(6),
    Password VARCHAR(55)
);

CREATE TABLE Comments (
    CommentID INT PRIMARY KEY,
    LikesCount VARCHAR(55),
    MessageText VARCHAR(55),
    UserID INT,
    ContentID INT,
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (ContentID) REFERENCES Content(ContentID)
);

CREATE TABLE WatchLater (
    WatchLaterID INT PRIMARY KEY,
    AddedLater VARCHAR(55)
);

CREATE TABLE Downloads (
    DownloadID INT PRIMARY KEY,
    Size VARCHAR(55),
    Quality VARCHAR(55)
);

CREATE TABLE Trending (
    TrendingID INT PRIMARY KEY,
    RegionCode VARCHAR(55),
    Ranks VARCHAR(55)
);

CREATE TABLE Playlists (
    PlaylistID INT PRIMARY KEY,
    Name VARCHAR(55),
    UpdateDate VARCHAR(55),
    UserID INT,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

CREATE TABLE Advertisements (
    AdID INT PRIMARY KEY,
    Type VARCHAR(55),
    Duration VARCHAR(55),
    StartDate VARCHAR(55),
    EndDate VARCHAR(55),
    Cost DECIMAL(10,5),
    Clicks VARCHAR(55)
);

CREATE TABLE Analytics (
    AnalyticsID INT PRIMARY KEY,
    ViewersCount VARCHAR(55),
    VideosCount VARCHAR(55),
    SubscribersCount VARCHAR(55),
    ShortsCount VARCHAR(55)
);

CREATE TABLE Channels (
    ChannelID INT PRIMARY KEY,
    ChannelName VARCHAR(55),
    CreateDate VARCHAR(55),
    ProfilePic VARCHAR(55),
    Description VARCHAR(55),
    Verified VARCHAR(55),
    UserID INT,
    AnalyticsID INT,
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (AnalyticsID) REFERENCES Analytics(AnalyticsID)
);

CREATE TABLE Content (
    ContentID INT PRIMARY KEY,
    Description VARCHAR(55),
    Title VARCHAR(55),
    Type VARCHAR(55),
    CreationDate VARCHAR(55),
    Caption VARCHAR(55),
    Likes VARCHAR(55)
);

CREATE TABLE Videos (
    VideoID INT PRIMARY KEY,
    Subtitles VARCHAR(55),
    TrendingID INT,
    ContentID INT,
    FOREIGN KEY (TrendingID) REFERENCES Trending(TrendingID),
    FOREIGN KEY (ContentID) REFERENCES Content(ContentID)
);

CREATE TABLE Reports (
    ReportID INT PRIMARY KEY,
    Date VARCHAR(55),
    Description VARCHAR(55),
    UserID INT,
    VideoID INT,
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (VideoID) REFERENCES Videos(VideoID)
);

CREATE TABLE Shorts (
    ShortID INT PRIMARY KEY,
    Times VARCHAR(55)
);

CREATE TABLE Live (
    LiveID INT PRIMARY KEY,
    ViewersCount VARCHAR(55),
    ContentID INT,
    FOREIGN KEY (ContentID) REFERENCES Content(ContentID)
);

CREATE TABLE LiveChat (
    MessageID INT,
    LiveID INT,
    MessageContent VARCHAR(55),
    PRIMARY KEY (MessageID, LiveID),
    FOREIGN KEY (LiveID) REFERENCES Live(LiveID)
);

CREATE TABLE UserDownloads (
    UserID INT,
    DownloadID INT,
    PRIMARY KEY (UserID, DownloadID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (DownloadID) REFERENCES Downloads(DownloadID)
);

CREATE TABLE UserWatchLater (
    UserID INT,
    WatchLaterID INT,
    PRIMARY KEY (UserID, WatchLaterID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (WatchLaterID) REFERENCES WatchLater(WatchLaterID)
);

CREATE TABLE UserTrending (
    UserID INT,
    TrendingID INT,
    PRIMARY KEY (UserID, TrendingID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (TrendingID) REFERENCES Trending(TrendingID)
);

CREATE TABLE UserViewedContent (
    UserID INT,
    ContentID INT,
    PRIMARY KEY (UserID, ContentID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (ContentID) REFERENCES Content(ContentID)
);

CREATE TABLE UserAddedContent (
    UserID INT,
    ContentID INT,
    PRIMARY KEY (UserID, ContentID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (ContentID) REFERENCES Content(ContentID)
);

CREATE TABLE ContentPlaylists (
    ContentID INT,
    PlaylistID INT,
    PRIMARY KEY (ContentID, PlaylistID),
    FOREIGN KEY (ContentID) REFERENCES Content(ContentID),
    FOREIGN KEY (PlaylistID) REFERENCES Playlists(PlaylistID)
);

CREATE TABLE VideoWatchLater (
    VideoID INT,
    WatchLaterID INT,
    PRIMARY KEY (VideoID, WatchLaterID),
    FOREIGN KEY (VideoID) REFERENCES Videos(VideoID),
    FOREIGN KEY (WatchLaterID) REFERENCES WatchLater(WatchLaterID)
);

CREATE TABLE VideoDownloads (
    VideoID INT,
    DownloadID INT,
    PRIMARY KEY (VideoID, DownloadID),
    FOREIGN KEY (VideoID) REFERENCES Videos(VideoID),
    FOREIGN KEY (DownloadID) REFERENCES Downloads(DownloadID)
);

CREATE TABLE ContentAdvertisements (
    ContentID INT,
    AdID INT,
    PRIMARY KEY (ContentID, AdID),
    FOREIGN KEY (ContentID) REFERENCES Content(ContentID),
    FOREIGN KEY (AdID) REFERENCES Advertisements(AdID)
);

CREATE TABLE ChannelContent (
    ContentID INT,
    ChannelID INT,
    PRIMARY KEY (ContentID, ChannelID),
    FOREIGN KEY (ContentID) REFERENCES Content(ContentID),
    FOREIGN KEY (ChannelID) REFERENCES Channels(ChannelID)
);

CREATE TABLE UserAdvertisements (
    UserID INT,
    AdID INT,
    PRIMARY KEY (UserID, AdID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (AdID) REFERENCES Advertisements(AdID)
);

ALTER TABLE Shorts
ADD ContentID INT;

ALTER TABLE Shorts
ADD CONSTRAINT fk_content_id FOREIGN KEY (ContentID) REFERENCES Content(ContentID);


ALTER TABLE [dbo].[Channels]
ADD SubscribersCount varchar(255);
