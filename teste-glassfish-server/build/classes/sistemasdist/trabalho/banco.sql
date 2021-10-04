use trabalho;

create table pessoa (
  id int(5) not null auto_increment,
  nome varchar(100) not null,
  data_nasc date not null,
  endereco varchar(100),
  primary keY(id)
);

create table produto (
  id int(5) not null auto_increment,
  descricao varchar(100) not null,
  valor real not null,
  primary key(id)
);

create table compra (
  id int(5) not null auto_increment,
  pessoa_id int(5) not null,
  produto_id int(5) not null,
  data_venda date not null,
  primary key(id)
);
