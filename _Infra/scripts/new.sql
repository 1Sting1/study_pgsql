do $$
begin

/*
Скрипт создания информационной базы данных
Согласно технического задания https://git.hostfl.ru/VolovikovAlex/Study2025
Редакция 2025-02-12
Edit by valex
*/


/*
 1. Удаляем старые элементы
 ======================================
 */

raise notice 'Запускаем создание новой структуры базы данных meteo';
begin

	-- Связи
	alter table if exists public.measurment_input_params
	drop constraint if exists measurment_type_id_fk;

	alter table if exists public.employees
	drop constraint if exists military_rank_id_fk;

	alter table if exists public.measurment_baths
	drop constraint if exists measurment_input_param_id_fk;

	alter table if exists public.measurment_baths
	drop constraint if exists emploee_id_fk;


	-- Таблицы
	drop table if exists public.measurment_input_params;
	drop table if exists public.measurment_baths;
	drop table if exists public.employees;
	drop table if exists public.measurment_types;
	drop table if exists public.military_ranks;
	drop table if exists public.measurment_settings;

	-- Нумераторы
	drop sequence if exists public.measurment_input_params_seq;
	drop sequence if exists public.measurment_baths_seq;
	drop sequence if exists public.employees_seq;
	drop sequence if exists public.military_ranks_seq;
	drop sequence if exists public.measurment_types_seq;
end;

raise notice 'Удаление старых данных выполнено успешно';

/*
 2. Добавляем структуры данных
 ================================================
 */

-- Справочник должностей
create table military_ranks
(
	id integer primary key not null,
	description character varying(255)
);

insert into military_ranks(id, description)
values(1,'Рядовой'),(2,'Лейтенант');

create sequence military_ranks_seq start 3;

alter table military_ranks alter column id set default nextval('public.military_ranks_seq');

-- Пользователя
create table employees
(
    id integer primary key not null,
	name text,
	birthday timestamp ,
	military_rank_id integer
);

insert into employees(id, name, birthday,military_rank_id )
values(1, 'Воловиков Александр Сергеевич','1978-06-24', 2);

create sequence employees_seq start 2;

alter table employees alter column id set default nextval('public.employees_seq');


-- Устройства для измерения
create table measurment_types
(
   id integer primary key not null,
   short_name  character varying(50),
   description text
);

insert into measurment_types(id, short_name, description)
values(1, 'ДМК', 'Десантный метео комплекс'),
(2,'ВР','Ветровое ружье');

create sequence measurment_types_seq start 3;

alter table measurment_types alter column id set default nextval('public.measurment_types_seq');

-- Таблица с параметрами
create table measurment_input_params
(
    id integer primary key not null,
	measurment_type_id integer not null,
	height numeric(8,2) default 0,
	temperature numeric(8,2) default 0,
	pressure numeric(8,2) default 0,
	wind_direction numeric(8,2) default 0,
	wind_speed numeric(8,2) default 0,
	bullet_demolition_range numeric(8,2) default 0
);

insert into measurment_input_params(id, measurment_type_id, height, temperature, pressure, wind_direction,wind_speed )
values(1, 1, 100,12,34,0.2,45);

create sequence measurment_input_params_seq start 2;

alter table measurment_input_params alter column id set default nextval('public.measurment_input_params_seq');

-- Таблица с историей
create table measurment_baths
(
		id integer primary key not null,
		emploee_id integer not null,
		measurment_input_param_id integer not null,
		started timestamp default now()
);


insert into measurment_baths(id, emploee_id, measurment_input_param_id)
values(1, 1, 1);

create sequence measurment_baths_seq start 2;

alter table measurment_baths alter column id set default nextval('public.measurment_baths_seq');

-- Таблица с настройками
create table measurment_settings
(
	key character varying(100) primary key not null,
	value  character varying(255) ,
	description text
);


insert into measurment_settings(key, value, description)
values('min_temperature', '-10', 'Минимальное значение температуры'),
('max_temperature', '50', 'Максимальное значение температуры'),
('min_pressure','500','Минимальное значение давления'),
('max_pressure','900','Максимальное значение давления'),
('min_wind_direction','0','Минимальное значение направления ветра'),
('max_wind_direction','59','Максимальное значение направления ветра'),
('calc_table_temperature','15.9','Табличное значение температуры'),
('calc_table_pressure','750','Табличное значение наземного давления'),
('min_height','0','Минимальная высота'),
('max_height','400','Максимальная высота');


