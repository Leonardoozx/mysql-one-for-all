SELECT
  COUNT(hist.reproducted_song_id) AS quantidade_musicas_no_historico
FROM
  SpotifyClone.reproduction_history as hist
WHERE
  reproducted_user_id = (
    SELECT
      `user`.user_id
    FROM
      SpotifyClone.`user` AS `user`
    WHERE
      `user`.username = 'Barbara Liskov'
  );