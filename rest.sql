create schema restaurante;
use restaurante;

create table cliente (
  id_cliente int not null,
  nome varchar(100) not null,
  cpf varchar(14),
  endereco varchar(150),
  cod_mesa tinyint (2)
);
alter table cliente add constraint pk_cliente primary key (id_cliente);
alter table cliente add constraint fk_mesa_cliente foreign key cod_mesa references mesa (cod_mesa);

create table atendente (
  matricula int(3) zerofill not null,
  nome varchar(100),
  salario double not null,
  telefone varchar(25) not null
);

create table mesa (
  cod_mesa tinyint(2) zerofill not null
);
alter table mesa add constraint pk_mesa primary key (cod_mesa);
alter table mesa add constraint chk_cod check (cod_mesa >= 01 and cod_mesa <= 99);

create table item (
  cod_item int not null,
  nome varchar(45) not null,
  preco decimal(4,2) not null
);
alter table item add constraint pk_item primary key (cod_item);

create table pedido (
  cod_pedido int auto_increment not null,
  inicio datetime,
  fim datetime,
  duracao time_to_second(timediff(time(fim), (inicio)))
);