raise notice 'Создание общих справочников и наполнение выполнено успешно';

/*
 3. Подготовка расчетных структур
 ==========================================
 */

drop table if exists calc_temperatures_correction;
create table calc_temperatures_correction
(
   temperature numeric(8,2) primary key,
   correction numeric(8,2)
);

insert into public.calc_temperatures_correction(temperature, correction)
Values(0, 0.5),(5, 0.5),(10, 1), (20,1), (25, 2), (30, 3.5), (40, 4.5);

drop type  if exists interpolation_type;
create type interpolation_type as
(
	x0 numeric(8,2),
	x1 numeric(8,2),
	y0 numeric(8,2),
	y1 numeric(8,2)
);

drop type if exists input_params cascade;
create type input_params as
(
	height numeric(8,2),
	temperature numeric(8,2),
	pressure numeric(8,2),
	wind_direction numeric(8,2),
	wind_speed numeric(8,2),
	bullet_demolition_range numeric(8,2)
);

raise notice 'Расчетные структуры сформированы';

/*
 4. Создание связей
 ==========================================
 */

begin

	alter table public.measurment_baths
	add constraint emploee_id_fk
	foreign key (emploee_id)
	references public.employees (id);

	alter table public.measurment_baths
	add constraint measurment_input_param_id_fk
	foreign key(measurment_input_param_id)
	references public.measurment_input_params(id);

	alter table public.measurment_input_params
	add constraint measurment_type_id_fk
	foreign key(measurment_type_id)
	references public.measurment_types (id);

	alter table public.employees
	add constraint military_rank_id_fk
	foreign key(military_rank_id)
	references public.military_ranks (id);

end;

raise notice 'Связи сформированы';

/*
 4. Создает расчетные и вспомогательные функции
 ==========================================
 */

-- Функция для расчета отклонения приземной виртуальной температуры
drop function if exists   public.fn_calc_header_temperature;
create function public.fn_calc_header_temperature(
	par_temperature numeric(8,2))
    returns numeric(8,2)
    language 'plpgsql'
as $BODY$
declare
	default_temperature numeric(8,2) default 15.9;
	default_temperature_key character varying default 'calc_table_temperature' ;
	virtual_temperature numeric(8,2) default 0;
	deltaTv numeric(8,2) default 0;
	var_result numeric(8,2) default 0;
begin

	raise notice 'Расчет отклонения приземной виртуальной температуры по температуре %', par_temperature;

	-- Определим табличное значение температуры
	Select coalesce(value::numeric(8,2), default_temperature)
	from public.measurment_settings
	into virtual_temperature
	where
		key = default_temperature_key;

    -- Вирутальная поправка
	deltaTv := par_temperature +
		public.fn_calc_temperature_interpolation(par_temperature => par_temperature);

	-- Отклонение приземной виртуальной температуры
	var_result := deltaTv - virtual_temperature;

	return var_result;
end;
$BODY$;


-- Функция для формирования даты в специальном формате
drop function if exists public.fn_calc_header_period;
create function public.fn_calc_header_period(
	par_period timestamp with time zone)
    RETURNS text
    LANGUAGE 'sql'
    COST 100
    VOLATILE PARALLEL UNSAFE

RETURN ((((CASE WHEN (EXTRACT(day FROM par_period) < (10)::numeric) THEN '0'::text ELSE ''::text END || (EXTRACT(day FROM par_period))::text) || CASE WHEN (EXTRACT(hour FROM par_period) < (10)::numeric) THEN '0'::text ELSE ''::text END) || (EXTRACT(hour FROM par_period))::text) || "left"(CASE WHEN (EXTRACT(minute FROM par_period) < (10)::numeric) THEN '0'::text ELSE (EXTRACT(minute FROM par_period))::text END, 1));


-- Функция для расчета отклонения наземного давления
drop function if exists public.fn_calc_header_pressure;
create function public.fn_calc_header_pressure
(
	par_pressure numeric(8,2))
	returns numeric(8,2)
	language 'plpgsql'
as $body$
declare
	default_pressure numeric(8,2) default 750;
	table_pressure numeric(8,2) default null;
	default_pressure_key character varying default 'calc_table_pressure' ;
