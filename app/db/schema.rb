CREATE TABLE users
( id        bigint
, name      string
);

CREATE TABLE messages
( id        serial
, message   string
, author    id
);
