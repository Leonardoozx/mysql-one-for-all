SELECT
  COUNT(song.song_id) AS cancoes,
  (
    SELECT
      COUNT(art.artist_id)
    FROM
      SpotifyClone.artist AS art
  ) AS artistas,
  (
    SELECT
      COUNT(alb.album_id)
    FROM
      SpotifyClone.album AS alb
  ) AS albuns
FROM
  SpotifyClone.song AS song;