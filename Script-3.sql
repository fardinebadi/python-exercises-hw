create type new_user_role as enum('admim','user');
create table usersss(
user_id serial primary key not null,
name varchar (60) not null,
address text ,
creation_date date default current_date,
email_adress varchar(60),
phone_number bigint,
role new_user_role not null
);



);
create table track (
track_id serial primary key not null,
name varchar(60) not null,
price money ,
file_size float ,
format varchar (30),
album_id int
);


create table orders(
orders_id serial primary key not null,
quantity money ,
total_price money,
creation_date date default current_date,
rack_id int ,
artist_id int 
);

create table artist(
artist_id serial primary key not null ,
name varchar(70) not null,
last_name varchar(80) not null
);
 
create table publisher (
publisher_id serial primary key not null,
name varchar (80) not null ,
address text,
description text
);
create table order_item(
oirder_item_id serial primary key,
order_id int,
track_id int,
foreign key (order_id) references orders(orders_id),
foreign key (track_id) references track (track_id)
);
create table album(
album_id serial primary key not null,
titel varchar(80) not null,
genre varchar (60) not null,
date_creation date default current_date,
track_id int,
artist_id int,
publisher_id int
);

create table order_album(
order_album_id serial primary key not null,
album_id  int ,
artist_id int,
foreign key (album_id ) references album (album_id)
);
alter table orders  drop column artist_id;
alter  table album  drop column artist_id;
alter table orders  drop column rack_id;
alter table order_album  add constraint fk foreign key (artist_id) references artist (artist_id);
alter table orders  add column user_id int;
alter table orders  add constraint fk1 foreign key (user_id) references usersss(user_id);
alter table album  add constraint fk2 foreign  key ( track_id ) references track(track_id);
alter table album  add constraint fk3 foreign key (publisher_id) references publisher (publisher_id);
alter table track  add column album_id int;
alter  table track  add constraint fk4 foreign key (album_id) references album (album_id);
