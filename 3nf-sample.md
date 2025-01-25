### **Exercise: Practicing CRUD Operations and Normalization**

#### **Objective:**
Students will:
1. Create a non-normalized table and practice basic CRUD operations.
2. Identify the challenges of working with non-normalized data.
3. Normalize the table to 1NF, 2NF, and 3NF, practicing CRUD operations, aggregate functions, and subqueries at each stage.

---

### **Step 1: Non-Normalized Table**
**Scenario:** A music library system storing song, artist, and album data.

**Non-Normalized Table Design:**
```sql
create table music_library (
    entry_id int primary key,
    artist_album_songs varchar(255), -- Artist, Album, and Songs combined in one column
    release_date date,
    total_duration int -- Total duration of all songs in the album
);
```

**Sample Data:**
| EntryID | Artist_Album_Songs                                    | Release_Date | Total_Duration |
|---------|-------------------------------------------------------|--------------|----------------|
| 1       | "The Beatles, Abbey Road, Come Together; Something"  | 1969-09-26   | 47             |
| 2       | "Queen, A Night at the Opera, Bohemian Rhapsody"     | 1975-11-21   | 43             |
| 3       | "Pink Floyd, The Wall, Comfortably Numb; Hey You"    | 1979-11-30   | 81             |

---

**Tasks:**
1. **Perform CRUD Operations:**
   - Add a new album by Led Zeppelin with "Stairway to Heaven."
   - Retrieve all albums released before 1970.
   - Update the total duration for "Abbey Road" to 48.
   - Delete the album by Pink Floyd.

2. **Challenges:**
   - **Difficulties Reading Data:** Retrieving songs from specific artists or albums is hard since all information is stored in a single column.
   - **Redundancy:** If "The Beatles" release another album, the artist name is repeated.
   - **Updates:** Modifying song details involves altering strings, risking errors.

---

### **Step 2: Normalize to 1NF**
**1NF Design:** Split multivalued `artist_album_songs` into separate columns and rows.

```sql
create table music_library_1nf (
    entry_id int,
    artist_name varchar(100),
    album_name varchar(100),
    song_name varchar(100),
    release_date date,
    duration int,
    primary key (entry_id, song_name)
);
```

**Sample Data:**
| EntryID | Artist_Name   | Album_Name           | Song_Name         | Release_Date | Duration |
|---------|---------------|----------------------|-------------------|--------------|----------|
| 1       | The Beatles   | Abbey Road          | Come Together     | 1969-09-26   | 4        |
| 1       | The Beatles   | Abbey Road          | Something         | 1969-09-26   | 3        |
| 2       | Queen         | A Night at the Opera| Bohemian Rhapsody | 1975-11-21   | 6        |
| 3       | Pink Floyd    | The Wall            | Comfortably Numb  | 1979-11-30   | 7        |
| 3       | Pink Floyd    | The Wall            | Hey You           | 1979-11-30   | 5        |

---

**Tasks:**
1. **Perform CRUD Operations:**
   - Add a song "Black Dog" from Led Zeppelin's album "IV."
   - Retrieve all songs by "The Beatles."
   - Update the duration of "Hey You" to 6 minutes.
   - Delete the album "A Night at the Opera."

2. **Aggregate Query:**
   - Find the total duration of all songs by "Pink Floyd."

3. **Challenges:**
   - **Better Retrieval:** Easier to fetch specific songs or artists but still redundant in artist and album names.
   - **Redundancy:** Artist and album information is repeated for each song.
   - **Complexity in Updates:** Updating album details requires altering multiple rows.

---

### **Step 3: Normalize to 2NF**
**2NF Design:** Separate artist and album details into their own tables.

**Tables:**
```sql
create table artists (
    artist_id int primary key,
    artist_name varchar(100)
);

create table albums (
    album_id int primary key,
    album_name varchar(100),
    artist_id int,
    release_date date,
    foreign key (artist_id) references artists(artist_id)
);

create table songs (
    song_id int primary key,
    song_name varchar(100),
    album_id int,
    duration int,
    foreign key (album_id) references albums(album_id)
);
```

**Sample Data:**
**Artists:**
| ArtistID | Artist_Name   |
|----------|---------------|
| 1        | The Beatles   |
| 2        | Queen         |
| 3        | Pink Floyd    |

**Albums:**
| AlbumID | Album_Name           | ArtistID | Release_Date |
|---------|-----------------------|----------|--------------|
| 1       | Abbey Road           | 1        | 1969-09-26   |
| 2       | A Night at the Opera | 2        | 1975-11-21   |
| 3       | The Wall             | 3        | 1979-11-30   |

**Songs:**
| SongID | Song_Name         | AlbumID | Album Duration |
|--------|-------------------|---------|----------------|
| 1      | Come Together     | 1       | 47             |
| 2      | Something         | 1       | 47             |
| 3      | Bohemian Rhapsody | 2       | 43             |
| 4      | Comfortably Numb  | 3       | 81             |
| 5      | Hey You           | 3       | 81             |

