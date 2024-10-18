drop schema restaurante;
create schema restaurante;
use restaurante;

create table cliente (
  idcliente int not null,
  nome varchar(100),
  cpf varchar(14),
  endereco varchar(150)
);
alter table cliente add constraint pk_cliente primary key (idcliente);

create table atendente (
  matricula smallint(3) zerofill not null,
  nome varchar(100) not null,
  salario decimal(7,2) not null,
  telefone varchar(25) not null
);
alter table atendente add constraint pk_atendente primary key (matricula);

create table mesa (
  num_mesa tinyint(2) zerofill not null
);
alter table mesa add constraint pk_mesa primary key (num_mesa);
alter table mesa add constraint chk_cod check (num_mesa >= 01 and num_mesa <= 99);

create table item (
  cod_item int not null,
  nome varchar(45) not null,
  preco decimal(3,2) not null
);
alter table item add constraint pk_item primary key (cod_item);

create table pedido (
  cod_pedido int auto_increment primary key not null,
  idcliente int not null,
  matricula smallint(3) zerofill not null,
  num_mesa tinyint(2) zerofill not null,
  inicio timestamp not null,
  fim timestamp not null,
  duracao int generated always as (timestampdiff(second, inicio, fim)) stored
  
);

alter table pedido add constraint fk_pedido_mesa foreign key (num_mesa) references mesa (num_mesa);
alter table pedido add constraint fk_pedido_cliente foreign key (idcliente) references cliente (idcliente);
alter table pedido add constraint fk_pedido_atendente foreign key (matricula) references atendente (matricula);


create table pedido_item (
pedido_cod_pedido int not null,
item_cod_item int not null,
quantidade tinyint
);
alter table pedido_item add constraint pk_pedido_item primary key (pedido_cod_pedido, item_cod_item);
alter table pedido_item add constraint fk_pedido_item_item foreign key (item_cod_item) references item (cod_item);
alter table pedido_item add constraint fk_pedido_item_pedido foreign key (pedido_cod_pedido) references pedido (cod_pedido);
