--sequences
    create sequence rildolessa.seq_municipio
    increment by 1
    start with 1
    ;  
  
  create sequence rildolessa.seq_aluno
    increment by 1
    start with 1
    ;
  
  create sequence rildolessa.seq_disciplina
    increment by 1
    start with 1
    ;    
  
  create sequence rildolessa.seq_tutor
    increment by 1
    start with 1
    ;
    
  create sequence rildolessa.seq_curso
    increment by 1
    start with 1
    ;
    
  create sequence rildolessa.seq_matricula
    increment by 1
    start with 1
    ;    
   
--drop sequence rildolessa.disciplina;
--drop table rildolessa.tb_matricula;

--tables
create table rildolessa.tb_municipio(
       seq_municipio number(8),
       nome_municipio varchar(30),
       primary key(seq_municipio)
);
 insert into rildolessa.tb_municipio
        (seq_municipio, nome_municipio)
      values
        (rildolessa.seq_municipio.nextval, 'Tauá');
        commit;
select * from rildolessa.tb_municipio t;


create table rildolessa.tb_aluno(
       seq_aluno number(8),
       nome_aluno varchar(30),
       ano_matricula number(4),
       seq_municipio number(8),
       primary key(seq_aluno),
       foreign key(seq_municipio) references tb_municipio(seq_municipio)
       );
select * from rildolessa.tb_aluno;

create table rildolessa.tb_disciplina(
       seq_disciplina number(8),
       nome_disciplina varchar(30),
       primary key(seq_disciplina)
);
select * from rildolessa.tb_disciplina;

create table rildolessa.tb_tutor(
       seq_tutor number(8),
       nome_tutor varchar(30),
       seq_municipio number(8),
       primary key(seq_tutor),
       foreign key(seq_seq_municipio) references tb_municipio(seq_municipio)
       );
select * from rildolessa.tb_tutor;

create table rildolessa.tb_curso(
       seq_curso number(8),
       nome_curso varchar(30),
       seq_municipio number(8),
       seq_disciplina number(8),
       seq_tutor number(8),
       limite_curso number(2),
       primary key(seq_curso),
       foreign key(seq_municipio) references tb_municipio(seq_municipio),
       foreign key(seq_disciplina) references tb_disciplina(seq_disciplina),
       foreign key(seq_tutor) references tb_tutor(seq_tutor),
       constraint limite_curso_ck check (limite_curso <= 30)
       );
select * from rildolessa.tb_curso;       
       
create table rildolessa.tb_log_erro(
       parametro  varchar(30),
       processo varchar(30),
       erro_oracle varchar(1000),
       erro_usuario varchar(30)
       );
select * from rildolessa.tb_log_erro;

create table rildolessa.tb_matricula(
       seq_matricula number(8),
       seq_curso number(8),
       seq_aluno number(8),
       --seq_municipio number(8),
       --seq_disciplina number(8),
       --seq_tutor number(8),
       --limite_curso number(2),
       primary key(seq_matricula),
       foreign key(seq_curso) references tb_curso(seq_curso),
       foreign key(seq_aluno) references tb_aluno(seq_aluno)/*,
       foreign key(seq_tutor) references tb_tutor(seq_tutor),
       constraint limite_curso_ck check (limite_curso <= 30*/);
select * from rildolessa.tb_matricula;

--DML
insert into rildolessa.tb_municipio
  (seq_municipio, nome_municipio)
values
  (rildolessa.seq_municipio.nextval, 'tauá');
  
insert into tb_aluno
  (seq_aluno, nome_aluno, ano_matricula, seq_seq_municipio)
values
  (rildolessa.seq_aluno.nextval, 'rildo', '2023', 1);

insert into tb_disciplina
  (seq_disciplina, nome_disciplina)
values
  (rildolessa.seq_disciplina.nextval, 'java');

insert into tb_tutor
  (seq_tutor, nome_tutor, seq_seq_municipio)
values
  (rildolessa.seq_tutor.nextval, 'milton', 1);

insert into tb_curso
  (seq_curso, nome_curso, seq_seq_municipio, seq_disciplina, seq_tutor, limite_curso)
values
  (rildolessa.seq_curso.nextval, 'ads', 1, 1, 1, 31);

--Tabelas da modelagem
select * from rildolessa.tb_municipio t;
select * from rildolessa.tb_aluno;
select * from rildolessa.tb_disciplina; 
select * from rildolessa.tb_tutor;
select * from rildolessa.tb_curso;
select * from rildolessa.tb_log_erro;
select * from rildolessa.tb_matricula;


select *
  from all_objects a
 where a.OWNER = 'RILDOLESSA'
 order by a.CREATED, a.OBJECT_NAME desc;

--Objetos de processamento
 --Municipio
  rildolessa.pkg_manter_municipio.prc_inserir('fortaleza');
  rildolessa.pkg_manter_municipio.prc_alterar('fortaleza','banabuiu');
  rildolessa.pkg_manter_municipio.prc_excluir('fortaleza');
  rildolessa.pkg_manter_municipio.prc_pesquisar('fortaleza');
 --Aluno
  rildolessa.pkg_manter_aluno.prc_inserir('alan', 1, 2023);
  rildolessa.pkg_manter_aluno.prc_alterar('alan', 'junior');
  rildolessa.pkg_manter_aluno.prc_excluir('alan');
  rildolessa.pkg_manter_aluno.prc_pesquisar('alan');
 --Disciplina
  rildolessa.pkg_manter_disciplina.prc_inserir('java');
  rildolessa.pkg_manter_disciplina.prc_alterar('java', 'angular');
  rildolessa.pkg_manter_disciplina.prc_excluir('java');
  rildolessa.pkg_manter_disciplina.prc_pesquisar('angular'); 
 --Tutor
  rildolessa.pkg_manter_tutor.prc_inserir('fabricia');
  rildolessa.pkg_manter_tutor.prc_alterar('fabricia', 'paula');
  rildolessa.pkg_manter_tutor.prc_excluir('paula');
  rildolessa.pkg_manter_tutor.prc_pesquisar('paula'); 
--Curso
  rildolessa.pkg_manter_curso('fabricia');
  rildolessa.pkg_manter_tutor.prc_alterar('fabricia', 'paula');
  rildolessa.pkg_manter_tutor.prc_excluir('paula');
  rildolessa.pkg_manter_tutor.prc_pesquisar('paula'); 
--Matricula
  rildolessa.pkg_manter_matricula.prc_inserir(38,64);      
  

select *
  from all_objects a
 where 1 = 1
   and a.owner = 'RILDOLESSA'
      --and a.object_type = 'SEQUENCE'
      --aND a.object_name like '%ALUNO%'
   and trunc(a.created) = '10/05/2023'
 order by /*a.created,*/ a.object_type desc;


