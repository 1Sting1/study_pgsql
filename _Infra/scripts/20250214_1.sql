-- FUNCTION: public.fnHeaderGetPressure()

-- DROP FUNCTION IF EXISTS public."fnHeaderGetPressure"();

CREATE OR REPLACE FUNCTION public."fnHeaderGetPressure"(
	)
    RETURNS numeric
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare
	var_result numeric;
begin
	var_result := 1;
	
	select temperature 
	into var_result 
	from public.calc_temperatures_correction
	limit 1;
	
	return public."fnHeaderGetPressure"(1);

	
end;
$BODY$;

ALTER FUNCTION public."fnHeaderGetPressure"()
    OWNER TO admin;
