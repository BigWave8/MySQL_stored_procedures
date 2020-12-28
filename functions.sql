use oryshchak_7_18;

/*1*/
drop function if exists search_min_companions;

Delimiter //
create function search_min_companions()
returns varchar(20) DETERMINISTIC
begin

return (SELECT MIN(birthday_date) FROM companion);

end//
Delimiter ;

SELECT * FROM companion WHERE birthday_date = oryshchak_7_18.search_min_companions();


/*2*/
drop function if exists tree_id_companion;

Delimiter //
create function tree_id_companion(id int)
returns varchar(50) DETERMINISTIC
begin
	return (SELECT concat(companion.surname, companion.birthday_date) 
    FROM companion join family_tree on family_tree.companion_id = companion.id
    WHERE family_tree.companion_id=id);
end//
Delimiter ;

SELECT *, oryshchak_7_18.tree_id_companion(id) AS function_action FROM family_tree