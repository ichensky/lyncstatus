CREATE TABLE status(
       id smallint,
       name varchar(50)
);

CREATE TABLE contact(
       id int PRIMARY KEY,
       uri varchar(1024)
);

CREATE TABLE contactstate(
       id int PRIMARY KEY,
       contactid int,
       statusid smallint,
       FOREIGN KEY (contactid) REFERENCES contact(id)
       FOREIGN KEY (statusid) REFERENCES status(id)
);