begin

	raise notice 'Расчет отклонения наземного давления для %', par_pressure;

	-- Определяем граничное табличное значение
	if not exists (select 1 from public.measurment_settings where key = default_pressure_key ) then
	Begin
		table_pressure :=  default_pressure;
	end;
	else
	begin
		select value::numeric(18,2)
		into table_pressure
		from  public.measurment_settings where key = default_pressure_key;
	end;
	end if;


	-- Результат
	return par_pressure - coalesce(table_pressure,table_pressure) ;

end;
$body$;


-- Функция для проверки входных параметров
drop function if exists public.fn_check_input_params(numeric(8,2), numeric(8,2),   numeric(8,2), numeric(8,2), numeric(8,2), numeric(8,2));
create function public.fn_check_input_params(
	par_height numeric(8,2),
	par_temperature numeric(8,2),
	par_pressure numeric(8,2),
	par_wind_direction numeric(8,2),
	par_wind_speed numeric(8,2),
	par_bullet_demolition_range numeric(8,2)
)
returns public.input_params
language 'plpgsql'
as $body$
declare
	var_result public.input_params;
begin


	-- Температура
	if not exists (
		select 1 from (
				select
						coalesce(min_temperature , '0')::numeric(8,2) as min_temperature,
						coalesce(max_temperature, '0')::numeric(8,2) as max_temperature
				from
				(select 1 ) as t
					cross join
					( select value as  min_temperature from public.measurment_settings where key = 'min_temperature' ) as t1
					cross join
					( select value as  max_temperature from public.measurment_settings where key = 'max_temperature' ) as t2
				) as t
			where
				par_temperature between min_temperature and max_temperature
			) then

			raise exception 'Температура % не укладывает в диаппазон!', par_temperature;
	end if;

	var_result.temperature = par_temperature;


	-- Давление
	if not exists (
		select 1 from (
			select
					coalesce(min_pressure , '0')::numeric(8,2) as min_pressure,
					coalesce(max_pressure, '0')::numeric(8,2) as max_pressure
			from
			(select 1 ) as t
				cross join
				( select value as  min_pressure from public.measurment_settings where key = 'min_pressure' ) as t1
				cross join
				( select value as  max_pressure from public.measurment_settings where key = 'max_pressure' ) as t2
			) as t
			where
				par_pressure between min_pressure and max_pressure
				) then

			raise exception 'Давление % не укладывает в диаппазон!', par_pressure;
	end if;

	var_result.pressure = par_pressure;

		-- Высота
		if not exists (
			select 1 from (
				select
						coalesce(min_height , '0')::numeric(8,2) as min_height,
						coalesce(max_height, '0')::numeric(8,2) as  max_height
				from
				(select 1 ) as t
					cross join
					( select value as  min_height from public.measurment_settings where key = 'min_height' ) as t1
					cross join
					( select value as  max_height from public.measurment_settings where key = 'max_height' ) as t2
				) as t
				where
				par_height between min_height and max_height
				) then

				raise exception 'Высота % не укладывает в диаппазон!', par_height;
		end if;

		var_result.height = par_height;

		-- Напрвление ветра
		if not exists (
			select 1 from (
				select
						coalesce(min_wind_direction , '0')::numeric(8,2) as min_wind_direction,
						coalesce(max_wind_direction, '0')::numeric(8,2) as max_wind_direction
				from
				(select 1 ) as t
					cross join
					( select value as  min_wind_direction from public.measurment_settings where key = 'min_wind_direction' ) as t1
					cross join
					( select value as  max_wind_direction from public.measurment_settings where key = 'max_wind_direction' ) as t2
			)
				where
				par_wind_direction between min_wind_direction and max_wind_direction
			) then

			raise exception 'Направление ветра % не укладывает в диаппазон!', par_wind_direction;
	end if;

	var_result.wind_direction = par_wind_direction;
	var_result.wind_speed = par_wind_speed;

	return var_result;

end;
$body$;

-- Функция для проверки параметров
drop function if exists public.fn_check_input_params(input_params);
create function public.fn_check_input_params(
	par_param input_params
)
returns public.input_params
language 'plpgsql'
as $body$
declare
	var_result input_params;
begin

	var_result := fn_check_input_params(
		par_param.height, par_param.temperature, par_param.pressure, par_param.wind_direction,
		par_param.wind_speed, par_param.bullet_demolition_range
	);

	return var_result;

end ;
$body$;

