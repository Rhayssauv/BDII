drop schema un;
CREATE SCHEMA un ;
USE un;

CREATE TABLE professor(
  idprofessor INT NOT NULL,
  nome VARCHAR(45) NULL
  );
alter table professor add constraint pk_professor primary key (idprofessor);

CREATE TABLE disciplina (
  cod_disc INT NOT NULL,
  vaga INT NULL DEFAULT 60,
  id_prof INT NOT NULL
);

alter table disciplina add constraint pk_disciplina primary key (cod_disc);
alter table disciplina add constraint fk_professor_disciplina foreign key (id_prof) references  professor (idprofessor);


CREATE TABLE IF NOT EXISTS materia (
  cod_mat INT NOT NULL,
  nome VARCHAR(45) NULL,
  pre_requisito VARCHAR(45) NULL,
  cargaHoraria INT NULL,
  cod_disc INT NOT NULL
);
alter table materia add constraint pk_materia primary key (cod_mat);
alter table materia add constraint fk_disciplina_materia foreign key (cod_disc) references disciplina (cod_disc);
alter table materia add constraint c_cargahoraria check (cargaHoraria >= 40);

CREATE TABLE curso (
  cod_curso INT NOT NULL,
  nome VARCHAR(45) NULL,
  cargaHoraria INT NULL DEFAULT 3600,
  idprofessor INT NOT NULL
);
alter table curso add constraint pk_curso primary key (cod_curso);
alter table curso add constraint fk_professor_curso foreign key (idprofessor) references professor (idprofessor);


CREATE TABLE IF NOT EXISTS aluno (
  cod_aluno INT NOT NULL,
  nome VARCHAR(45) NULL,
  cod_curso INT NOT NULL
);
alter table aluno add constraint pk_aluno primary key (cod_aluno);
alter table aluno add constraint fk_curso_aluno foreign key (cod_curso) references curso (cod_curso);


CREATE TABLE IF NOT EXISTS email (
  email VARCHAR(100) NULL,
  cod_aluno INT NOT NULL
);
alter table email add constraint pk_email primary key (email, cod_aluno);
alter table email add constraint fk_aluno_email foreign key (cod_aluno) references aluno (cod_aluno);


CREATE TABLE IF NOT EXISTS curso_has_materia (
  cod_curso INT NOT NULL,
  cod_mat INT NOT NULL
);
alter table curso_has_materia add constraint pk_curso_has_materia primary key (cod_curso, cod_mat);
alter table curso_has_materia add constraint fk_curso_curso_has_materia foreign key (cod_curso) references curso (cod_curso);
alter table curso_has_materia add constraint fk_materia_curso_has_materia foreign key (cod_mat) references materia (cod_mat);

CREATE TABLE IF NOT EXISTS matricula (
  cod_disc INT NOT NULL,
  cod_aluno INT NOT NULL
);
alter table matricula add constraint pk_matricula primary key (cod_disc, cod_aluno);
alter table matricula add constraint fk_aluno_matricula foreign key (cod_aluno) references aluno (cod_aluno);
alter table matricula add constraint fk_disciplina_matricula foreign key (cod_disc) references disciplina (cod_disc);

