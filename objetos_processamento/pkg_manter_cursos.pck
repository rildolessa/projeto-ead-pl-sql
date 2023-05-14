create or replace package pkg_manter_curso is

  procedure prc_inserir(p_nome rildolessa.tb_curso.nome_curso%type,
                        p_seq_municipio rildolessa.tb_curso.seq_municipio%type,
                        p_seq_disciplina rildolessa.tb_curso.seq_disciplina%type,
                        p_seq_tutor rildolessa.tb_curso.seq_tutor%type,
                        p_limite_curso rildolessa.tb_curso.limite_curso%type);

  procedure prc_alterar(p_seq_curso in rildolessa.tb_curso.seq_curso%type,
                        p_nome_curso in rildolessa.tb_curso.nome_curso%type);

  procedure prc_excluir(p_seq_curso in rildolessa.tb_curso.seq_curso%type);

  procedure prc_pesquisar(p_seq_curso in rildolessa.tb_curso.seq_curso%type,
                          p_curso_pesquisado out rildolessa.tb_curso.nome_curso%type,
                          p_municipio_pesquisado out rildolessa.tb_curso.seq_municipio%type);

end pkg_manter_curso;
/
create or replace package body pkg_manter_curso is

  /*Procedure resposável por inserir dados de curso*/
  procedure prc_inserir(p_nome rildolessa.tb_curso.nome_curso%type,
                        p_seq_municipio rildolessa.tb_curso.seq_municipio%type,
                        p_seq_disciplina rildolessa.tb_curso.seq_disciplina%type,
                        p_seq_tutor rildolessa.tb_curso.seq_tutor%type,
                        p_limite_curso rildolessa.tb_curso.limite_curso%type) is
    v_inseriu  number := 0;
    v_erro        varchar2(5000);
    begin
      insert into tb_curso
        (seq_curso, nome_curso, seq_municipio, seq_disciplina, seq_tutor, limite_curso)
      values
        (seq_curso.nextval, p_nome, p_seq_municipio, p_seq_disciplina, p_seq_tutor, p_limite_curso);
        commit;
      exception
        when others then
          v_inseriu := 1;
          v_erro := SQLERRM;
      if v_inseriu = 1 then
         insert into tb_log_erro
           (parametro, erro_oracle, processo, erro_usuario)
         values
           (p_nome, v_erro, 'inserir', 'Erro ao inserir um curso');
         commit;
      end if;
  end prc_inserir;

  /*Procedure resposável por alterar dados de curso*/
  procedure prc_alterar(p_seq_curso in rildolessa.tb_curso.seq_curso%type,
                        p_nome_curso in rildolessa.tb_curso.nome_curso%type) is
    v_alterou  number := 0;
    v_erro     varchar2(50);
    begin
     update tb_curso
        set nome_curso = p_nome_curso
      where seq_curso = p_seq_curso;
        commit;
      exception
        when others then
          v_alterou := 1;
          v_erro := SQLERRM;
      if v_alterou = 1 then
        insert into tb_log_erro
           (parametro, processo, erro_oracle, erro_usuario)
         values
           (p_seq_curso, 'alterar', v_erro, 'Erro ao alterar um curso');
         commit;
      end if;
  end prc_alterar;

  /*Procedure resposável por excluir dados de curso*/
  procedure prc_excluir(p_seq_curso in rildolessa.tb_curso.seq_curso%type) is
    v_excluiu     number := 0;
    v_erro        varchar2(50);
    begin
      delete tb_curso
       where seq_curso = p_seq_curso;
        commit;
      exception
        when others then
          v_excluiu := 1;
          v_erro := SQLERRM;
      if v_excluiu = 1 then
        insert into tb_log_erro
           (parametro, processo, erro_oracle, erro_usuario)
         values
           (p_seq_curso, 'excluir', v_erro, 'Erro ao excluir um curso');
         commit;
      end if;
  end prc_excluir;

  /*Procedure resposável por prc_pesquisar dados de curso*/
  procedure prc_pesquisar(p_seq_curso in rildolessa.tb_curso.seq_curso%type,
                          p_curso_pesquisado out rildolessa.tb_curso.nome_curso%type,
                          p_municipio_pesquisado out rildolessa.tb_curso.seq_municipio%type) is
    v_pesquisou     number := 0;
    v_erro        varchar2(50);
    begin 
       select nome_curso, seq_municipio into p_curso_pesquisado, p_municipio_pesquisado
        from tb_curso
        where seq_curso = p_seq_curso;
      exception
        when no_data_found then
        v_pesquisou := 1;
        v_erro := SQLERRM;
      if v_pesquisou = 1 then
       insert into tb_log_erro
           (parametro, processo, erro_oracle, erro_usuario)
         values
           (p_seq_curso, 'pesquisar', v_erro, 'Erro ao pesquisar um tutor');
         commit;
      end if;
  end prc_pesquisar;

end pkg_manter_curso;
/
