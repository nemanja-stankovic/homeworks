DROP DATABASE IF EXISTS evidencija_proizvoda;
CREATE DATABASE IF NOT EXISTS evidencija_proizvoda;
USE evidencija_proizvoda;

CREATE TABLE IF NOT EXISTS kupac (
JMBG VARCHAR(90),
ime VARCHAR(90),
prezime  VARCHAR(90),
adresa  VARCHAR(150),
tel VARCHAR(20),
naziv_mesta VARCHAR(90)
);

CREATE TABLE IF NOT EXISTS mesto (
naziv_mesta VARCHAR(90),
zip VARCHAR(20),
zemlja VARCHAR(90)
);

CREATE TABLE IF NOT EXISTS materijal (
naziv_materijala VARCHAR(90),
opis VARCHAR(90),
slika BLOB
);

CREATE TABLE IF NOT EXISTS proizvod (
naziv_proizvoda VARCHAR(90),
opis VARCHAR(90),
slika BLOB,
cena FLOAT
);

CREATE TABLE IF NOT EXISTS sastavnica (
naziv_proizvoda VARCHAR(90),
naziv_materijala VARCHAR(90),
kolicina INT
);

CREATE TABLE IF NOT EXISTS kupovina_proizvoda (
naziv_proizvoda VARCHAR(90),
naziv_mesta VARCHAR(90),
ime_kupca VARCHAR(90),
kolicina INT,
ukupna_cena FLOAT,
datum DATETIME
);

ALTER TABLE kupac
ADD PRIMARY KEY (JMBG);

ALTER TABLE mesto
ADD PRIMARY KEY (zip);

ALTER TABLE materijal
ADD PRIMARY KEY (naziv_materijala);

ALTER TABLE proizvod
ADD PRIMARY KEY (naziv_proizvoda);

ALTER TABLE sastavnica
ADD PRIMARY KEY (naziv_proizvoda);

ALTER TABLE kupovina_proizvoda
ADD PRIMARY KEY (naziv_proizvoda);


ALTER TABLE kupac
ADD COLUMN id_kupac INT NOT NULL AUTO_INCREMENT,
DROP PRIMARY KEY, ADD PRIMARY KEY (id_kupac) ;


ALTER TABLE mesto
ADD COLUMN id_mesto INT NOT NULL AUTO_INCREMENT,
DROP PRIMARY KEY, ADD PRIMARY KEY (id_mesto) ;

ALTER TABLE materijal
ADD COLUMN id_materijal INT NOT NULL AUTO_INCREMENT,
DROP PRIMARY KEY, ADD PRIMARY KEY (id_materijal) ;


ALTER TABLE proizvod
ADD COLUMN id_proizvod INT NOT NULL AUTO_INCREMENT,
DROP PRIMARY KEY, ADD PRIMARY KEY (id_proizvod) ;

ALTER TABLE sastavnica
ADD COLUMN id_sastavnica INT NOT NULL AUTO_INCREMENT,
DROP PRIMARY KEY, ADD PRIMARY KEY (id_sastavnica) ;


ALTER TABLE kupovina_proizvoda
ADD COLUMN id_kupovina_proizvoda INT NOT NULL AUTO_INCREMENT,
DROP PRIMARY KEY, ADD PRIMARY KEY (id_kupovina_proizvoda) ;

ALTER TABLE kupac 
ADD COLUMN id_mesto INT ,
ADD CONSTRAINT fk_mesto_1 FOREIGN KEY (id_mesto) REFERENCES mesto(id_mesto),
DROP COLUMN naziv_mesta;

ALTER TABLE sastavnica
ADD COLUMN id_proizvod INT,
ADD COLUMN id_materijal INT,
ADD CONSTRAINT fk_proizvod_1 FOREIGN KEY (id_proizvod) REFERENCES proizvod(id_proizvod),
ADD CONSTRAINT fk_materijal_1 FOREIGN KEY (id_materijal) REFERENCES materijal(id_materijal),
DROP COLUMN naziv_proizvoda,
DROP COLUMN naziv_materijala;