-- Функция для расчета интерполяции
drop function if exists public.fn_calc_temperature_interpolation;
create function public.fn_calc_temperature_interpolation(
		par_temperature numeric(8,2))
		returns numeric
		language 'plpgsql'
as $body$
	-- Расчет интерполяции
	declare
			var_interpolation interpolation_type;
	        var_result numeric(8,2) default 0;
	        var_min_temparure numeric(8,2) default 0;
	        var_max_temperature numeric(8,2) default 0;
	        var_denominator numeric(8,2) default 0;
	begin

  				raise notice 'Расчет интерполяции для температуры %', par_temperature;

                -- Проверим, возможно температура совпадает со значением в справочнике
                if exists (select 1 from public.calc_temperatures_correction where temperature = par_temperature ) then
                begin
                        select correction
                        into  var_result
                        from  public.calc_temperatures_correction
                        where
                                temperature = par_temperature;
                end;
                else
                begin
                        -- Получим диапазон в котором работают поправки
                        select min(temperature), max(temperature)
                        into var_min_temparure, var_max_temperature
                        from public.calc_temperatures_correction;

                        if par_temperature < var_min_temparure or
                           par_temperature > var_max_temperature then

                                raise exception 'Некорректно передан параметр! Невозможно рассчитать поправку. Значение должно укладываться в диаппазон: %, %',
                                        var_min_temparure, var_max_temperature;
                        end if;

                        -- Получим граничные параметры

                        select x0, y0, x1, y1
						 into var_interpolation.x0, var_interpolation.y0, var_interpolation.x1, var_interpolation.y1
                        from
                        (
                                select t1.temperature as x0, t1.correction as y0
                                from public.calc_temperatures_correction as t1
                                where t1.temperature <= par_temperature
                                order by t1.temperature desc
                                limit 1
                        ) as leftPart
                        cross join
                        (
                                select t1.temperature as x1, t1.correction as y1
                                from public.calc_temperatures_correction as t1
                                where t1.temperature >= par_temperature
                                order by t1.temperature
                                limit 1
                        ) as rightPart;

                        raise notice 'Граничные значения %', var_interpolation;

                        -- Расчет поправки
                        var_denominator := var_interpolation.x1 - var_interpolation.x0;
                        if var_denominator = 0.0 then

                                raise exception 'Деление на нуль. Возможно, некорректные данные в таблице с поправками!';

                        end if;

						var_result := (par_temperature - var_interpolation.x0) * (var_interpolation.y1 - var_interpolation.y0) / var_denominator + var_interpolation.y0;

                end;
                end if;

				return var_result;

end;
$body$;

-- Функция для генерации случайной даты
drop function if exists fn_get_random_timestamp;
create function fn_get_random_timestamp(
	par_min_value timestamp,
	par_max_value timestamp)
returns timestamp
language 'plpgsql'
as $body$
begin
	 return random() * (par_max_value - par_min_value) + par_min_value;
end;
$body$;

-- Функция для генерации случайного целого числа из диаппазона
drop function if exists fn_get_randon_integer;
create function fn_get_randon_integer(
	par_min_value integer,
	par_max_value integer
	)
returns integer
language 'plpgsql'
as $body$
begin
	return floor((par_max_value + 1 - par_min_value)*random())::integer + par_min_value;
end;
$body$;

-- Функция для гнерации случайного текста
drop function if exists fn_get_random_text;
create function fn_get_random_text(
   par_length int,
   par_list_of_chars text DEFAULT 'АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯабвгдеёжзийклмнопрстуфхцчшщъыьэюяABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz_0123456789'
)
returns text
language 'plpgsql'
as $body$
declare
    var_len_of_list integer default length(par_list_of_chars);
    var_position integer;
    var_result text = '';
	var_random_number integer;
	var_max_value integer;
	var_min_value integer;
begin

	var_min_value := 10;
	var_max_value := 50;

    for var_position in 1 .. par_length loop
        -- добавляем к строке случайный символ
	    var_random_number := fn_get_randon_integer(var_min_value, var_max_value );
        var_result := var_result || substr(par_list_of_chars,  var_random_number ,1);
    end loop;

    return var_result;

end;
$body$;


-- Функция для расчета метео приближенный
drop function if exists fn_calc_header_meteo_avg;
create function fn_calc_header_meteo_avg(
	par_params input_params
)
returns text
language 'plpgsql'
as $body$
declare
	var_result text;
	var_params input_params;
