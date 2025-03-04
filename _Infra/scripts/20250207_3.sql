-- Пример получения значений для интерполяции
do $$
declare
  var_param interpolation_params;
  var_temperature numeric(8,2);

begin

var_temperature = 22;

select 
temperature, delta,
(      select temperature from temp1  
		where
			temperature >= var_temperature
		order by id  limit 1
) as 	temperature1,	
	
( select delta from 
	temp1  
	where
		temperature >= var_temperature
	order by id	limit 1
	
 ) as delta1
into 
    var_param.x0, var_param.y0, var_param.x1, var_param.y1
from temp1  as t1 where temperature <= var_temperature order by id
desc limit 1;

raise notice 'param %', var_param;

end$$;

--NOTICE:  param (20.00,25.00,1.50,2.00,)
-- select * from temp1
/*
20.00	1.50	1
25.00	2.00	2
30.00	3.50	3
*/



