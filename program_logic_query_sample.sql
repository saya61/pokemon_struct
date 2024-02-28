-- 특정 트레이너가 보유한 포켓몬들의 속성에 대한 통계 도출
SELECT owner, pd.monster_type, COUNT(pd.monster_type) 타입별_보유_몬스터_수
FROM pokemon p
INNER JOIN poke_dex pd
USING (monster_id)
GROUP BY owner, pd.monster_type
ORDER BY owner, 타입별_보유_몬스터_수 DESC;

-- 포켓몬의 일반형과 진화형을 연결해 조회하는 JOIN 쿼리
SELECT pd1.monster_id, pd1.monster_name, pd1.evolves_from,
       pd2.monster_id, pd2.monster_name
FROM poke_dex pd1
INNER JOIN poke_dex pd2
ON pd1.evolves_from = pd2.monster_id;