begin

	-- Проверяю аргументы
	var_params := public.fn_check_input_params(par_params);

	select
		-- Дата
		public.fn_calc_header_period(now()) ||
		--Высота расположения метеопоста над уровнем моря.
	    lpad( 340::text, 4, '0' ) ||
		-- Отклонение наземного давления атмосферы
		lpad(
				case when coalesce(var_params.pressure,0) < 0 then
					'5'
				else ''
				end ||
				lpad ( abs(( coalesce(var_params.pressure, 0) )::int)::text,2,'0')
			, 3, '0') as "БББ",
		-- Отклонение приземной виртуальной температуры
		lpad(
				case when coalesce( var_params.temperature, 0) < 0 then
					'5'
				else
					''
				end ||
				( coalesce(var_params.temperature,0)::int)::text
			, 2,'0')
		into 	var_result;
	return 	var_result;

end;
$body$;



raise notice 'Структура сформирована успешно';
end $$;


-- Проверка расчета
do $$
declare
	var_pressure_value numeric(8,2) default 0;
	var_temperature_value numeric(8,2) default 0;

	var_period text;
	var_pressure text;
	var_height text;
	var_temperature text;
begin

	var_pressure_value :=  public.fn_calc_header_pressure(743);
	var_temperature_value := public.fn_calc_header_temperature(23);

	select
		-- Дата
		public.fn_calc_header_period(now()) as "ДДЧЧМ",
		--Высота расположения метеопоста над уровнем моря.
	    lpad( 340::text, 4, '0' ) as "ВВВВ",
		-- Отклонение наземного давления атмосферы
		lpad(
				case when var_pressure_value < 0 then
					'5'
				else ''
				end ||
				lpad ( abs((var_pressure_value)::int)::text,2,'0')
			, 3, '0') as "БББ",
		-- Отклонение приземной виртуальной температуры
		lpad(
				case when var_temperature_value < 0 then
					'5'
				else
					''
				end ||
				(var_temperature_value::int)::text
			, 2,'0') as "TT"
		into
			var_period, var_height, var_pressure, var_temperature;

		raise notice '==============================';
		raise notice 'Пример расчета метео приближенный';
		raise notice ' ДДЧЧМ %, ВВВВ %,  БББ % , TT %', 	var_period, var_height, var_pressure, var_temperature;

end $$;

-- Генерация тестовых данных


do $$
declare
	 var_position integer;
	 var_emploee_ids integer[];
	 var_emploee_quantity integer default 5;
	 var_min_rank integer;
	 var_max_rank integer;
	 var_emploee_id integer;
	 var_current_emploee_id integer;
	 var_index integer;
	 var_measure_type_id integer;
	 var_measure_input_data_id integer;
begin

	-- Определяем макс дипазон по должностям
	select min(id), max(id)
	into var_min_rank,var_max_rank
	from public.military_ranks;


	-- Формируем список пользователей
	for var_position in 1 .. var_emploee_quantity loop
		insert into public.employees(name, birthday, military_rank_id )
		select
			fn_get_random_text(25),								-- name
			fn_get_random_timestamp('1978-01-01','2000-01-01'), 				-- birthday
			fn_get_randon_integer(var_min_rank, var_max_rank)  -- military_rank_id
			;
		select id into var_emploee_id from public.employees order by id desc limit 1;
		var_emploee_ids := var_emploee_ids || var_emploee_id;
	end loop;

	raise notice 'Сформированы тестовые пользователи  %', var_emploee_ids;

	-- Формируем для каждого по 100 измерений
	foreach var_current_emploee_id in ARRAY var_emploee_ids LOOP
		for var_index in 1 .. 100 loop
			var_measure_type_id := fn_get_randon_integer(1,2);

			insert into public.measurment_input_params(measurment_type_id, height, temperature, pressure, wind_direction, wind_speed)
			select
				var_measure_type_id,
				fn_get_randon_integer(0,600)::numeric(8,2), -- height
				fn_get_randon_integer(0, 50)::numeric(8,2), -- temperature
				fn_get_randon_integer(500, 850)::numeric(8,2), -- pressure
				fn_get_randon_integer(0,59)::numeric(8,2), -- ind_direction
				fn_get_randon_integer(0,59)::numeric(8,2)	-- wind_speed
				;

			select id into var_measure_input_data_id from 	measurment_input_params order by id desc limit 1;

			insert into public.measurment_baths( emploee_id, measurment_input_param_id, started)
			select
				var_current_emploee_id,
				var_measure_input_data_id,
				fn_get_random_timestamp('2025-02-01 00:00', '2025-02-05 00:00')
			;
		end loop;

	end loop;

	raise notice 'Набор тестовых данных сформирован успешно';

