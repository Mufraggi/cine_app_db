-- migrate:up

CREATE TYPE user_role AS ENUM ('USER', 'ADMIN');

CREATE TYPE user_speciality AS ENUM ('TRANSPORTEUR', 'NONE');

-- migrate:down

