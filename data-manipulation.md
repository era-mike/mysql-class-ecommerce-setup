Here are SQL tasks based on your provided database structure, along with their corresponding solutions inside collapsible markdown sections.

---

### **Task 1: Execute SQL Commands to Create Tables**
Create the `artists`, `albums`, and `songs` tables based on the given schema.

<details>
<summary>Solution</summary>

```sql
CREATE TABLE `artists` (
  `artist_id` int NOT NULL AUTO_INCREMENT,
  `artist_name` varchar(255) NOT NULL,
  `artist_date_of_birth` date DEFAULT NULL,
  PRIMARY KEY (`artist_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `albums` (
  `album_id` int NOT NULL AUTO_INCREMENT,
  `album_name` varchar(255) NOT NULL,
  `album_release_year` int DEFAULT NULL,
  `artist_id` int NOT NULL,
  PRIMARY KEY (`album_id`),
  KEY `artist_id` (`artist_id`),
  CONSTRAINT `albums_ibfk_1` FOREIGN KEY (`artist_id`) REFERENCES `artists` (`artist_id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `songs` (
  `song_id` int NOT NULL AUTO_INCREMENT,
  `song_name` varchar(255) NOT NULL,
  `song_length_in_seconds` int DEFAULT NULL,
  `album_id` int NOT NULL,
  PRIMARY KEY (`song_id`),
  KEY `album_id` (`album_id`),
  CONSTRAINT `songs_ibfk_1` FOREIGN KEY (`album_id`) REFERENCES `albums` (`album_id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
```

</details>

---

### **Task 2: Update a Table with a New Column**
Add a `genre` column to the `albums` table.

<details>
<summary>Solution</summary>

```sql
ALTER TABLE albums ADD COLUMN genre VARCHAR(100) DEFAULT NULL;
```

</details>

---

### **Task 3: Remove a Column from an Existing Table**
Remove the `song_length_in_seconds` column from the `songs` table.

<details>
<summary>Solution</summary>

```sql
ALTER TABLE songs DROP COLUMN song_length_in_seconds;
```

</details>

---

### **Task 4: Select Data from a Table Based on Conditions**
Retrieve all albums released after 2000.

<details>
<summary>Solution</summary>

```sql
SELECT * FROM albums WHERE album_release_year > 2000;
```

</details>

---

### **Task 5: Insert New Records into a Table**
Insert a new artist and an album for that artist.

<details>
<summary>Solution</summary>

```sql
INSERT INTO artists (artist_name, artist_date_of_birth) 
VALUES ('John Doe', '1985-06-15');

INSERT INTO albums (album_name, album_release_year, artist_id, genre) 
VALUES ('Greatest Hits', 2022, LAST_INSERT_ID(), 'Pop');
```

</details>

---

### **Task 6: Update Existing Records in a Table**
Change the genre of the album "Greatest Hits" to "Rock".

<details>
<summary>Solution</summary>

```sql
UPDATE albums 
SET genre = 'Rock' 
WHERE album_name = 'Greatest Hits';
```

</details>

---

### **Task 7: Delete Records from a Table**
Delete all songs from an album that was released before 1990.

<details>
<summary>Solution</summary>

```sql
DELETE FROM songs 
WHERE album_id IN (
    SELECT album_id FROM albums WHERE album_release_year < 1990
);
```

</details>

---

### **Task 8: Join Multiple Tables**
Retrieve all song names along with their album names and artist names.

<details>
<summary>Solution</summary>

```sql
SELECT s.song_name, a.album_name, ar.artist_name 
FROM songs s
JOIN albums a ON s.album_id = a.album_id
JOIN artists ar ON a.artist_id = ar.artist_id;
```

</details>

---

Let me know if you need modifications or additional queries! 🚀