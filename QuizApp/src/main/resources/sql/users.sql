create table if not exists mydatabase.users
(
    id              integer auto_increment not null primary key,
    username        varchar(50) unique     not null,
    email           varchar(100) unique    not null,
    password_hashed varchar(255)           not null
);

create table if not exists mydatabase.friends
(
    id              integer auto_increment not null primary key,
    sender_id       integer                not null,
    receiver_id     integer                not null,
    friendship_type enum ('APPROVED', 'PENDING'),
    foreign key (sender_id) references users (id),
    foreign key (receiver_id) references users (id)
);

create table if not exists mydatabase.user_messages
(
    id           integer auto_increment not null primary key,
    sender_id    integer                not null,
    recipient_id integer                not null,
    message      varchar(255)           not null,
    send_time    timestamp default current_timestamp,
    foreign key (sender_id) references users (id),
    foreign key (recipient_id) references users (id)
);
