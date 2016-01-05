create table if not exists migrations(
	id serial primary key,
	name varchar(200) not null,
	createdate timestamp unique not null
	);

create or replace function update_migrations(arg_name varchar(200), arg_createdate timestamp)
    returns int as $$
    declare flag int;
    begin
    flag := (select 1 from migrations m
    where m.name = arg_name and
	m.createdate = arg_createdate limit 1); 

    if flag is null then
    flag:=0;
insert into migrations values(default, arg_name, arg_createdate);
    end if;

    return 1;
    end;
    $$ language plpgsql
    volatile
    called on null input
    ;

   
    do $$declare flag int;
    begin

select into flag update_migrations('abc', timestamp '01-01-2016');

    if flag = 0 then
create table status(
	id serial primary key,
	name varchar(50) not null
	);

create table contact(
	id serial primary key,
	uri varchar(1024) unique not null
	);

-- contact state in time moment
create table contactstate(
	id serial primary key,
	contactid int not null,
	statusid int not null,
	statedate timestamp, -- eps=1min
	foreign key (contactid) references contact(id),
	foreign key (statusid) references status(id)
	);

-- contact state at timeline
create table contactstateattimeline(
	id serial primary key,
	contactid int not null,
	statusid int not null,
	changedate timestamp not null,
	foreign key (contactid) references contact(id),
	foreign key (statusid) references status(id)
	);
    end if;

    end$$;
