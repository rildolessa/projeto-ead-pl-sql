create or replace package pkg_manter_disciplina is

  procedure prc_inserir(p_nome_disciplina in rildolessa.tb_disciplina.nome_disciplina%type);

  procedure prc_alterar(p_nome_disciplina_antigo in rildolessa.tb_disciplina.nome_disciplina%type,
                        p_nome_disciplina_atual in rildolessa.tb_disciplina.nome_disciplina%type);

  procedure prc_excluir(p_nome_disciplina in rildolessa.tb_disciplina.nome_disciplina%type);

  procedure prc_pesquisar(p_nome_disciplina            in rildolessa.tb_disciplina.nome_disciplina%type,
                          p_nome_disciplina_pesquisado out rildolessa.tb_disciplina.nome_disciplina%type);

end pkg_manter_disciplina;
/
create or replace package body pkg_manter_disciplina is

  /*Procedure resposável por inserir dados de disciplina*/
  procedure prc_inserir(p_nome_disciplina in rildolessa.tb_disciplina.nome_disciplina%type) is
    v_inseriu  number := 0;
    v_erro        varchar2(50);
    begin
       insert into tb_disciplina
         (seq_disciplina, nome_disciplina)
       values
         (seq_disciplina.nextval, p_nome_disciplina);

        commit;
      exception
        when others then
          v_inseriu := 1;
          v_erro := SQLERRM;
      if v_inseriu = 1 then
         insert into tb_log_erro
           (parametro, processo, erro_oracle, erro_usuario)
         values
           (p_nome_disciplina, 'inserir', v_erro, 'Erro ao inserir uma disciplina');
         commit;
      end if;
  end prc_inserir;

  /*Procedure resposável por alterar dados de disciplina*/
  procedure prc_alterar(p_nome_disciplina_antigo in rildolessa.tb_disciplina.nome_disciplina%type,
                        p_nome_disciplina_atual in rildolessa.tb_disciplina.nome_disciplina%type) is
    v_alterou  number := 0;
    v_erro     varchar2(50);
    begin
     update tb_disciplina
        set nome_disciplina = p_nome_disciplina_atual
      where nome_disciplina = p_nome_disciplina_antigo;
        commit;
      exception
        when others then
          v_alterou := 1;
          v_erro := SQLERRM;
      if v_alterou = 1 then
        insert into tb_log_erro
           (parametro, processo, erro_oracle, erro_usuario)
         values
           (p_nome_disciplina_antigo, 'alterar', v_erro, 'Erro ao alterar uma disciplina');
         commit;
      end if;
  end prc_alterar;

  /*Procedure resposável por excluir dados de municípios*/
  procedure prc_excluir(p_nome_disciplina in rildolessa.tb_disciplina.nome_disciplina%type) is
    v_excluiu     number := 0;
    v_erro        varchar2(50);
    begin
     delete tb_disciplina
      where nome_disciplina = p_nome_disciplina;
        commit;
      exception
        when others then
          v_excluiu := 1;
          v_erro := SQLERRM;
      if v_excluiu = 1 then
        insert into tb_log_erro
           (parametro, processo, erro_oracle, erro_usuario)
         values
           (p_nome_disciplina, 'excluir', v_erro, 'Erro ao excluir uma disciplina');
         commit;
      end if;
  end prc_excluir;

  /*Procedure resposável por prc_pesquisar dados de municípios*/
  procedure prc_pesquisar(p_nome_disciplina            in rildolessa.tb_disciplina.nome_disciplina%type,
                          p_nome_disciplina_pesquisado out rildolessa.tb_disciplina.nome_disciplina%type) is
    v_pesquisou number := 0;
    v_erro      varchar2(50);
    begin 
       select nome_disciplina
         into p_nome_disciplina_pesquisado
         from tb_disciplina
        where nome_disciplina = p_nome_disciplina;
      exception
        when no_data_found then
        v_pesquisou := 1;
        v_erro := SQLERRM;
      if v_pesquisou = 1 then
       insert into tb_log_erro
           (parametro, processo, erro_oracle, erro_usuario)
         values
           (p_nome_disciplina, 'pesquisar', v_erro, 'Erro ao pesquisar uma disciplin');
         commit;
      end if;
  end prc_pesquisar;

end pkg_manter_disciplina;
/
