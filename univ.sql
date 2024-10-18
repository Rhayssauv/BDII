DROP SCHEMA universidade;
CREATE SCHEMA universidade;
USE universidade;

CREATE TABLE professor(
  idprofessor SMALLINT(4) ZEROFILL NOT NULL,
  nome VARCHAR(45) NOT NULL,
  email VARCHAR(100)
  );
alter table professor add constraint pk_professor primary key (idprofessor);
alter table professor add unique (email);

CREATE TABLE materia (
  cod_mat INT NOT NULL,
  nome VARCHAR(100) NOT NULL,
  cargaHoraria INT NOT NULL,
  cod_mat_req INT
);
alter table materia add constraint pk_materia primary key (cod_mat);
alter table materia add constraint fk_requisito_materia foreign key (cod_mat_req) references materia (cod_mat);
alter table materia add constraint c_cargahoraria check (cargaHoraria >= 40);

CREATE TABLE disciplina (
  cod_disc INT NOT NULL,
  cod_mat INT NOT NULL,
  idprofessor SMALLINT(4) ZEROFILL NOT NULL,
  vaga TINYINT NOT NULL,
  semestre INT
);

alter table disciplina add constraint pk_disciplina primary key (cod_disc);
alter table disciplina add constraint fk_professor_disciplina foreign key (idprofessor) references  professor (idprofessor);
alter table disciplina add constraint fk_materia_disciplina foreign key (cod_mat) references  materia (cod_mat);
alter table disciplina add constraint chk_num_max_vaga CHECK (vaga <= 60);


CREATE TABLE curso (
  cod_curso INT NOT NULL,
  nome VARCHAR(100) NOT NULL,
  cargaHoraria INT DEFAULT 3600,
  idprofessor_coordenador SMALLINT(4) ZEROFILL NOT NULL
);
alter table curso add constraint pk_curso primary key (cod_curso);
alter table curso add constraint fk_professor_curso foreign key (idprofessor_coordenador) references professor (idprofessor);


CREATE TABLE aluno (
  cod_aluno INT NOT NULL,
  nome VARCHAR(100) NOT NULL
);
alter table aluno add constraint pk_aluno primary key (cod_aluno);


CREATE TABLE email (
  email VARCHAR(100) NOT NULL,
  cod_aluno INT NOT NULL
);
alter table email add constraint pk_email primary key (email, cod_aluno);
alter table email add constraint fk_aluno_email foreign key (cod_aluno) references aluno (cod_aluno);


CREATE TABLE curso_materia (
  cod_curso INT NOT NULL,
  cod_mat INT NOT NULL
);
alter table curso_materia add constraint pk_curso_materia primary key (cod_curso, cod_mat);
alter table curso_materia add constraint fk_curso_curso_materia foreign key (cod_curso) references curso (cod_curso);
alter table curso_materia add constraint fk_materia_curso_materia foreign key (cod_mat) references materia (cod_mat);

CREATE TABLE matricula (
  cod_curso INT NOT NULL,
  cod_aluno INT NOT NULL
);
alter table matricula add constraint pk_matricula primary key (cod_curso, cod_aluno);
alter table matricula add constraint fk_aluno_matricula foreign key (cod_aluno) references aluno (cod_aluno);
alter table matricula add constraint fk_curso_matricula foreign key (cod_curso) references curso (cod_curso);

CREATE TABLE disciplina_matricula (
  cod_disc INT NOT NULL,
  idprofessor SMALLINT(4) ZEROFILL NOT NULL,
  cod_aluno INT NOT NULL
);
alter table disciplina_matricula add constraint pk_disciplina_matricula primary key (cod_disc, idprofessor, cod_aluno);
alter table disciplina_matricula add constraint fk_aluno_disciplina_matricula foreign key (cod_aluno) references aluno (cod_aluno);
alter table disciplina_matricula add constraint fk_disciplina_disciplina_matricula foreign key (cod_disc) references disciplina (cod_disc);
alter table disciplina_matricula add constraint fk_disciplina_professor_matricula foreign key (idprofessor) references professor (idprofessor);
