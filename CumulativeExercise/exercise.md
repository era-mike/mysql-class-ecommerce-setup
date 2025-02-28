
## Project: Music Library Database

### Requirement 1: Create a new database
1. Create a new database for the music library. Name it however you like (e.g., “MusicArchive”).
2. Ensure it has the necessary character set and collation settings (you decide these).
3. Make sure you can connect to the database from your MySQL interface application (e.g., MySQL Workbench).

<details>
<summary>One Possible Solution</summary>

```sql
-- 1. Create database
CREATE DATABASE MusicArchive
  DEFAULT CHARACTER SET utf8mb4
  DEFAULT COLLATE utf8mb4_0900_ai_ci;

-- 2. Select the new database
USE MusicArchive;

-- 3. Test connection in MySQL Workbench or other tool
--    (No direct SQL statement for that, just do it in the tool)
```
</details>

---

### Requirement 2: Design three or four tables for your music library
Create the following tables (or similar) in your music library schema. Let **your table names** reflect normal day-to-day speech (e.g., “Song Info” instead of “song_info”), but be mindful that in actual MySQL syntax, you can’t have spaces in table names—so you might choose “SongInfo” or “Song_Information.” **Design the data types and constraints** yourself, but consider the following relationships:

1. **Artist Info**: Store details like Artist Name, Genre, Debut Year, etc.  
2. **Album Info**: Store details like Album Title, Release Year, Number of Tracks, or anything else you find relevant. Link each album to an artist (foreign key).  
3. **Song Info**: Store song details (Song Title, Duration, Track Number, etc.) and link them to the appropriate album.  
4. (Optional) **Playlist Info**: Store playlists. You could later join songs to playlists in a bridging table or store them however you see fit.

Here is some **sample data** you can use. Feel free to expand or modify it.  

**Artist Info (Example)**

| Artist Name    | Genre      | Debut Year |
|----------------|------------|------------|
| The Beatles    | Rock       | 1960       |
| Miles Davis    | Jazz       | 1944       |
| Taylor Swift   | Pop        | 2006       |
| Imagine Dragons| Pop/Rock   | 2008       |

**Album Info (Example)**

| Album Title           | Release Year | Artist Name    | Number of Tracks |
|-----------------------|--------------|----------------|------------------|
| Abbey Road            | 1969         | The Beatles    | 17               |
| Kind of Blue          | 1959         | Miles Davis    | 5                |
| 1989                  | 2014         | Taylor Swift   | 13               |
| Evolve                | 2017         | Imagine Dragons| 12               |

**Song Info (Example)**

| Song Title         | Album Title          | Duration (in seconds) | Track Number |
|--------------------|----------------------|-----------------------|--------------|
| Come Together      | Abbey Road          | 259                   | 1            |
| Maxwell’s Silver Hammer | Abbey Road     | 207                   | 3            |
| So What            | Kind of Blue        | 545                   | 1            |
| Welcome to New York| 1989                | 212                   | 1            |
| Delicate           | 1989                | 232                   | 5            |
| Believer           | Evolve              | 204                   | 1            |

<details>
<summary>One Possible Approach (Schema & Inserts)</summary>

