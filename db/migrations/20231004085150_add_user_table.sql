-- migrate:up


CREATE TABLE users (
  id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  firstname varchar(255) NOT NULL,
  lastname varchar(255) NOT NULL,
  company varchar(255),
  email varchar(255) NOT NULL UNIQUE,
  password varchar(255) NOT NULL,
  role user_role NOT NULL,
  speciality user_speciality NOT NULL,
  created_at timestamptz DEFAULT NOW(),
  updated_at timestamptz DEFAULT NOW()
);

-- migrate:down