ALTER TABLE kupovina_proizvoda
ADD COLUMN id_proizvod INT,
ADD COLUMN id_mesto INT,
ADD COLUMN id_kupac INT,
ADD CONSTRAINT fk_proizvod_2 FOREIGN KEY (id_proizvod) REFERENCES proizvod(id_proizvod),
ADD CONSTRAINT fk_mesto_2 FOREIGN KEY (id_mesto) REFERENCES mesto(id_mesto),
ADD CONSTRAINT fk_kupac_1 FOREIGN KEY (id_kupac) REFERENCES kupac(id_kupac),
DROP naziv_proizvoda,
DROP naziv_mesta,
DROP ime_kupca;


ALTER TABLE materijal
DROP COLUMN slika;

ALTER TABLE proizvod
DROP COLUMN slika;

ALTER TABLE kupac
RENAME COLUMN tel TO telefon;

CREATE TABLE IF NOT EXISTS proizvod_na_popustu(
id_proizvod_na_popustu INT PRIMARY KEY AUTO_INCREMENT,
id_proizvod INT,
id_materijal INT,
popust INT,
CONSTRAINT fk_proizvod_2 FOREIGN KEY (id_proizvod) REFERENCES proizvod(id_proizvod),
CONSTRAINT fk_materijal_2 FOREIGN KEY (id_materijal) REFERENCES materijal(naziv_materijala)
);

INSERT INTO mesto (naziv_mesta,ZIP,zemlja) VALUES ('Beograd','11 000','Srbija');
INSERT INTO mesto (naziv_mesta,ZIP,zemlja) VALUES ('Nis','18 000','Srbija');
INSERT INTO kupac (JMBG,ime,prezime,adresa, telefon,id_mesto) VALUES ('0705989710080','Nemanja','Stankovic','Niska 16b Kaludjerica','0643152368','1');
INSERT INTO kupac (JMBG,ime,prezime,adresa, telefon,id_mesto) VALUES ('0903549710120','Petar','Petrovic','Niska , Nis','064665161','2');
INSERT INTO materijal(naziv_materijala,opis) VALUES('brasno','TIP 500');
INSERT INTO materijal(naziv_materijala,opis) VALUES('brasno','TIP 400');
INSERT INTO proizvod(naziv_proizvoda,opis,cena) VALUES('brasno tip 500 Danubius','brasno','85');
INSERT INTO proizvod(naziv_proizvoda,opis,cena) VALUES('cokolada Milka 200gr','cokolada','380');
INSERT INTO proizvod(naziv_proizvoda,opis,cena) VALUES('mleko Imlek 1L','mleko','160');
INSERT INTO proizvod(naziv_proizvoda,opis,cena) VALUES('mleko Imlek 2L','mleko','260');
INSERT INTO proizvod_na_popustu(id_proizvod,id_materijal,popust) VALUES('1','1','20');
INSERT INTO kupovina_proizvoda(kolicina,ukupna_cena,datum,id_proizvod,id_mesto,id_kupac) VALUES('1','380','2023-01-17 09:32:16','2','1','1');
INSERT INTO sastavnica(kolicina,id_proizvod,id_materijal) VALUES('1','2','1');

 /*
DELETE FROM kupovina_proizvoda;
DELETE FROM sastavnica;
DELETE FROM proizvod_na_popustu;
DELETE FROM mesto;
DELETE FROM kupac;
DELETE FROM materijal;
DELETE FROM proizvod;

DROP TABLE kupovina_proizvoda;
DROP TABLE sastavnica;
DROP TABLE proizvod_na_popustu;
DROP TABLE mesto;
DROP TABLE kupac;
DROP TABLE materijal;
DROP TABLE proizvod;

DROP DATABASE evidencija_proizvoda;
 */