--- package --- Evaluation history of datbase structure 

-- Copyright (c) 2016-.. #John
    --
-- Author: #John <pocolab.com@gmail.com>
-- URL: http://www.pocolab.com
-- Version: 1.0.0

    --- Commentary:

-- This file keeps evaluation history of database structure 

    --- License:

-- This program is free software; you can redistribute it and/or
-- modify it under the terms of the GNU General Public License
-- as published by the Free Software Foundation; either version 3
-- of the License, or (at your option) any later version.
    --
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
    --
-- You should have received a copy of the GNU General Public License
-- along with GNU Emacs; see the file COPYING.  If not, write to the
-- Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
-- Boston, MA 02110-1301, USA.

    --- Code:

-- Table keeps evolution history of database structure.
create table if not exists migrations(
	id serial primary key,
	comment varchar(200) not null,
	createdate timestamp unique not null
	);

-- Function for updating evaluation history of database structure
create or replace function update_migrations(arg_comment varchar(200), arg_createdate timestamp)
    returns int as $$
    declare flag int;
    begin
    flag := (select 1 from migrations m
    where m.createdate = arg_createdate
	and m.comment = arg_comment 
	limit 1); 

    if flag is null then
    flag:=0;
insert into migrations values(default, arg_comment, arg_createdate);
    end if;

    return 1;
    end;
    $$ language plpgsql
    volatile
    called on null input
    ;

    ----------------------------------------------------------------------------  
   
    do $$declare flag int;
    begin

select into flag update_migrations('Add init structure of database', timestamp '01-01-2016');

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
