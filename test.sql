CREATE DATABASE test;
use test;
CREATE TABLE customers(
    birth_day date,
    first_name varchar(20) not null,
    last_name varchar(20) not null,
    c_id int primary key auto_increment
);
CREATE TABLE employees(
    birth_day date,
    first_name varchar(20) not null,
    last_name varchar(20) not null,
    e_id int primary key auto_increment
);
CREATE TABLE locations(
    address varchar(20) not null,
    l_id int primary key auto_increment
);
CREATE TABLE transactions(
    e_id int,
    c_id int,
    l_id int,
    date date,
    t_id int primary key,
    constraint FK_employees foreign key(e_id) references employees(e_id),
    constraint FK_customers foreign key(c_id) references customers(c_id),
    constraint FK_locations foreign key(l_id) references locations(l_id)
);
CREATE TABLE items(
    price_for_each int not null,
    name varchar(20) primary key
);
CREATE TABLE itemsbroughtintoshop(
    name varchar(20),
    l_id int,
    amount int,
    date date,
    constraint FK_items foreign key(name) references items(name),
    constraint FK_locations_itemsbroughtintoshop foreign key(l_id) references locations(l_id)
);
CREATE TABLE movementofitems(
    name varchar(20),
    from_l_id int,
    to_l_id int,
    amount int,
    date date,
    constraint FK_items_movementofitems foreign key(name) references items(name),
    constraint FK_locations_movementofitems1 foreign key(from_l_id) references locations(l_id),
    constraint FK_locations_movementofitems2 foreign key(to_l_id) references locations(l_id)
);
CREATE TABLE itmesintransactions(
    name varchar(20),
    t_id int,
    amount int,
    constraint FK_items_itmesintransactions foreign key(name) references items(name),
    constraint FK_transactions_itmesintransactions foreign key(t_id) references transactions(t_id)
);

