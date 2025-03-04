-- Получить список пользователе которые делали измерения на 
-- высоте 100 метров
select * from public.employees as t1
inner join measurment_baths as t2 
on t2.emploee_id = t1.id
inner join measurment_input_params as t3
on t2.measurment_input_param_id = t3.id
where
    t3.height = 100

