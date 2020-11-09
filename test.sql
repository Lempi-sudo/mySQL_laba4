use football_league;

#2.1 Создать триггер, который при удалении записи из одной 
#таблицы удаляет все связанные с ней данные из других таблиц. (AFTER DELETE)
delimiter //
create trigger delete_player after delete on team
for each row
begin
	delete from  player p where p.id_team=OLD.id_team;
end;//
delimiter ;

delete from team 
where id_team=5;


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