end $$;




drop table if exists public.calc_air_deviation;
create table public.calc_air_deviation
(
    device_type_id integer not null,
    y numeric(8,2) not null,
    dt integer not null,
    avg_deviation numeric(8,2) not null,
    constraint pk_calc_air_deviation primary key (device_type_id, y, dt)
);

insert into public.calc_air_deviation(device_type_id, y, dt, avg_deviation)
values
  (1, 200,  1, -1),
  (1, 200,  2, -2),
  (1, 200,  3, -3),
  (1, 200,  4, -4),
  (1, 200,  5, -5),
  (1, 200,  6, -6),
  (1, 200,  7, -7),
  (1, 200,  8, -8),
  (1, 200,  9, -8),
  (1, 200, 10, -9),
  (1, 200, 20, -20),
  (1, 200, 30, -29),
  (1, 200, 40, -39),
  (1, 200, 50, -49),

  -- Для высоты 400:
  (1, 400,  1, -1),
  (1, 400,  2, -2),
  (1, 400,  3, -3),
  (1, 400,  4, -4),
  (1, 400,  5, -5),
  (1, 400,  6, -6),
  (1, 400,  7, -6),
  (1, 400,  8, -7),
  (1, 400,  9, -8),
  (1, 400, 10, -9),
  (1, 400, 20, -19),
  (1, 400, 30, -29),
  (1, 400, 40, -38),
  (1, 400, 50, -48),

  (1, 800,  1, -1),
  (1, 800,  2, -2),
  (1, 800,  3, -3),
  (1, 800,  4, -4),
  (1, 800,  5, -5),
  (1, 800,  6, -6),
  (1, 800,  7, -6),
  (1, 800,  8, -7),
  (1, 800,  9, -7),
  (1, 800, 10, -8),
  (1, 800, 20, -18),
  (1, 800, 30, -28),
  (1, 800, 40, -37),
  (1, 800, 50, -46),

  (1, 1200,  1, -1),
  (1, 1200,  2, -2),
  (1, 1200,  3, -3),
  (1, 1200,  4, -4),
  (1, 1200,  5, -5),
  (1, 1200,  6, -5),
  (1, 1200,  7, -5),
  (1, 1200,  8, -6),
  (1, 1200,  9, -7),
  (1, 1200, 10, -8),
  (1, 1200, 20, -17),
  (1, 1200, 30, -26),
  (1, 1200, 40, -35),
  (1, 1200, 50, -44),

  (1, 1600,  1, -1),
  (1, 1600,  2, -2),
  (1, 1600,  3, -3),
  (1, 1600,  4, -3),
  (1, 1600,  5, -4),
  (1, 1600,  6, -4),
  (1, 1600,  7, -5),
  (1, 1600,  8, -6),
  (1, 1600,  9, -7),
  (1, 1600, 10, -7),
  (1, 1600, 20, -17),
  (1, 1600, 30, -25),
  (1, 1600, 40, -34),
  (1, 1600, 50, -42),

  (1, 2000,  1, -1),
  (1, 2000,  2, -2),
  (1, 2000,  3, -3),
  (1, 2000,  4, -3),
  (1, 2000,  5, -4),
  (1, 2000,  6, -4),
  (1, 2000,  7, -5),
  (1, 2000,  8, -6),
  (1, 2000,  9, -6),
  (1, 2000, 10, -7),
  (1, 2000, 20, -16),
  (1, 2000, 30, -24),
  (1, 2000, 40, -32),
  (1, 2000, 50, -40),

  (1, 2400,  1, -1),
  (1, 2400,  2, -2),
  (1, 2400,  3, -2),
  (1, 2400,  4, -3),
  (1, 2400,  5, -4),
  (1, 2400,  6, -4),
  (1, 2400,  7, -5),
  (1, 2400,  8, -5),
  (1, 2400,  9, -6),
  (1, 2400, 10, -7),
  (1, 2400, 20, -15),
  (1, 2400, 30, -23),
  (1, 2400, 40, -31),
  (1, 2400, 50, -38),

  (1, 3000,  1, -1),
  (1, 3000,  2, -2),
  (1, 3000,  3, -2),
  (1, 3000,  4, -3),
  (1, 3000,  5, -4),
  (1, 3000,  6, -4),
  (1, 3000,  7, -4),
  (1, 3000,  8, -5),
  (1, 3000,  9, -5),
  (1, 3000, 10, -6),
  (1, 3000, 20, -15),
  (1, 3000, 30, -22),
  (1, 3000, 40, -30),
  (1, 3000, 50, -37),

  (1, 4000,  1, -1),
  (1, 4000,  2, -2),
  (1, 4000,  3, -2),
  (1, 4000,  4, -3),
  (1, 4000,  5, -4),
  (1, 4000,  6, -4),
  (1, 4000,  7, -4),
  (1, 4000,  8, -4),
  (1, 4000,  9, -5),
  (1, 4000, 10, -6),
  (1, 4000, 20, -14),
  (1, 4000, 30, -20),
  (1, 4000, 40, -27),
  (1, 4000, 50, -34);

