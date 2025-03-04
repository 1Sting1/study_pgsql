-- Пример для создания связей
alter table public.employees 
add constraint military_rank_id_contraint 
foreign key (military_rank_id)
references public.military_ranks(id);

