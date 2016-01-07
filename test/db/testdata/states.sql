

do $$
declare contact_id int;
declare status_id int;
declare changedate timestamp;
declare i int;
begin

for contact_id in 
select id from contact
loop
raise notice 'befor:(%)', contact_id;
i:=0;
while i != 60*24/3 loop

select id into status_id 
from status 
order by random()
limit 1;

changedate:= now()-'1 minute'::interval*round(random()*60*24);
insert into state values(default, contact_id, status_id, changedate);


i:=i+1;
end loop;

end loop;

end$$;




