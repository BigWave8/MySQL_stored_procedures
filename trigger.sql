use oryshchak_7_18;
SET SQL_SAFE_UPDATES = 0;

/*1*/
/*GENDER*/
drop trigger if exists gender_integrity_delete;

Delimiter //
create trigger gender_integrity_delete
before delete
on gender for each row 
begin 
	update companion set companion.gender_id = null where companion.gender_id=old.id;
	update family_tree set family_tree.gender_id = null where family_tree.gender_id=old.id;
end //
Delimiter ;

/*FAFILY TREE VALUES*/
drop trigger if exists family_tree_values_integrity_insert;

Delimiter //
create trigger family_tree_values_integrity_insert
before insert
on family_tree_values for each row 
begin 
	if (select distinct id from family_tree where family_tree.id=new.family_tree_id) is Null
	then  signal sqlstate "45000" 
		set message_text = "Your can't insert this famaly_tree_id it not exist";
	end if;
	if (select distinct id from family_values where family_values.id=new.family_values_id) is Null
	then  signal sqlstate "45000" 
		set message_text = "Your can't insert this famaly_values_id it not exist";
	end if;
end //
Delimiter ;

drop trigger if exists family_tree_values_integrity_update;

Delimiter //
create trigger family_tree_values_integrity_update
before update
on family_tree_values for each row 
begin 
	if (select distinct id from family_tree where family_tree.id=new.family_tree_id) is Null
	then  signal sqlstate "45000" 
		set message_text = "Your can't update this famaly_tree_id it not exist";
	end if;
	if (select distinct id from family_values where family_values.id=new.family_values_id) is Null
	then  signal sqlstate "45000" 
		set message_text = "Your can't update this famaly_values_id it not exist";
	end if;
end //
Delimiter ;

/*COMPANION*/
drop trigger if exists companion_integrity_insert;

Delimiter //
create trigger companion_integrity_insert
before insert
on companion for each row 
begin 
if (select  distinct id from gender where gender.id=new.gender_id) is null 
	then signal sqlstate "45000" 
	set message_text = "Your can't insert this row, this gender don't exist";
end if;
end //
Delimiter ;
 
 drop trigger if exists companion_integrity_update;

Delimiter //
create trigger companion_integrity_update
before update
on companion for each row 
begin 
if (select  distinct id from gender where gender.id=new.gender_id) is null 
	then signal sqlstate "45000" 
	set message_text = "Your can't update this row, this gender don't exist";
end if;
end //
Delimiter ;

drop trigger if exists companion_integrity_delete;

Delimiter //
create trigger companion_integrity_delete
before delete
on family_tree for each row 
begin 
	update family_tree set family_tree.companion_id = null where family_tree.companion_id=old.id;
end //
Delimiter ;

/*FAMILY TREE*/
drop trigger if exists family_tree_integrity_insert;

Delimiter //
create trigger family_tree_integrity_insert
before insert
on family_tree for each row 
begin 
if (select distinct id from family_tree where family_tree.id=new.root_family_tree_id) is null 
	then signal sqlstate "45000" 
	set message_text = "Your can't insert this row, this root_family_tree_id don't exist";
end if;
if (select  distinct id from gender where gender.id=new.gender_id) is null 
	then signal sqlstate "45000" 
	set message_text = "Your can't insert this row, this gender don't exist";
end if;
if (select  distinct id from companion where companion.id=new.companion_id) is null 
	then signal sqlstate "45000" 
	set message_text = "Your can't insert this row, this gender don't exist";
end if;
end //
Delimiter ;

drop trigger if exists family_tree_integrity_update;

Delimiter //
create trigger family_tree_integrity_update
before insert
on family_tree for each row 
begin 
if (select distinct id from family_tree where family_tree.id=new.root_family_tree_id) is null 
	then signal sqlstate "45000" 
	set message_text = "Your can't update this row, this root_family_tree_id don't exist";
end if;
if (select  distinct id from gender where gender.id=new.gender_id) is null 
	then signal sqlstate "45000" 
	set message_text = "Your can't update this row, this gender don't exist";
end if;
if (select  distinct id from companion where companion.id=new.companion_id) is null 
	then signal sqlstate "45000" 
	set message_text = "Your can't update this row, this gender don't exist";
end if;
end //
Delimiter ;

/*FAMILY VALUES*/
drop trigger if exists family_values_integrity_delete;

delimiter !!
create trigger family_values_integrity_delete
before delete
on family_values for each row 
begin 
	delete family_tree_values from family_tree_values where family_tree_values.family_values_id=old.id;
end !!
Delimiter ;

/*2*/
drop trigger if exists companion_surname_check;

Delimiter //
create trigger companion_surname_check
after insert
on companion for each row 
begin 
	if(new.surname LIKE 'A%' or new.surname LIKE '%in' or new.surname LIKE '%ina') 
		then signal sqlstate "45000"
		set message_text = "Your insert is invalid surname. You can't start surname on 'A' or end on 'in' or 'ina'.";
    end if;
end //
Delimiter ;


/*3*/
drop trigger if exists family_values_code_check;

Delimiter //
create trigger family_values_code_check
after update
on family_values for each row 
begin 
	if(new.code NOT REGEXP '^[a-z|A-E|G-Z][[:digit:]]{3}\\/[a-z|A-Z]{2}$') 
		then signal sqlstate "45000"
		set message_text = "Your update is invalid code.";
    end if;
end //
Delimiter ;


/*4*/
drop trigger if exists family_values_logs_insert;

Delimiter //
create trigger family_values_logs_insert
after insert
on family_values for each row 
begin
	insert into logs(value_name,max_price,price,min_price,code,action) values 
    (new.value_name,new.max_price,new.price,new.min_price,new.code,"insert");
end //
Delimiter ;

drop trigger if exists family_values_logs_update;

Delimiter //
create trigger family_values_logs_update
after update
on family_values for each row 
begin
	insert into logs(value_name,max_price,price,min_price,code,action) values 
    (new.value_name,new.max_price,new.price,new.min_price,new.code,"update");
end //
Delimiter ;

drop trigger if exists family_values_logs_delete;

Delimiter //
create trigger family_values_logs_delete
after delete
on family_values for each row 
begin
	insert into logs(value_name,max_price,price,min_price,code,action) values 
    (old.value_name,old.max_price,old.price,old.min_price,old.code,"delete");
end //
Delimiter ;

drop table if exists logs;
create table logs like family_values;
alter table logs add log_time timestamp default current_timestamp;
alter table logs add action varchar(10);