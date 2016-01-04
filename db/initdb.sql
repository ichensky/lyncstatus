CREATE TABLE status(
id serial PRIMARY KEY,
name varchar(50)
);

CREATE TABLE contact(
id serial PRIMARY KEY,
uri varchar(1024)
);

-- Contact state in time moment
CREATE TABLE contactstate(
id serial PRIMARY KEY,
contactid int,
statusid int,
statedate timestamp, -- eps=1min
FOREIGN KEY (contactid) REFERENCES contact(id)
FOREIGN KEY (statusid) REFERENCES status(id)
);

-- Contact state at timeline
CREATE TABLE contactstateattimeline(
id serial PRIMARY KEY,
contactid int,
statusid int,
changedstatedate timestamp,
FOREIGN KEY (contactid) REFERENCES contact(id)
FOREIGN KEY (statusid) REFERENCES status(id)
);
