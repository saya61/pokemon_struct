DROP TABLE IF EXISTS pokemon_skill;
DROP TABLE IF EXISTS poke_dex;
DROP TABLE IF EXISTS pokemon_trainer;
DROP TABLE IF EXISTS pokemon;

CREATE TABLE pokemon_skill (
    id INT PRIMARY KEY AUTO_INCREMENT,
    skill_name VARCHAR(20) NOT NULL,
    skill_effect VARCHAR(20) NOT NULL,
    skill_type VARCHAR(10) NOT NULL,
    skill_damage VARCHAR(10) NOT NULL
);

CREATE TABLE poke_dex (
    monster_id INT PRIMARY KEY COMMENT '도감 번호',
    monster_name VARCHAR(10) NOT NULL,
    monster_type VARCHAR(10) NOT NULL COMMENT '속성 타입',
    max_hp INT NOT NULL,
    evolution_stage INT DEFAULT 1 NOT NULL COMMENT '진화단계(1~3)',
    evolves_from INT NULL COMMENT '진화 전 형태',
    is_legendary BOOL DEFAULT FALSE,
    INDEX idx_monstertype (monster_type),
    FOREIGN KEY fk_evolvesfrom (evolves_from) REFERENCES poke_dex (monster_id),
    CONSTRAINT chk_evolutionstage_range CHECK ( evolution_stage BETWEEN 1 AND 3)
);

CREATE TABLE pokemon_trainer (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(20),
    trainer_type VARCHAR(20),
    FOREIGN KEY fk_trainertype_monsertype (trainer_type) REFERENCES poke_dex (monster_type)
);

CREATE TABLE pokemon (  -- 개별 레코드에 대한 고려
    id INT PRIMARY KEY AUTO_INCREMENT,
    monster_id INT NOT NULL,
    skill1 INT NOT NULL,    -- 반복일 때 데이터의 참조 출처 가리키기
    skill2 INT NOT NULL,    -- 참조 관계
    owner INT NULL COMMENT '소유자(트레이너), 야생 - null',
    nickname VARCHAR(20) NOT NULL,
    hp INT NOT NULL,
    is_surfable BOOLEAN DEFAULT FALSE,
    is_flyable BOOLEAN DEFAULT FALSE,
    FOREIGN KEY fk_pokemon_pokedex (monster_id) REFERENCES poke_dex (monster_id),
    FOREIGN KEY fk_pokemon_skill1 (skill1) REFERENCES pokemon_skill (id),
    FOREIGN KEY fk_pokemon_skill2 (skill2) REFERENCES pokemon_skill (id),
    FOREIGN KEY fk_pokemon_trainer (owner) REFERENCES pokemon_trainer (id)
);