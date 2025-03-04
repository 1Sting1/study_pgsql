do $$
declare
	var_min_temperature numeric(8,2) default 0;
	var_max_temperature numeric(8,2) default 30;
	var_step numeric(8,2) default 0.01;
	var_current_temperature numeric;
	var_index integer;
begin

var_current_temperature := var_min_temperature;

for var_index in var_min_temperature..var_max_temperature loop
begin
	raise notice 'var_current_temperature %', var_current_temperature;
    var_current_temperature := var_current_temperature + var_step;

end;
end loop;

end $$;
	