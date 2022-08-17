DROP DATABASE IF EXISTS SpotifyClone;

CREATE DATABASE IF NOT EXISTS SpotifyClone;

CREATE TABLE SpotifyClone.plan(
  plan_id INT AUTO_INCREMENT,
  plan_name VARCHAR(12) NOT NULL,
  plan_price DOUBLE NOT NULL,
  CONSTRAINT PRIMARY KEY(plan_id)
) engine = InnoDB;

INSERT
  IGNORE INTO SpotifyClone.plan(plan_name, plan_price)
VALUES
  ("free", '0.00'),
  ("family", '7.99'),
  ("student", '5.99'),
  ("personal", '6.99');

CREATE TABLE IF NOT EXISTS SpotifyClone.`user`(
  user_id INT AUTO_INCREMENT,
  username VARCHAR(45) NOT NULL,
  age INT NOT NULL,
  signature_date DATE,
  user_plan INT,
  CONSTRAINT PRIMARY KEY(user_id),
  FOREIGN KEY (user_plan) REFERENCES SpotifyClone.plan (plan_id)
) engine = InnoDB;

INSERT INTO
  SpotifyClone.`user`(username, age, signature_date, user_plan)
VALUES
  ('Barbara Liskov', 82, '2019-10-20', 1),
  ('Robert Cecil', 58, '2017-01-06', 1),
  ('Ada Lovelace', 37, '2017-12-30', 2),
  ('Martin Fowler', 46, '2017-01-17', 2),
  ('Sandi Metz', 58, '2018-04-29', 2),
  ('Paulo Freie', 19, '2018-02-14', 3),
  ('Bell Hooks', 26, '2018-01-05', 3),
  ('Christopher Alexander', 85, '2019-06-05', 4),
  ('Judith Butler', 45, '2020-05-13', 4),
  ('Jorge Amado', 58, '2017-02-17', 4);

CREATE TABLE IF NOT EXISTS SpotifyClone.artist(
  artist_id INT AUTO_INCREMENT,
  artist_name VARCHAR(100) NOT NULL,
  CONSTRAINT PRIMARY KEY(artist_id)
) engine = InnoDB;

INSERT
  IGNORE INTO SpotifyClone.artist(artist_name)
VALUES
  ('Beyoncé'),
  ('Queen'),
  ('Elis Regina'),
  ('Baco Exu do Blues'),
  ('Blind Guardian'),
  ('Nina Simone');

CREATE TABLE SpotifyClone.album(
  album_id INT AUTO_INCREMENT,
  album_name VARCHAR(100),
  artist_id INT,
  release_date YEAR NOT NULL,
  CONSTRAINT PRIMARY KEY(album_id),
  FOREIGN KEY(artist_id) REFERENCES SpotifyClone.artist (artist_id)
) engine = InnoDB;

INSERT
  IGNORE INTO SpotifyClone.album(album_name, artist_id, release_date)
VALUES
  ('Renaissance', 1, 2022),
  ('Jazz', 2, 1978),
  ('Hot Space', 2, 1982),
  ('Falso Brilhante', 3, 1998),
  ('Vento de Maio', 3, 2001),
  ('QVVJFA?', 4, 2003),
  ('Somewhere Far Beyond', 5, 2007),
  ('I Put A Spell On You', 6, 2012);

CREATE TABLE SpotifyClone.song(
  song_id INT AUTO_INCREMENT,
  song_name VARCHAR(45) NOT NULL,
  song_album_id INT NOT NULL,
  song_artist_id INT NOT NULL,
  song_length INT NOT NULL,
  CONSTRAINT PRIMARY KEY (song_id),
  FOREIGN KEY (song_album_id) REFERENCES SpotifyClone.album (album_id),
  FOREIGN KEY (song_artist_id) REFERENCES SpotifyClone.artist (artist_id)
) engine = InnoDB;

INSERT INTO
  SpotifyClone.song(
    song_name,
    song_artist_id,
    song_album_id,
    song_length
  )
VALUES
  ('BREAK MY SOUL', 1, 1, 279),
  ("VIRGO'S GROOVE", 1, 1, 369),
  ('ALIEN SUPERSTAR', 1, 1, 116),
  ("Don't Stop Me Now", 2, 2, 203),
  ("Urder Pressure", 2, 3, 152),
  ('Como Nossos Pais', 3, 4, 105),
  (
    "O Medo de Amar é o Medo de Ser Livre",
    3,
    5,
    207
  ),
  ("Samba em Paris", 4, 6, 267),
  ("The Bard's Song", 5, 7, 244),
  ("Feeling Good", 6, 8, 100);

CREATE TABLE SpotifyClone.reproduction_history(
  reproducted_user_id INT NOT NULL,
  reproducted_song_id INT NOT NULL,
  reproduction_date DATETIME NOT NULL,
  CONSTRAINT PRIMARY KEY (
    reproducted_song_id,
    reproducted_user_id,
    reproduction_date
  ),
  FOREIGN KEY (reproducted_song_id) REFERENCES SpotifyClone.song (song_id),
  FOREIGN KEY (reproducted_user_id) REFERENCES SpotifyClone.`user` (user_id)
) engine = InnoDB;

INSERT INTO
  SpotifyClone.reproduction_history(
    reproducted_user_id,
    reproducted_song_id,
    reproduction_date
  )
VALUES
  (1, 8, '2022-02-28 10:45:55'),
  (1, 2, '2020-05-02 05:30:35'),
  (1, 10, '2020-03-06 11:22:33'),
  (2, 10, "2022-08-05 08:05:17"),
  (2, 7, "2020-01-02 07:40:33"),
  (3, 10, "2020-11-13 16:55:13"),
  (3, 2, "2020-12-05 18:38:30"),
  (4, 8, "2021-08-15 17:10:10"),
  (5, 8, "2022-01-09 01:44:33"),
  (5, 5, "2020-08-06 15:23:43"),
  (6, 7, "2017-01-24 00:31:17"),
  (6, 1, "2017-10-12 12:35:20"),
  (7, 4, "2011-12-15 22:30:49"),
  (8, 4, "2012-03-17 14:56:41"),
  (9, 9, "2022-02-24 21:14:22"),
  (10, 3, "2015-12-13 08:30:22");

CREATE TABLE SpotifyClone.user_following(
  user_id INT NOT NULL,
  followed_artist_id INT,
  CONSTRAINT PRIMARY KEY (user_id, followed_artist_id),
  FOREIGN KEY (user_id) REFERENCES SpotifyClone.`user` (user_id),
  FOREIGN KEY (followed_artist_id) REFERENCES SpotifyClone.artist (artist_id)
) engine = InnoDB;

INSERT INTO
  SpotifyClone.user_following(user_id, followed_artist_id)
VALUES
  (1, 1),
  (1, 2),
  (1, 3),
  (2, 1),
  (2, 3),
  (3, 2),
  (4, 4),
  (5, 5),
  (5, 6),
  (6, 6),
  (6, 1),
  (7, 6),
  (9, 3),
  (10, 2);