---

**Tasks:**
1. **Perform CRUD Operations:**
   - Add a new artist "Led Zeppelin" with their album "IV" and song "Black Dog."
   - Retrieve all albums by "The Beatles."
   - Update the release date of "The Wall" to 1980-01-01.
   - Delete the artist "Queen" and all their associated data.

2. **Subquery:**
   - Find all albums released after 1970 by artists with more than one album.

3. **Challenges:**
   - **Improved Update Efficiency:** Artist and album details stored once.
   - **Still Complex for Aggregates:** Requires joins to calculate total durations.

---
There’s a **transitive dependency** in the **Songs** table, where the `Album Duration` is dependent on the `AlbumID` rather than directly on the `SongID`. This violates **3NF**, even though the table is in **2NF**. Let’s demonstrate how to fix this and ensure the table adheres to **3NF**.

---

### **Data in 2NF**

#### **1. Artists Table**
| ArtistID | Artist_Name   |
|----------|---------------|
| 1        | The Beatles   |
| 2        | Queen         |
| 3        | Pink Floyd    |

#### **2. Albums Table**
| AlbumID | Album_Name           | ArtistID | Release_Date |
|---------|-----------------------|----------|--------------|
| 1       | Abbey Road           | 1        | 1969-09-26   |
| 2       | A Night at the Opera | 2        | 1975-11-21   |
| 3       | The Wall             | 3        | 1979-11-30   |

#### **3. Songs Table**
| SongID | Song_Name         | AlbumID | Album Duration |
|--------|-------------------|---------|----------------|
| 1      | Come Together     | 1       | 47             |
| 2      | Something         | 1       | 47             |
| 3      | Bohemian Rhapsody | 2       | 43             |
| 4      | Comfortably Numb  | 3       | 81             |
| 5      | Hey You           | 3       | 81             |

---

### **Issues with 2NF Data**
1. **Transitive Dependency**:
   - The `Album Duration` depends on the `AlbumID`, not the `SongID`. This means `Album Duration` is not functionally dependent on the primary key of the table (`SongID`).
   - If the duration of an album changes, it must be updated for all songs in that album, leading to redundancy and inconsistency risks.

2. **Update Anomalies**:
   - Changing the duration of "Abbey Road" requires updating multiple rows.

3. **Insert Anomalies**:
   - Inserting a new album requires adding a placeholder song to record its duration.

4. **Delete Anomalies**:
   - Deleting all songs for an album would lose the album’s duration.

---

### **Data in 3NF**

To fix this, we remove the transitive dependency by creating a new table for album durations. This ensures that each piece of data is stored only once and is fully dependent on its primary key.

#### **1. Artists Table**
| ArtistID | Artist_Name   |
|----------|---------------|
| 1        | The Beatles   |
| 2        | Queen         |
| 3        | Pink Floyd    |

#### **2. Albums Table**
| AlbumID | Album_Name           | ArtistID | Release_Date | Album_Duration |
|---------|-----------------------|----------|--------------|----------------|
| 1       | Abbey Road           | 1        | 1969-09-26   | 47             |
| 2       | A Night at the Opera | 2        | 1975-11-21   | 43             |
| 3       | The Wall             | 3        | 1979-11-30   | 81             |

#### **3. Songs Table**
| SongID | Song_Name         | AlbumID |
|--------|-------------------|---------|
| 1      | Come Together     | 1       |
| 2      | Something         | 1       |
| 3      | Bohemian Rhapsody | 2       |
| 4      | Comfortably Numb  | 3       |
| 5      | Hey You           | 3       |

---

### **Benefits of 3NF**
1. **No Redundancy**:
   - The `Album Duration` is stored only once in the `Albums` table, eliminating duplication in the `Songs` table.

2. **Update Efficiency**:
   - Changing the duration of an album requires updating only one row in the `Albums` table.

3. **Data Integrity**:
   - There’s no risk of inconsistent data for album durations across multiple rows.

4. **CRUD Operations**:
   - Operations are streamlined and maintain consistency across related data.

---

### **SQL Queries Demonstrating the Difference**

#### Query to Update Album Duration in 2NF:
```sql
update songs
set album_duration = 50
where albumid = 1;
-- Must update all rows for AlbumID = 1.
```

#### Query to Update Album Duration in 3NF:
```sql
update albums
set album_duration = 50
where albumid = 1;
-- Only one row needs to be updated.
```

#### Query to Retrieve Songs with Album Durations in 3NF:
```sql
select s.song_name, a.album_name, a.album_duration
from songs s
join albums a on s.albumid = a.albumid;
```

---

### **Conclusion**
By restructuring the schema into **3NF**, we eliminate the transitive dependency of `Album Duration` on `AlbumID`. This not only reduces redundancy but also ensures data consistency and makes the database more efficient to manage. The key distinction between **2NF** and **3NF** lies in resolving transitive dependencies, as demonstrated with the `Album Duration` attribute.