insert into public.calc_air_deviation(device_type_id, y, dt, avg_deviation)
values
  (2, 200,  1, -1),
  (2, 200,  2, -2),
  (2, 200,  3, -3),
  (2, 200,  4, -4),
  (2, 200,  5, -5),
  (2, 200,  6, -6),
  (2, 200,  7, -7),
  (2, 200,  8, -8),
  (2, 200,  9, -8),
  (2, 200, 10, -9),
  (2, 200, 20, -20),
  (2, 200, 30, -29),
  (2, 200, 40, -39),
  (2, 200, 50, -49),

  -- Для высоты 400:
  (2, 400,  1, -1),
  (2, 400,  2, -2),
  (2, 400,  3, -3),
  (2, 400,  4, -4),
  (2, 400,  5, -5),
  (2, 400,  6, -6),
  (2, 400,  7, -6),
  (2, 400,  8, -7),
  (2, 400,  9, -8),
  (2, 400, 10, -9),
  (2, 400, 20, -19),
  (2, 400, 30, -29),
  (2, 400, 40, -38),
  (2, 400, 50, -48),

  (2, 800,  1, -1),
  (2, 800,  2, -2),
  (2, 800,  3, -3),
  (2, 800,  4, -4),
  (2, 800,  5, -5),
  (2, 800,  6, -6),
  (2, 800,  7, -6),
  (2, 800,  8, -7),
  (2, 800,  9, -7),
  (2, 800, 10, -8),
  (2, 800, 20, -18),
  (2, 800, 30, -28),
  (2, 800, 40, -37),
  (2, 800, 50, -46),

  (2, 1200,  1, -1),
  (2, 1200,  2, -2),
  (2, 1200,  3, -3),
  (2, 1200,  4, -4),
  (2, 1200,  5, -5),
  (2, 1200,  6, -5),
  (2, 1200,  7, -5),
  (2, 1200,  8, -6),
  (2, 1200,  9, -7),
  (2, 1200, 10, -8),
  (2, 1200, 20, -17),
  (2, 1200, 30, -26),
  (2, 1200, 40, -35),
  (2, 1200, 50, -44),

  (2, 1600,  1, -1),
  (2, 1600,  2, -2),
  (2, 1600,  3, -3),
  (2, 1600,  4, -3),
  (2, 1600,  5, -4),
  (2, 1600,  6, -4),
  (2, 1600,  7, -5),
  (2, 1600,  8, -6),
  (2, 1600,  9, -7),
  (2, 1600, 10, -7),
  (2, 1600, 20, -17),
  (2, 1600, 30, -25),
  (2, 1600, 40, -34),
  (2, 1600, 50, -42),

  (2, 2000,  1, -1),
  (2, 2000,  2, -2),
  (2, 2000,  3, -3),
  (2, 2000,  4, -3),
  (2, 2000,  5, -4),
  (2, 2000,  6, -4),
  (2, 2000,  7, -5),
  (2, 2000,  8, -6),
  (2, 2000,  9, -6),
  (2, 2000, 10, -7),
  (2, 2000, 20, -16),
  (2, 2000, 30, -24),
  (2, 2000, 40, -32),
  (2, 2000, 50, -40),

  (2, 2400,  1, -1),
  (2, 2400,  2, -2),
  (2, 2400,  3, -2),
  (2, 2400,  4, -3),
  (2, 2400,  5, -4),
  (2, 2400,  6, -4),
  (2, 2400,  7, -5),
  (2, 2400,  8, -5),
  (2, 2400,  9, -6),
  (2, 2400, 10, -7),
  (2, 2400, 20, -15),
  (2, 2400, 30, -23),
  (2, 2400, 40, -31),
  (2, 2400, 50, -38),

  (2, 3000,  1, -1),
  (2, 3000,  2, -2),
  (2, 3000,  3, -2),
  (2, 3000,  4, -3),
  (2, 3000,  5, -4),
  (2, 3000,  6, -4),
  (2, 3000,  7, -4),
  (2, 3000,  8, -5),
  (2, 3000,  9, -5),
  (2, 3000, 10, -6),
  (2, 3000, 20, -15),
  (2, 3000, 30, -22),
  (2, 3000, 40, -30),
  (2, 3000, 50, -37),

  (2, 4000,  1, -1),
  (2, 4000,  2, -2),
  (2, 4000,  3, -2),
  (2, 4000,  4, -3),
  (2, 4000,  5, -4),
  (2, 4000,  6, -4),
  (2, 4000,  7, -4),
  (2, 4000,  8, -4),
  (2, 4000,  9, -5),
  (2, 4000, 10, -6),
  (2, 4000, 20, -14),
  (2, 4000, 30, -20),
  (2, 4000, 40, -27),
  (2, 4000, 50, -34);

