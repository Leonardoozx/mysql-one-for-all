SELECT
  art.artist_name AS artista,
  alb.album_name AS album
FROM
  SpotifyClone.album alb
  INNER JOIN SpotifyClone.artist art ON art.artist_name = 'Elis Regina'
WHERE
  alb.artist_id = art.artist_id;