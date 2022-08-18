SELECT
  song_name AS nome_musica,
  REPLACE(
    REPLACE(
      REPLACE(
        REPLACE(
          REPLACE(song_name, 'SUPERSTAR', 'SUPERDEV'),
          'Amar',
          'Code Review'
        ),
        'Bard',
        'QA'
      ),
      'SOUL',
      'CODE'
    ),
    'Pais',
    'Pull Requests'
  ) AS novo_nome
FROM
  SpotifyClone.song
GROUP BY
  nome_musica,
  novo_nome
HAVING
  nome_musica <> novo_nome
ORDER BY
  nome_musica DESC;