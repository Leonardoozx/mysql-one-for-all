SELECT
  `user`.username AS usuario,
  (
    SELECT
      COUNT(hist.reproducted_song_id)
    FROM
      SpotifyClone.reproduction_history AS hist
    WHERE
      hist.reproducted_user_id = `user`.user_id
  ) AS qt_de_musicas_ouvidas,
  (
    SELECT
      ROUND(SUM(song_length) / 60, 2)
    FROM
      SpotifyClone.song
    WHERE
      song_id IN (
        SELECT
          reproducted_song_id
        FROM
          SpotifyClone.reproduction_history
        WHERE
          reproducted_user_id = `user`.user_id
      )
  ) AS total_minutos
FROM
  SpotifyClone.`user` AS `user`
ORDER BY
  `user`.username;