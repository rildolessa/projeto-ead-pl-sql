create or replace package pkg_manter_matricula is

  procedure prc_inserir(p_seq_aluno in rildolessa.tb_aluno.seq_aluno%type,
                        p_seq_curso in rildolessa.tb_curso.seq_curso%type);
                          
  procedure prc_valida_regiao_aluno(p_seq_aluno in rildolessa.tb_aluno.seq_aluno%type,
                                    p_seq_curso in rildolessa.tb_curso.seq_curso%type,
                                    p_confirma_regiao out varchar2);                        
                     
end pkg_manter_matricula;
/
create or replace package body pkg_manter_matricula is

  /*Procedure resposável por inserir dados de matricula*/
  procedure prc_inserir(p_seq_aluno in rildolessa.tb_aluno.seq_aluno%type,
                        p_seq_curso in rildolessa.tb_curso.seq_curso%type) is
    v_inseriu     number := 0;
    v_erro        varchar2(50);
    valida_regiao varchar2(1);
    --exp_valida_regiao exception;
    begin
      prc_valida_regiao_aluno(p_seq_aluno, p_seq_curso, valida_regiao);
      if valida_regiao = 's' then
        insert into tb_matricula
          (seq_matricula, seq_curso, seq_aluno)
        values
          (seq_matricula.nextval, p_seq_curso, p_seq_aluno);
          commit;
      else 
        --raise exp_valida_regiao;  
         insert into tb_log_erro
           (parametro, processo, erro_oracle, erro_usuario)
         values
           (p_seq_aluno, 'inserir', v_erro, 'Erro ao inserir uma matricula');
         commit;
      end if;   
      exception
        when others then
          v_inseriu := 1;
          v_erro := SQLERRM;
       /* when exp_valida_regiao then
          v_inseriu := 1;
          v_erro := SQLERRM; */ 
      if v_inseriu = 1 then
         insert into tb_log_erro
           (parametro, processo, erro_oracle, erro_usuario)
         values
           (p_seq_aluno, 'inserir', v_erro, 'Erro ao inserir uma matricula');
         commit;
      end if;
  end prc_inserir;
  
  /*Procedure resposável por validar região aluno*/
  procedure prc_valida_regiao_aluno(p_seq_aluno in rildolessa.tb_aluno.seq_aluno%type,
                                    p_seq_curso in rildolessa.tb_curso.seq_curso%type,
                                    p_confirma_regiao out varchar2) is
    v_pesquisou number := 0;
    v_erro      varchar2(50);
    v_curso     varchar2(50);
    begin
    select c.seq_curso into v_curso
      from tb_aluno a, tb_curso c
     where a.seq_municipio = c.seq_municipio
       and c.seq_curso = p_seq_curso
       and a.seq_aluno = p_seq_aluno;
       p_confirma_regiao := 's';
      exception
        when no_data_found then
        v_pesquisou := 1;
        v_erro := SQLERRM;
        p_confirma_regiao := 'n';
      if v_pesquisou = 1 then
       insert into tb_log_erro
           (parametro, processo, erro_oracle, erro_usuario)
         values
           (p_seq_aluno, 'validar região', v_erro, 'Região não validad');
         commit;
      end if;
  end prc_valida_regiao_aluno;

end pkg_manter_matricula;
/
