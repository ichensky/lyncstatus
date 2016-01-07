#!/bin/sh

type='1 minute'
range=60*24*31*5 # minutes 
length=$range/3

echo "" > tmp_states

echo "
do \$\$
declare contact_id int;
declare status_id int;
declare changedate timestamp;
declare i int;
begin

for contact_id in 
select id from contact
loop
raise notice 'processing contact_id:(%)', contact_id;
i:=0;
while i != $length loop

select id into status_id 
from status 
order by random()
limit 1;

changedate:= now()-'$type'::interval*round(random()*$range);
insert into state values(default, contact_id, status_id, changedate);


i:=i+1;
end loop;

end loop;

end\$\$;



" >> tmp_states
    
mv tmp_states $(dirname $0)/states.sql
