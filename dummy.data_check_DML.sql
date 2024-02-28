SELECT * FROM poke_dex;
SELECT COUNT(*) FROM poke_dex;

-- 적어도 명의 트레이너는 포켓몬 종류 1가지 당 2개 미만을 가짐
-- 1) 종류별 보유 개수 출력
SELECT pt.id '트레이너 번호', pt.name '트레이너명',
       p.monster_id '포켓몬 도감번호', COUNT(p.monster_id) '보유 개수'
FROM pokemon p, pokemon_trainer pt
WHERE p.owner = pt.id
GROUP BY pt.id, pt.name, p.monster_id
ORDER BY pt.id, p.monster_id;

-- 2) 종류별 보유 개수가 종류 수와 동일한지 필터
SELECT m_cnt.트레이너_번호, m_cnt.트레이너명,
       COUNT(m_cnt.포켓몬_도감번호) 포켓몬_보유종류수, SUM(m_cnt.보유_개수) 포켓몬_보유수
FROM (SELECT pt.id 트레이너_번호, pt.name 트레이너명,
       p.monster_id 포켓몬_도감번호, COUNT(p.monster_id) AS 보유_개수
FROM pokemon p, pokemon_trainer pt
WHERE p.owner = pt.id
GROUP BY pt.id, pt.name, p.monster_id
ORDER BY pt.id, p.monster_id) AS m_cnt
GROUP BY m_cnt.트레이너_번호, m_cnt.트레이너명
HAVING 포켓몬_보유종류수 = 포켓몬_보유수;

-- 10명 이상의 트레이너가 보유한 포켓몬 확인
SELECT monster_id 몬스터_번호, COUNT(owner) 보유자_수
FROM pokemon
GROUP BY monster_id
HAVING 보유자_수 > 10
ORDER BY monster_id;

-- 진화형 포켓몬 보유 트레이너 수 확인
SELECT p.owner, COUNT(p.owner)
FROM pokemon p
LEFT JOIN poke_dex pd
# ON pokemon.monster_id = poke_dex.monster_id
USING (monster_id)
INNER JOIN pokemon_trainer pt
ON p.owner = pt.id
WHERE pd.evolves_from IS NOT NULL
GROUP BY p.owner
ORDER BY p.owner;