create or replace package pkg_manter_aluno is

  procedure prc_inserir(p_nome in rildolessa.tb_aluno.nome_aluno%type,
                        p_municipio in rildolessa.tb_aluno.seq_municipio%type,
                        p_ano_matricula in rildolessa.tb_aluno.ano_matricula%type);

  procedure prc_alterar(p_nome_antigo in rildolessa.tb_aluno.nome_aluno%type,
                        p_nome_atual in rildolessa.tb_aluno.nome_aluno%type);

  procedure prc_excluir(p_nome in rildolessa.tb_aluno.nome_aluno%type);

  procedure prc_pesquisar(p_nome in rildolessa.tb_aluno.nome_aluno%type,
                          p_nome_pesquisado out rildolessa.tb_aluno.nome_aluno%type);

end pkg_manter_aluno;
/
create or replace package body pkg_manter_aluno is

  /*Procedure respos�vel por inserir dados de munic�pios*/
  procedure prc_inserir(p_nome in rildolessa.tb_aluno.nome_aluno%type,
                        p_municipio in rildolessa.tb_aluno.seq_municipio%type,
                        p_ano_matricula in rildolessa.tb_aluno.ano_matricula%type) is
    v_inseriu  number := 0;
    v_erro        varchar2(50);
    begin
      insert into tb_aluno
        (seq_aluno, nome_aluno, ano_matricula, seq_municipio)
      values
        (seq_aluno.nextval, p_nome, p_ano_matricula, p_municipio);
        commit;
      exception
        when others then
          v_inseriu := 1;
          v_erro := SQLERRM;
      if v_inseriu = 1 then
         insert into tb_log_erro
           (parametro, processo, erro_usuario)
         values
           (p_nome, 'inserir', 'Erro ao inserir um aluno');
         commit;
      end if;
  end prc_inserir;

  /*Procedure respos�vel por alterar dados de munic�pios*/
  procedure prc_alterar(p_nome_antigo in rildolessa.tb_aluno.nome_aluno%type,
                        p_nome_atual in rildolessa.tb_aluno.nome_aluno%type) is
    v_alterou  number := 0;
    v_erro     varchar2(50);
    begin
     update tb_aluno
        set nome_aluno = p_nome_atual
      where nome_aluno = p_nome_antigo;
        commit;
      exception
        when others then
          v_alterou := 1;
          v_erro := SQLERRM;
      if v_alterou = 1 then
        insert into tb_log_erro
           (parametro, processo, erro_oracle, erro_usuario)
         values
           (p_nome_antigo, 'alterar', v_erro, 'Erro ao alterar um aluno');
         commit;
      end if;
  end prc_alterar;

  /*Procedure respos�vel por excluir dados de munic�pios*/
  procedure prc_excluir(p_nome in rildolessa.tb_aluno.nome_aluno%type) is
    v_excluiu     number := 0;
    v_erro        varchar2(50);
    begin
     delete tb_aluno
      where nome_aluno = p_nome;
        commit;
      exception
        when others then
          v_excluiu := 1;
          v_erro := SQLERRM;
      if v_excluiu = 1 then
        insert into tb_log_erro
           (parametro, processo, erro_oracle, erro_usuario)
         values
           (p_nome, 'excluir', v_erro, 'Erro ao excluir um aluno');
         commit;
      end if;
  end prc_excluir;

  /*Procedure respos�vel por prc_pesquisar dados de munic�pios*/
  procedure prc_pesquisar(p_nome in rildolessa.tb_aluno.nome_aluno%type,
                          p_nome_pesquisado out rildolessa.tb_aluno.nome_aluno%type) is
    v_pesquisou     number := 0;
    v_erro        varchar2(50);
    begin 
       select nome_aluno into p_nome_pesquisado
      from tb_aluno
     where nome_aluno = p_nome;
      exception
        when no_data_found then
        v_pesquisou := 1;
        v_erro := SQLERRM;
      if v_pesquisou = 1 then
       insert into tb_log_erro
           (parametro, processo, erro_oracle, erro_usuario)
         values
           (p_nome, 'pesquisar', v_erro, 'Erro ao pesquisar um aluno');
         commit;
      end if;
  end prc_pesquisar;

end pkg_manter_aluno;
/