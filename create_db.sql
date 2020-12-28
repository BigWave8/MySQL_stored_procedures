create database if not exists oryshchak_7_18;
use oryshchak_7_18;

drop table if exists companion;
drop table if exists family_tree;
drop table if exists family_values;
drop table if exists family_tree_values;
drop table if exists gender;

create table companion(
id int primary key auto_increment,
name varchar(20),
surname varchar(20),
birthday_date varchar(20),
birthday_place varchar(20),
death_date varchar(20),
death_place varchar(20),
marriage_date varchar(20),
gender_id int
);

create table family_tree(
id int primary key auto_increment,
name varchar(20),
surname varchar(20),
birthday_date varchar(20),
birthday_place varchar(20),
death_date varchar(20),
death_place varchar(20),
card_number varchar(20),
root_family_tree_id int,
gender_id int,
companion_id int
);

create table family_values(
id int primary key auto_increment,
value_name varchar(20),
max_price decimal,
price decimal,
min_price decimal,
code varchar(20)
);

create table family_tree_values(
id int primary key auto_increment,
family_tree_id int,
family_values_id int
);

create table gender(
id int primary key auto_increment,
gender varchar(20)
);

INSERT INTO gender (id, gender) VALUES
(1, "man"),
(2, "woman");

INSERT INTO companion (name, surname, birthday_date, birthday_place, death_date, death_place, marriage_date, gender_id) VALUES
("Adele", 	"Barrett", 	"1976-10-28", "Gibsons", 			"05/02/2013", 	"Inuvik", 			"13/02/1990", 	2),
("Brian", 	"Holden", 	"1966-12-25", "Morrovalle", 		"03/11/2013", 	"Sint-Pauwels", 	"19/02/1984", 	1),
("Alan",	"Wheeler",	"1976-05-27", "Laken",				"21/09/1995",	"Hulste",			"26/03/1988",	1),
("Kennedy",	"Miranda",	"1963-11-15", "Sint-Amandsberg",	"15/07/2011",	"Meißen",			"10/05/1987",	1),
("Uma",		"Talley",	"1956-04-28", "Peterborough",		"04/11/1998",	"Vehari",			"27/07/1982",	2),
("Garth",	"Kennedy",	"1961-01-02", "Richmond",			"26/01/1991",	"Varsenare",		"27/03/1983",	1),
("Ignacia",	"Petty",	"1969-03-23", "Lowell",				"07/01/2017",	"Kearny",			"07/05/1982",	2),
("Anne",	"Hardin",	"1970-09-13", "Uitbergen",			"26/05/2006",	"Annapolis Royal",	"10/05/1990",	2),
("Geoffrey","Hubbard",	"1972-04-19", "Lambert",			"03/03/2021",	"Ganganagar",		"02/01/1987",	1),
("Vielka",	"Ratliff",	"1978-03-02", "Zolder",				"10/02/2008",	"Sonnino",			"29/11/1982",	2);

INSERT INTO family_tree (name, surname, birthday_date, birthday_place, death_date, death_place, card_number, root_family_tree_id, gender_id, companion_id) VALUES
("Taras", 	"Franks", 		"Feb 14, 1980", "Pudukkottai",	"29-04-03", "Lviv",			"4716939381148",		1, 1, 2),
("Adrii", 	"Hickman", 		"11-07-90", 	"Miramichi",	"15-05-10", "Barranquilla",	"1234 5678 9022 1234",	1, 1, 4),
("Sofia", 	"Jensen",		"09-06-56", 	"Şanlıurfa",	"26-02-11", "Lviv",			"4539770968322",		1, 2, 3),
("Maria", 	"Humphrey", 	"06-08-96", 	"Melsbroek",	"06-11-15", "Colomiers",	"4916 9464 4087 4500",	1, 2, 1),
("Vova", 	"Fitzpatrick", 	"21-02-97", 	"Halle",		"17-04-15", "Subbiano",		"435640 5750783451",	1, 1, 8),
("Max", 	"Miles",		"09-05-85", 	"Lviv",			"28-03-05", "Lviv",			"4485 5705 9969 4328",	1, 1, 10),
("Joel", 	"Nolan", 		"09-11-72", 	"Waitakere",	"21-09-10", "Lviv",			"4716 675 73 9723",		1, 1, 9),
("Xanthus", "Gilliam", 		"09-05-85", 	"Lorient",		"09-01-13", "Lviv",			"4485 5705 9969 4328",	1, 1, 5),
("Dahlia", 	"Humphrey", 	"21-09-50", 	"Lissewege",	"28-03-05", "Bagh",			"4929 878 41 1996",		1, 2, 7),
("Kelly", 	"Schultz", 		"26-07-42", 	"Carluke",		"25-03-17", "Lviv",			"4916704488686",		1, 2, 6);

INSERT INTO family_values (value_name, max_price, price, min_price, code) VALUES
("silver", 	1358,	1000, 697, 50543),
("vater", 	3119,	2000, 116, 2679152),
("money",	9086,	5000, 690, 80670),
("phone", 	3377,	2500, 943, 49618049),
("laptop", 	3647,	2000, 423, 18049),
("glass",	4159,	2000, 919, 78496180499),
("diamond", 5998,	4000, 143, 27523409),
("wood", 	1171,	900,  771, 7728000),
("platina", 9733,	6500, 275, 369376620998496180),
("computer", 1942,	1500, 880, 45948909);

INSERT INTO family_tree_values (family_tree_id, family_values_id) VALUES
(1, 4),
(4, 3),
(5, 2),
(3, 6),
(2, 5),
(6, 8),
(8, 4),
(7, 2),
(1, 5),
(2, 8);