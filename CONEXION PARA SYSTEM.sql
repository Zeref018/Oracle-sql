-- 1. Crear tipo objeto tFamilia
CREATE TYPE tFamilia AS OBJECT (
  idFamilia NUMBER,
  familia VARCHAR2(100)
);
/

-- 2. Crear tabla FAMILIA
CREATE TABLE FAMILIA (
    idFamilia NUMBER PRIMARY KEY,
    familia tFamilia
);
/

-- 3. Insertar datos en la tabla FAMILIA
INSERT INTO FAMILIA VALUES (1, tFamilia(1, 'Aves'));
INSERT INTO FAMILIA VALUES (2, tFamilia(2, 'Mamíferos'));
INSERT INTO FAMILIA VALUES (3, tFamilia(3, 'Peces'));

-- 4. Crear tipo colección tNombres
CREATE TYPE tNombres AS VARRAY(20) OF VARCHAR2(50);
/


CREATE TYPE tAnimal AS OBJECT (
    idAnimal NUMBER,
    idFamilia NUMBER,
    Animal VARCHAR2(50),
    nombres tNombres,
    MEMBER FUNCTION ejemplares RETURN VARCHAR2
);
/


CREATE TYPE BODY tAnimal AS
    MEMBER FUNCTION ejemplares RETURN VARCHAR2 IS
        num_ejemplares NUMBER := self.nombres.COUNT;
        especie VARCHAR2(50) := self.Animal;
    BEGIN
        RETURN 'Hay ' || num_ejemplares || ' animales de la especie ' || especie;
    END;
END;
/

-- 7. Crear tabla Animal
CREATE TABLE Animal OF tAnimal;

-- 8. Definir claves primarias y foráneas en tabla Animal
ALTER TABLE Animal ADD CONSTRAINT pk_idAnimal PRIMARY KEY (idAnimal);
ALTER TABLE Animal ADD CONSTRAINT fk_idFamilia FOREIGN KEY (idFamilia) REFERENCES FAMILIA(idFamilia);

-- 9. Insertar datos en la tabla Animal
INSERT INTO Animal VALUES (1, 1, 'Garza Real', tNombres('Calíope', 'Izaro'));
INSERT INTO Animal VALUES (2, 1, 'Garza Real', tNombres('Calíope', 'Izaro'));
INSERT INTO Animal VALUES (3, 1, 'Cigüeña Blanca', tNombres('Perica', 'Clara', 'Miranda'));
INSERT INTO Animal VALUES (4, 1, 'Cigüeña Blanca', tNombres('Perica', 'Clara', 'Miranda'));
INSERT INTO Animal VALUES (5, 1, 'Cigüeña Blanca', tNombres('Perica', 'Clara', 'Miranda'));
INSERT INTO Animal VALUES (6, 1, 'Gorrión', tNombres('Coco', 'Roco', 'Loco', 'Peco', 'Rico'));
INSERT INTO Animal VALUES (7, 1, 'Gorrión', tNombres('Coco', 'Roco', 'Loco', 'Peco', 'Rico'));
INSERT INTO Animal VALUES (8, 1, 'Gorrión', tNombres('Coco', 'Roco', 'Loco', 'Peco', 'Rico'));
INSERT INTO Animal VALUES (9, 1, 'Gorrión', tNombres('Coco', 'Roco', 'Loco', 'Peco', 'Rico'));
INSERT INTO Animal VALUES (10, 1, 'Gorrión', tNombres('Coco', 'Roco', 'Loco', 'Peco', 'Rico'));
INSERT INTO Animal VALUES (11, 1, 'Gorrión', tNombres('Coco', 'Roco', 'Loco', 'Peco', 'Rico'));
INSERT INTO Animal VALUES (12, 1, 'Gorrión', tNombres('Coco', 'Roco', 'Loco', 'Peco', 'Rico'));
INSERT INTO Animal VALUES (13, 2, 'Zorro', tNombres('Lucas', 'Mario'));
INSERT INTO Animal VALUES (14, 2, 'Zorro', tNombres('Lucas', 'Mario'));
INSERT INTO Animal VALUES (15, 2, 'Lobo', tNombres('Pedro', 'Pablo'));
INSERT INTO Animal VALUES (16, 2, 'Lobo', tNombres('Pedro', 'Pablo'));
INSERT INTO Animal VALUES (17, 2, 'Ciervo', tNombres('Bravo', 'Listo', 'Rojo', 'Astuto'));
INSERT INTO Animal VALUES (18, 3, 'Pez globo', tNombres('Nemo', 'Bubbles', 'Bolita'));
INSERT INTO Animal VALUES (19, 3, 'Pez payaso', tNombres('Marlin', 'Coral', 'Pepito'));
INSERT INTO Animal VALUES (20, 3, 'Ángel llama', tNombres('Azul', 'Dorado', 'Celeste', 'Rubí'));

-- 10. SELECT para obtener el listado de animales junto con su familia y la cadena indicando el número de ejemplares
SELECT a.idAnimal, f.familia, a.Animal, a.ejemplares() AS num_ejemplares
FROM Animal a
JOIN FAMILIA f ON a.idFamilia = f.idFamilia;
