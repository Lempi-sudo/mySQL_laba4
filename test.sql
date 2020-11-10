use football_league;

#(2.1)  Создать триггер, который при удалении записи из одной 
#таблицы удаляет все связанные с ней данные из других таблиц. (AFTER DELETE)

delimiter //
create trigger delete_player after delete on team
for each row
begin
	delete from  player p where p.id_team=OLD.id_team;
end;//
delimiter ;

delete from team 
where id_team=3;


#2.2 - Создать триггер, выполняющий проверку изменяемых данных (BEFORE UPDATE)
delimiter //
create trigger upd_check_goals_and_assist BEFORE UPDATE ON player
for each row
begin
	if new.goals<0 then
		set new.goals=0;
	end if;
	if new.assist<0 then
		set new.assist=0;
	end if;
end ;//
delimiter ;


delimiter //
create trigger upd_check_place BEFORE UPDATE ON team
for each row
begin
	if new.place<=0 then
		set new.place=1;
	elseif new.place>20 then
		set new.place=20;
	end if;
end ;//
delimiter ;


#2.3 Создать триггер, заполняющий одно из полей таблицы на основе вводимых данных 
#(например, поле «Возраст» по вводимым данным поля «Дата рождения»). (BEFORE INSERT)

delimiter //
create trigger agе before insert on player
for each row
begin
	if NEW.birth_data is not null then
		insert into information_about_player(Age,idPlayer) value((YEAR(CURRENT_DATE) - YEAR(NEW.birth_data))
        -(DATE_FORMAT(CURRENT_DATE, '%m%d') < DATE_FORMAT(NEW.birth_data, '%m%d')),new.idPlayer);
	end if;
	end;//
delimiter ;



#2.4 Создать два триггера: первый осуществляет проверку целостности добавляемых данных в таблицу, 
#второй запрещает добавление данных при заданных условиях. (BEFORE INSERT, BEFORE INSERT).

delimiter //
create trigger check_is_not_null BEFORE INSERT ON player
for each row 
begin
	if new.fname is null or new.lname is null or new.id_team is null
	or new.birth_data is null or new.goals is null or new.assist is null then 
		signal sqlstate '45000' set message_text = 'data is null';
	end if ;
	if new.idPlayer<0 then 
		signal sqlstate '45000' set message_text = 'fatal: id_Player<0';
	end if;
end;//
delimiter ;

delimiter //
create trigger check_is_data_validation BEFORE INSERT ON player
for each row follows check_is_not_null
begin
	if LENGTH(new.fname)=0 OR LENGTH(new.fname)>45 OR LENGTH(new.lname)=0 OR LENGTH(new.lname)>45 then
		signal sqlstate '45000' set message_text = 'invalid name1';
	end if ;
	if new.id_team>20 or  new.id_team<=0 then 
		signal sqlstate '45000' set message_text = 'invalid id_team';
	end if ;
    if  new.birth_data>CURRENT_DATE or new.birth_data<'1960-01-01' then
		signal sqlstate '45000' set message_text = 'data out of range';	
	end if;
    if new.goals<=0 or new.assist<=0 then
		signal sqlstate '45000' set message_text = 'negativ number';	
	end if;
end;//
delimiter ;




