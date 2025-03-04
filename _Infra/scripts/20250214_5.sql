
select  
	case 
	when length(10::text) = 1
	then
		'000'
	when 	length(10::text) = 2
	then
		'00'
	end || 10::text;

	