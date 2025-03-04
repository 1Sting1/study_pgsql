-- FUNCTION: public.fnHeaderGetPressure(numeric)

-- DROP FUNCTION IF EXISTS public."fnHeaderGetPressure"(numeric);

CREATE OR REPLACE FUNCTION public."fnHeaderGetPressure"(
	pressure numeric)
    RETURNS numeric
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
declare
	var_result numeric;
begin

	var_result := 1 + pressure;
	return var_result;

	
end;
$BODY$;

ALTER FUNCTION public."fnHeaderGetPressure"(numeric)
    OWNER TO admin;
