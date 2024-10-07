create table users (
  id_user bigint primary key generated always as identity,
  name text not null,
  lastname text not null,
  identification text not null unique,
  password text not null
);

create table rol (
  id_rol bigint primary key generated always as identity,
  rol text not null
);

create table user_rol (
  id_user bigint not null,
  id_rol bigint not null,
  primary key (id_user, id_rol),
  foreign key (id_user) references users (id_user),
  foreign key (id_rol) references rol (id_rol)
);

create table propierty_type (
  id_propierty_type bigint primary key generated always as identity,
  type text not null
);

create table propierties (
  id_propierties bigint primary key generated always as identity,
  dir text not null,
  size text not null,
  chip text not null unique,
  c_catastral text not null unique,
  id_type bigint not null,
  id_owner bigint not null,
  foreign key (id_type) references propierty_type (id_propierty_type),
  foreign key (id_owner) references users (id_user)
);

create table payment (
  id_payment bigint primary key generated always as identity,
  id_propertie bigint not null,
  price numeric not null,
  regularity text not null,
  foreign key (id_propertie) references propierties (id_propierties)
);

create table payment_user (
  id_user bigint not null,
  id_payment bigint not null,
  primary key (id_user, id_payment),
  foreign key (id_user) references users (id_user),
  foreign key (id_payment) references payment (id_payment)
);