use oryshchak_7_18;

/*1*/
drop procedure if exists insert_into_companion;

Delimiter //
create procedure insert_into_companion(
in name varchar(20),
surname varchar(20),
birthday_date varchar(20),
birthday_place varchar(20),
death_date varchar(20),
death_place varchar(20),
marriage_date varchar(20),
gender_id int
 )
begin 

insert into companion(name, surname, birthday_date, birthday_place, death_date, death_place, marriage_date, gender_id)
values (name, surname, birthday_date, birthday_place, death_date, death_place, marriage_date, gender_id);

end//
Delimiter ;

/*2*/
drop procedure if exists add_10_packets;

Delimiter //
create procedure add_10_packets()
begin 

declare n int;
set n = 1;
while n <= 10 
	do
		set @temp = Concat('Noname', n );
		INSERT INTO gender(gender) VALUES(@temp);
        set n = n + 1;
	end while;

end//
Delimiter ;

/*3*/
drop procedure if exists create_db_of_names;

Delimiter //
create procedure create_db_of_names()
begin

declare done int default false;
declare nameT, surnameT varchar(20);

declare companion_cursor cursor
for select name, surname from companion;

declare continue handler
for not found set done=true;

open companion_cursor;
myLoop: LOOP
	Fetch companion_cursor into nameT, surnameT;
    if done = true then leave myLoop;
    end if;
    set @delete_query = concat('drop database if exists ', nameT, surnameT);
    prepare delete_query from @delete_query;
    execute delete_query;
    deallocate prepare delete_query;
    set @temp_query = concat('CREATE DATABASE ', nameT, surnameT);
    prepare my_query from @temp_query;
    execute my_query;
    deallocate prepare my_query;
end loop;
CLOSE companion_cursor;
end//
Delimiter ;