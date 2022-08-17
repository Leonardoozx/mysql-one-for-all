SELECT
  song.song_name AS cancao,
  (
    SELECT
      COUNT(hist.reproducted_user_id)
    FROM
      SpotifyClone.reproduction_history AS hist
    WHERE
      hist.reproducted_song_id = song_id
  ) AS reproducoes
FROM
  SpotifyClone.song AS song
ORDER BY
  reproducoes DESC,
  cancao
LIMIT
  2;