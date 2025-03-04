-- Type: interpolation_params

-- ОТдельный тип данных для интерполяции

CREATE TYPE public.interpolation_params AS
(
	x0 numeric(4,2),
	x1 numeric(4,2),
	y0 numeric(4,2),
	y1 numeric(4,2),
	x numeric(4,2)
);

ALTER TYPE public.interpolation_params
    OWNER TO admin;
