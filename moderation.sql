create table moderators(id serial primary key, name varchar not null unique, salt varchar not null, password varchar not null);