```sql
USE MusicArchive;

-- Example 1: Artist Info
CREATE TABLE ArtistInfo (
  ArtistID INT AUTO_INCREMENT PRIMARY KEY,
  ArtistName VARCHAR(100) NOT NULL,
  Genre VARCHAR(50),
  DebutYear INT
);

-- Example 2: Album Info
CREATE TABLE AlbumInfo (
  AlbumID INT AUTO_INCREMENT PRIMARY KEY,
  AlbumTitle VARCHAR(150) NOT NULL,
  ReleaseYear INT,
  NumberOfTracks INT,
  ArtistID INT,
  CONSTRAINT fk_ArtistID
    FOREIGN KEY (ArtistID)
    REFERENCES ArtistInfo (ArtistID)
);

-- Example 3: Song Info
CREATE TABLE SongInfo (
  SongID INT AUTO_INCREMENT PRIMARY KEY,
  SongTitle VARCHAR(150) NOT NULL,
  Duration INT,
  TrackNumber INT,
  AlbumID INT,
  CONSTRAINT fk_AlbumID
    FOREIGN KEY (AlbumID)
    REFERENCES AlbumInfo (AlbumID)
);

-- Insert sample data into ArtistInfo
INSERT INTO ArtistInfo (ArtistName, Genre, DebutYear)
VALUES
('The Beatles', 'Rock', 1960),
('Miles Davis', 'Jazz', 1944),
('Taylor Swift', 'Pop', 2006),
('Imagine Dragons', 'Pop/Rock', 2008);

-- Insert sample data into AlbumInfo
-- Need to match the ArtistID from the ArtistInfo table
-- Example: "The Beatles" has ID 1, "Miles Davis" 2, "Taylor Swift" 3, "Imagine Dragons" 4
INSERT INTO AlbumInfo (AlbumTitle, ReleaseYear, NumberOfTracks, ArtistID)
VALUES
('Abbey Road', 1969, 17, 1),
('Kind of Blue', 1959, 5, 2),
('1989', 2014, 13, 3),
('Evolve', 2017, 12, 4);

-- Insert sample data into SongInfo
-- Need the AlbumID from AlbumInfo
-- Example: "Abbey Road" might be ID 1, "Kind of Blue" 2, "1989" 3, "Evolve" 4
INSERT INTO SongInfo (SongTitle, Duration, TrackNumber, AlbumID)
VALUES
('Come Together', 259, 1, 1),
('Maxwell’s Silver Hammer', 207, 3, 1),
('So What', 545, 1, 2),
('Welcome to New York', 212, 1, 3),
('Delicate', 232, 5, 3),
('Believer', 204, 1, 4);
```
</details>

---

### Requirement 3: Run basic CRUD operations
1. Select data from all tables to show the stored records.
2. Insert at least one new album and some associated songs.
3. Update a record (change a song’s duration, or an album’s track count).
4. Delete a record (perhaps remove one song).

<details>
<summary>One Possible Solution</summary>

```sql
-- 1. Select all data
SELECT * FROM ArtistInfo;
SELECT * FROM AlbumInfo;
SELECT * FROM SongInfo;

-- 2. Insert a new album
INSERT INTO AlbumInfo (AlbumTitle, ReleaseYear, NumberOfTracks, ArtistID)
VALUES ('Fearless', 2008, 13, 3); -- Suppose ArtistID=3 belongs to Taylor Swift

-- Then add songs for that new album
INSERT INTO SongInfo (SongTitle, Duration, TrackNumber, AlbumID)
VALUES ('Fifteen', 240, 3, 5); -- Assuming the newly inserted album gets ID=5

-- 3. Update a record
UPDATE SongInfo
SET Duration = 245
WHERE SongTitle = 'Fifteen';

-- 4. Delete a record (e.g., remove Maxwell’s Silver Hammer)
DELETE FROM SongInfo
WHERE SongTitle = 'Maxwell’s Silver Hammer';
```
</details>

---

### Requirement 4: Create a stored procedure that returns data
1. Create a stored procedure that accepts an artist name (or artist ID) as a parameter.
2. In the procedure, **return** (or SELECT) all the songs associated with that artist, or the total count of songs by that artist—your choice.

<details>
<summary>One Possible Solution</summary>

```sql
DELIMITER $$

CREATE PROCEDURE GetSongsByArtist(IN p_ArtistName VARCHAR(100))
BEGIN
  SELECT s.SongTitle, a.ArtistName
  FROM SongInfo s
  JOIN AlbumInfo al ON s.AlbumID = al.AlbumID
  JOIN ArtistInfo a ON al.ArtistID = a.ArtistID
  WHERE a.ArtistName = p_ArtistName;
END $$

DELIMITER ;

-- Usage:
CALL GetSongsByArtist('Taylor Swift');
```
</details>

---

### Requirement 5: Create a trigger
1. Create a table (e.g., “Album Log”) to store audit information about new albums inserted (Album Title, Date Inserted, etc.).
2. Create a trigger that fires after a new album is inserted into the “Album Info” table. It should insert a record into the “Album Log” table.

<details>
<summary>One Possible Solution</summary>

```sql
-- 1. Create Album Log table
CREATE TABLE AlbumLog (
  LogID INT AUTO_INCREMENT PRIMARY KEY,
  AlbumTitle VARCHAR(150),
  InsertedOn DATETIME
);

-- 2. Create trigger that logs new album insert
DELIMITER $$

CREATE TRIGGER trg_AfterInsertAlbum
AFTER INSERT
ON AlbumInfo
FOR EACH ROW
BEGIN
  INSERT INTO AlbumLog (AlbumTitle, InsertedOn)
  VALUES (NEW.AlbumTitle, NOW());
END $$

DELIMITER ;

-- Now, whenever a new album is inserted,
-- a record goes into AlbumLog automatically.
```
</details>

