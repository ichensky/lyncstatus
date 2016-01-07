fix state()
{
	select statusid from state order by changedate limit 1;
	if(row == 0) insert into state ( invalid ) 
	else update statusid = invalid...
}

update state()
{
	if(select from stateid from )....
}
