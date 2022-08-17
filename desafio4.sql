SELECT
  `user`.username AS usuario,
  IF (
    (
      SELECT
        MAX(YEAR(hist.reproduction_date))
      FROM
        SpotifyClone.reproduction_history AS hist
      WHERE
        `user`.user_id = hist.reproducted_user_id
    ) < 2021,
    'Usuário inativo',
    'Usuário ativo'
  ) AS status_usuario
FROM
  SpotifyClone.`user` AS `user`
ORDER BY
  `user`.username;