---

### Requirement 6: Use an index for performance
1. Add at least one index to improve query performance (e.g., index the `ArtistName` column or `AlbumTitle` column).
2. Write a query that benefits from this index (e.g., a search on album title).

<details>
<summary>One Possible Solution</summary>

```sql
-- Create index on ArtistName in ArtistInfo
CREATE INDEX idx_ArtistName
ON ArtistInfo (ArtistName);

-- Example query that could benefit from this index
SELECT *
FROM ArtistInfo
WHERE ArtistName LIKE 'T%';
```
</details>

---

### Requirement 7: Demonstrate an advanced SQL technique
1. Write a query that uses a **JOIN** across the three main tables (Artist, Album, Song).
2. (Optionally) incorporate a **subquery** (e.g., find the longest track from each album, or the total number of songs by each artist).

<details>
<summary>One Possible Solution</summary>

```sql
-- Example: Return songs with their album and artist info
SELECT a.ArtistName, al.AlbumTitle, s.SongTitle, s.Duration
FROM ArtistInfo a
JOIN AlbumInfo al ON a.ArtistID = al.ArtistID
JOIN SongInfo s ON al.AlbumID = s.AlbumID;

-- Example subquery: Return the album title and longest song duration for each album
SELECT AlbumTitle,
       (SELECT MAX(Duration)
        FROM SongInfo
        WHERE SongInfo.AlbumID = AlbumInfo.AlbumID) AS LongestTrack
FROM AlbumInfo;
```
</details>

---

### Requirement 8: Demonstrate a full backup and restore
1. Perform a SQL dump of your **entire** MusicArchive database.  
2. Restore that dump into a **new** database (e.g., “MusicArchive_Restored”).

*(Note: The exact command line or Workbench steps will vary by environment. Below is an example command-line snippet.)*

<details>
<summary>One Possible Approach</summary>

```bash
-- 1. Export the MusicArchive database (command-line example)
mysqldump -u root -p MusicArchive > MusicArchive_backup.sql

-- 2. Create a new database for restore
mysql -u root -p -e "CREATE DATABASE MusicArchive_Restored"

-- 3. Restore from the dump file into the new database
mysql -u root -p MusicArchive_Restored < MusicArchive_backup.sql
```
</details>

---

### Requirement 9: Discussion on backup strategies
**Short answer or discussion**: 
- Explain **full** vs. **incremental** backups and how you might schedule them.
- Discuss **MySQL events** or other scheduling tools that can automate backups.
- Outline how you would **restore** your database from a backup in a real-world scenario.

*(No code snippet here—this is to encourage a theoretical explanation.)*

---

### Requirement 10: Create a restricted user and connect as that user
1. Create a MySQL user with limited privileges (e.g., only SELECT).
2. Confirm that attempting to perform an INSERT, UPDATE, or DELETE operation fails for this user.


<details>
<summary>One Possible Solution</summary>

```sql
-- Replace 'limited_user' and 'YourSecurePassword' with your own values
CREATE USER 'limited_user'@'localhost' IDENTIFIED BY 'YourSecurePassword';

-- Grant SELECT privileges on the entire MusicArchive database
GRANT SELECT ON MusicArchive.* TO 'limited_user'@'localhost';

-- Flush privileges
FLUSH PRIVILEGES;

-- Attempting to INSERT/UPDATE/DELETE as 'limited_user'@'localhost' should fail
```
</details>

---

### Requirement 11: Verify user management and privilege concepts

1. Attempt to connect again as the limited user created earlier.
2. Grant additional privileges if necessary (e.g., `INSERT`, `UPDATE` on certain tables).
3. Confirm that the newly granted privileges now allow these operations.

<details>
<summary>One Possible Approach</summary>

```sql
-- Grant privileges to limited user
GRANT INSERT, UPDATE ON MusicArchive.AlbumInfo TO 'limited_user'@'localhost';
FLUSH PRIVILEGES;

-- Now test again with the limited user to see if they can INSERT/UPDATE on AlbumInfo.
```
</details>

---

### Requirement 12:  Build a Stored Procedure for a Summary Report

1. **Objective**: Create a stored procedure that returns a **complete** list of artists along with aggregated information about their albums and songs.  
2. Even if an artist **has no albums** or **no songs**, the artist should still appear in the result set. (This is why we need a **LEFT JOIN** instead of an **INNER JOIN**.)  
3. You may choose what aggregated information to display. Examples:  
   - The total number of albums per artist  
   - The total number of songs per artist  
   - The combined duration of all songs, etc.  

