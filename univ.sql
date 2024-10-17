create table materia (
cod_mat int NOT NULL,
nome varchar (100),
prerequisito bool not null,
cargaHoraria int not null
);
alter table materia add constraint pk_materia primary key (cod_mat);
alter table materia add constraint c_cargahoraria check (cargaHoraria >= 40);

create table curso (
cod_curso int not null,
nome varchar(40) not null,
cargaHoraria bigint
);
ALTER TABLE curso ALTER cargaHoraria SET DEFAULT 3600;
alter table curso add constraint pk_curso primary key (cod_curso);

create table disciplina (
cod_disc int not null,
qtd_max tinyint
);

alter table disciplina add constraint pk_disciplina primary key (cod_disc);
alter table disciplina alter qtd_max set default 60;

create table aluno (
cod_aluno int not null,
nome varchar(45)
);