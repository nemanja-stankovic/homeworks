DROP DATABASE IF EXISTS zdravstveni_kartoni;
CREATE DATABASE IF NOT EXISTS zdravstveni_kartoni;
USE zdravstveni_kartoni;

CREATE TABLE IF NOT EXISTS pacijent (
ime VARCHAR(90),
prezime  VARCHAR(90),
JMBG VARCHAR(90),
adresa  VARCHAR(150),
telefon VARCHAR(20),
br_licence_doktora VARCHAR(90)
);

CREATE TABLE IF NOT EXISTS doktor (
ime VARCHAR(90),
prezime  VARCHAR(90),
JMBG VARCHAR(90),
specijalizacija  VARCHAR(150),
broj_licence VARCHAR(20)
);


CREATE TABLE IF NOT EXISTS medikament (
naziv VARCHAR(90),
sifra  VARCHAR(90),
naziv_proizvodjaca VARCHAR(90)
);

CREATE TABLE IF NOT EXISTS bolest (
naziv_bolesti VARCHAR(90),
opis VARCHAR(90),
slika BLOB
);

CREATE TABLE IF NOT EXISTS proizvodjac (
naziv VARCHAR(90),
adresa  VARCHAR(90),
telefon VARCHAR(90)
);

CREATE TABLE IF NOT EXISTS boluje_od (
ime_pacijenta VARCHAR(90),
ime_doktora  VARCHAR(90),
naziv_bolesti VARCHAR(90),
datum_diojagnoze DATETIME
);

ALTER TABLE pacijent
ADD PRIMARY KEY (JMBG);

ALTER TABLE doktor
ADD PRIMARY KEY (broj_licence);

ALTER TABLE medikament
ADD PRIMARY KEY (sifra);

ALTER TABLE bolest
ADD PRIMARY KEY (naziv_bolesti);

ALTER TABLE proizvodjac
ADD PRIMARY KEY (naziv);

ALTER TABLE boluje_od
ADD PRIMARY KEY (ime_pacijenta);

ALTER TABLE bolest
ADD COLUMN id_bolesti INT NOT NULL AUTO_INCREMENT,
DROP PRIMARY KEY, ADD PRIMARY KEY (id_bolesti) ;

ALTER TABLE proizvodjac
ADD COLUMN id_proizvodjac INT NOT NULL AUTO_INCREMENT,
DROP PRIMARY KEY, ADD PRIMARY KEY (id_proizvodjac) ;

ALTER TABLE boluje_od
ADD COLUMN id_boluje_od INT NOT NULL AUTO_INCREMENT,
DROP PRIMARY KEY, ADD PRIMARY KEY (id_boluje_od) ;


ALTER TABLE pacijent
ADD CONSTRAINT fk_doktor_1 FOREIGN KEY (br_licence_doktora) REFERENCES doktor(broj_licence) ;

ALTER TABLE medikament
ADD COLUMN id_proizvodjac INT,
ADD CONSTRAINT fk_proizvodjac_1 FOREIGN KEY (id_proizvodjac) REFERENCES proizvodjac(id_proizvodjac),
DROP COLUMN naziv_proizvodjaca;

ALTER TABLE boluje_od
ADD COLUMN id_pacijent INT,
ADD COLUMN id_doktor INT,
ADD COLUMN id_bolest INT,
ADD CONSTRAINT fk_pacijent_1 FOREIGN KEY (id_pacijent) REFERENCES pacijent(JMBG) ,
ADD CONSTRAINT fk_doktor_2 FOREIGN KEY (id_doktor) REFERENCES doktor(broj_licence) ,
ADD CONSTRAINT bolest_1 FOREIGN KEY (id_bolest) REFERENCES bolest(id_bolesti),
DROP COLUMN ime_pacijenta,
DROP COLUMN ime_doktora,
DROP COLUMN naziv_bolesti;

ALTER TABLE bolest
DROP COLUMN slika;

CREATE TABLE IF NOT EXISTS recept(
id_recepta INT PRIMARY KEY AUTO_INCREMENT,
sifra_medikamenta VARCHAR(90),
id_doktora VARCHAR(90),
CONSTRAINT fk_medikament_1 FOREIGN KEY (sifra_medikamenta) REFERENCES medikament(sifra),
CONSTRAINT fk_doktor_3 FOREIGN KEY (id_doktora) REFERENCES doktor(broj_licence) 
);

INSERT INTO doktor (ime,prezime,JMBG,specijalizacija, broj_licence) VALUES ('Nemanja','Stankovic','0705989710080','hirurg', '545545');
INSERT INTO doktor (ime,prezime,JMBG,specijalizacija, broj_licence) VALUES ('Marko','Markovic','0895689710090','kardiolog', '600800');
INSERT INTO pacijent (ime,prezime,JMBG,adresa, telefon, br_licence_doktora) VALUES ('Petar','Petrovic','8956489710080','Nepoznata 1','045462368','545545');
INSERT INTO pacijent (ime,prezime,JMBG,adresa, telefon, br_licence_doktora) VALUES ('Dusko','Duskovic','7569825478541','Nepoznata 3','065462568','600800');
INSERT INTO bolest(naziv_bolesti,opis) VALUES('dijabetes','oboljenje pankreasa');
INSERT INTO bolest(naziv_bolesti,opis) VALUES('angina pektoris','oboljenje srca');
INSERT INTO bolest(naziv_bolesti,opis) VALUES('astma','hronicno oboljenje pluca');
INSERT INTO proizvodjac(naziv,adresa,telefon) VALUES('HERBALIFE','Nepoznata 8','222333');
INSERT INTO proizvodjac(naziv,adresa,telefon) VALUES('HEMOFARM','Nepoznata 6','555333');
INSERT INTO medikament(naziv,sifra,id_proizvodjac) VALUES('insulin','123456','2');
INSERT INTO medikament(naziv,sifra,id_proizvodjac)  VALUES('aspirin','654321','1');
INSERT INTO boluje_od(datum_diojagnoze,id_pacijent,id_doktor,id_bolest) VALUES('2023-01-17 09:32:16','1','545545','2');
INSERT INTO recept(sifra_medikamenta,id_doktora) VALUES('123456','545545');

/*
DELETE FROM doktor;
DELETE FROM pacijent;
DELETE FROM bolest;
DELETE FROM proizvodjac;
DELETE FROM medikament;
DELETE FROM boluje_od;
DELETE FROM recept;

DROP TABLE doktor;
DROP TABLE pacijent;
DROP TABLE bolest;
DROP TABLE proizvodjac;
DROP TABLE medikament;
DROP TABLE boluje_od;
DROP TABLE recept;
DROP DATABASE zdravstveni_kartoni;
  */