4. Optionally, allow the procedure to accept a parameter that filters results by genre or by a specific artist.

<details>
<summary>One Possible Solution</summary>

```sql
DELIMITER $$

CREATE PROCEDURE ArtistSongReport(IN p_Genre VARCHAR(50))
BEGIN
    SELECT a.ArtistName,
           a.Genre,
           COUNT(DISTINCT al.AlbumID) AS total_albums,
           COUNT(s.SongID) AS total_songs
    FROM ArtistInfo a
         -- Use LEFT JOIN to ensure artists appear even if they have no albums
         LEFT JOIN AlbumInfo al ON a.ArtistID = al.ArtistID
         -- Use LEFT JOIN again to ensure we pick up songs, even if an album has none
         LEFT JOIN SongInfo s ON al.AlbumID = s.AlbumID
    WHERE (p_Genre IS NULL OR p_Genre = '')
       OR a.Genre = p_Genre
    GROUP BY a.ArtistName, a.Genre;
END $$

DELIMITER ;

-- Usage Example:
-- 1) Return report for all genres:
CALL ArtistSongReport('');

-- 2) Return report only for Rock genre:
CALL ArtistSongReport('Rock');
```
</details>

---

### Requirement 13:  Create an Automated Event
1. Create an **event** that periodically performs a task. For example:
   - **Cleanup Event**: Remove entries from the “Album Log” table that are older than 30 days.
   - Schedule this event to run **once a day** at a specific time (e.g., 01:00 AM).
2. Ensure your MySQL server has the **event scheduler** enabled.
3. Verify the event runs as expected and modifies or removes the intended data.

<details>
<summary>One Possible Solution</summary>

```sql
-- Ensure event_scheduler is enabled:
-- SET GLOBAL event_scheduler = ON;

USE MusicArchive;

CREATE EVENT IF NOT EXISTS CleanupOldAlbumLog
ON SCHEDULE
  EVERY 1 DAY
  STARTS (CURRENT_TIMESTAMP + INTERVAL 1 HOUR)
DO
BEGIN
  DELETE FROM AlbumLog
  WHERE InsertedOn < (NOW() - INTERVAL 30 DAY);
END;
```
</details>

---

### Requirement 14:  Table Alterations

1. **Add a Column**: The marketing team wants to track each artist’s social media handle. Add a new column to the *Artist Info* table for storing, for example, a “Twitter Handle” or other relevant social handle.  
2. **Change a Column**: The current *Album Title* column in the *Album Info* table is sometimes too short for certain special-edition album names. Increase its length or alter its data type to accommodate longer titles.  
3. **Delete a Column**: The *Song Info* table has a column that’s no longer needed (pick any existing column, or create a temporary column if needed). Remove that column.

<details>
<summary>One Possible Solution</summary>

```sql
USE MusicArchive;

-- 1. Add a column to ArtistInfo
-- For example, add a column for the artist's Twitter handle:
ALTER TABLE ArtistInfo
ADD COLUMN TwitterHandle VARCHAR(50);

-- 2. Change a column's data type (AlbumTitle in AlbumInfo)
-- Suppose we want to increase from VARCHAR(150) to VARCHAR(255):
ALTER TABLE AlbumInfo
MODIFY COLUMN AlbumTitle VARCHAR(255) NOT NULL;

-- 3. Delete a column from SongInfo
-- For example, remove the TrackNumber column:
ALTER TABLE SongInfo
DROP COLUMN TrackNumber;
```
</details>

---

**Tip**: When altering columns, consider the impact on **existing** data. Always back up your table or test your changes in a safe environment before applying them to production.
---

**Tip**: If you need a different frequency (weekly, monthly) or time of day, adjust the schedule clause. Also, verify your MySQL configuration allows events to run by checking that `event_scheduler` is set to ON.

## Final Notes and Tips

- **Normalization**: Ensure you’re not duplicating data unnecessarily. Use proper primary and foreign keys to reduce redundancy.  
- **Data Types and Constraints**: Decide what data types make sense (e.g., `INT` for IDs, `VARCHAR` for names, etc.). Consider constraints like `NOT NULL`, `UNIQUE`, `CHECK`, or `DEFAULT` as appropriate.  
- **Performance Tuning**: If your queries are slow, consider additional indexing or optimizing your queries.  
- **Security**: Practice good user management—grant only the privileges actually needed.  

