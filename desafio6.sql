SELECT
  CAST(MIN(plan.plan_price) AS DECIMAL(3, 2)) AS faturamento_minimo,
  CONVERT(MAX(plan.plan_price), CHAR) AS faturamento_maximo,
  CONVERT(
    ROUND(
      SUM(
        (
          SELECT
            plan_price
          FROM
            SpotifyClone.plan
          WHERE
            plan.plan_id = `user`.user_plan
        )
      ) / COUNT(`user`.user_id),
      2
    ),
    CHAR
  ) AS faturamento_medio,
  CONVERT(
    ROUND(
      SUM(
        (
          SELECT
            plan_price
          FROM
            SpotifyClone.plan
          WHERE
            plan.plan_id = `user`.user_plan
        )
      ),
      2
    ),
    CHAR
  ) AS faturamento_total
FROM
  SpotifyClone.plan AS plan
  INNER JOIN SpotifyClone.`user` AS `user` ON plan.plan_id = `user`.user_plan;