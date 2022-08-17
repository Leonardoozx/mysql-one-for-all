SELECT
  art.artist_name AS artista,
  album.album_name AS album,
  (
    SELECT
      COUNT(user_follow.user_id)
    FROM
      SpotifyClone.user_following AS user_follow
    WHERE
      album.artist_id = user_follow.followed_artist_id
    GROUP BY
      followed_artist_id
  ) AS seguidores
FROM
  SpotifyClone.artist AS art
  INNER JOIN SpotifyClone.album AS album ON SpotifyClone.album.artist_id = art.artist_id
ORDER BY
  seguidores DESC,
  artista,
  album;