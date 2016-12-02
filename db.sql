create table boards(
  id serial primary key,
  name varchar not null unique);
create table threads(
  id serial primary key,
  board_id integer not null references boards(id) on delete cascade,
  title varchar not null check (title <> ''),
  contents text not null,
  posted timestamp not null default now(),
  unique (board_id, title, contents));
create table posts(
  id serial primary key,
  thread_id integer not null references threads(id) on delete cascade,
  contents text not null,
  posted timestamp not null default now(),
  unique (thread_id, contents));
