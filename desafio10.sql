SELECT
  REPLACE(song.song_name, "'", "’") AS nome,
  COUNT(hist.reproducted_song_id) AS reproducoes
FROM
  SpotifyClone.reproduction_history hist
  INNER JOIN SpotifyClone.song song ON song.song_id = hist.reproducted_song_id
WHERE
  reproducted_user_id IN (
    SELECT
      user_id
    FROM
      SpotifyClone.`user`
    WHERE
      user_plan IN (1, 4)
  )
GROUP BY
  nome
ORDER BY
  nome;