raise notice 'Таблица calc_air_deviation успешно создана и заполнена';

drop function if exists public.sp_calc_average_air_deviation(int, numeric);
create or replace function public.sp_calc_average_air_deviation(
    p_device_type_id int,
    p_delta_t numeric(8,2)
)
returns numeric[]
language plpgsql
as
$$
declare
    v_result  numeric[];
    v_sign    int;
    v_abs_t   int;
    v_tens    int;
    v_ones    int;
    v_y       numeric(8,2);
    v_dev1    numeric(8,2);
    v_dev2    numeric(8,2);
    v_sum     numeric(8,2);
begin
    if p_delta_t < 0 then
        v_sign := -1;
    else
        v_sign := 1;
    end if;

    v_abs_t := abs(p_delta_t)::int;
    v_tens := (v_abs_t / 10)::int * 10;
    v_ones := (v_abs_t % 10)::int;

    for v_y in (
        select distinct y
        from public.calc_air_deviation
        where device_type_id = p_device_type_id
        order by y
    ) loop
        select avg_deviation
          into v_dev1
          from public.calc_air_deviation
         where device_type_id = p_device_type_id
           and y = v_y
           and dt = v_sign * v_tens;

        select avg_deviation
          into v_dev2
          from public.calc_air_deviation
         where device_type_id = p_device_type_id
           and y = v_y
           and dt = v_sign * v_ones;

        v_sum := coalesce(v_dev1, 0) + coalesce(v_dev2, 0);
        v_result := array_append(v_result, v_sum);
    end loop;

    return v_result;
end;
$$;

raise notice 'Хранимая процедура sp_calc_average_air_deviation создана';


do $$
declare
    v_array numeric[];
    v_indicator numeric;
begin
    v_array := public.sp_calc_average_air_deviation(1, 1);
    v_indicator := v_array[1];
    raise notice 'Результат для ДМК, Δt=1 => %', v_indicator;

    v_array := public.sp_calc_average_air_deviation(2, 20);
    v_indicator := v_array[1];
    raise notice 'Результат для ВР, Δt=-20 => %', v_indicator;
end $$;

create or replace function public.fn_is_input_valid(
    par_temperature numeric,
    par_pressure numeric
) returns boolean
language plpgsql
as
$$
declare
    v_min_temp numeric;
    v_max_temp numeric;
    v_min_press numeric;
    v_max_press numeric;
begin
    select value::numeric into v_min_temp from measurment_settings where key = 'min_temperature';
    select value::numeric into v_max_temp from measurment_settings where key = 'max_temperature';
    select value::numeric into v_min_press from measurment_settings where key = 'min_pressure';
    select value::numeric into v_max_press from measurment_settings where key = 'max_pressure';

    if par_temperature < v_min_temp or par_temperature > v_max_temp
       or par_pressure < v_min_press or par_pressure > v_max_press then
       return false;
    else
       return true;
    end if;
end;
$$;
