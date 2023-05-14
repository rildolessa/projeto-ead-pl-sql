create or replace package pkg_manter_tutor is

  procedure prc_inserir(p_nome_tutor rildolessa.tb_tutor.nome_tutor%type,
                        p_seq_municipio rildolessa.tb_tutor.seq_municipio%type);

  procedure prc_alterar(p_nome_antigo in rildolessa.tb_tutor.nome_tutor%type,
                        p_nome_atual in rildolessa.tb_tutor.nome_tutor%type);

  procedure prc_excluir(p_nome in rildolessa.tb_tutor.nome_tutor%type);

  procedure prc_pesquisar(p_nome in rildolessa.tb_tutor.nome_tutor%type,
                          p_nome_pesquisado out rildolessa.tb_tutor.nome_tutor%type,
                          p_seq_municipio out rildolessa.tb_tutor.seq_municipio%type);

end pkg_manter_tutor;
/
create or replace package body pkg_manter_tutor is

  /*Procedure resposável por inserir dados de municípios*/
  procedure prc_inserir(p_nome_tutor rildolessa.tb_tutor.nome_tutor%type,
                        p_seq_municipio rildolessa.tb_tutor.seq_municipio%type) is
    v_inseriu  number := 0;
    v_erro        varchar2(50);
    begin
      insert into tb_tutor
        (seq_tutor, nome_tutor, seq_municipio)
      values
        (seq_tutor.nextval, p_nome_tutor, p_seq_municipio);
        commit;
      exception
        when others then
          v_inseriu := 1;
          v_erro := SQLERRM;
      if v_inseriu = 1 then
         insert into tb_log_erro
           (parametro, erro_oracle, processo, erro_usuario)
         values
           (p_nome_tutor, v_erro, 'inserir', 'Erro ao inserir um tutor');
         commit;
      end if;
  end prc_inserir;

  /*Procedure resposável por alterar dados de municípios*/
  procedure prc_alterar(p_nome_antigo in rildolessa.tb_tutor.nome_tutor%type,
                        p_nome_atual in rildolessa.tb_tutor.nome_tutor%type) is
    v_alterou  number := 0;
    v_erro     varchar2(50);
    begin
     update tb_tutor
        set nome_tutor = p_nome_atual
      where nome_tutor = p_nome_antigo;
        commit;
      exception
        when others then
          v_alterou := 1;
          v_erro := SQLERRM;
      if v_alterou = 1 then
        insert into tb_log_erro
           (parametro, processo, erro_oracle, erro_usuario)
         values
           (p_nome_antigo, 'alterar', v_erro, 'Erro ao alterar um tutor');
         commit;
      end if;
  end prc_alterar;

  /*Procedure resposável por excluir dados de municípios*/
  procedure prc_excluir(p_nome in rildolessa.tb_tutor.nome_tutor%type) is
    v_excluiu     number := 0;
    v_erro        varchar2(50);
    begin
      delete tb_tutor
       where nome_tutor = p_nome;
        commit;
      exception
        when others then
          v_excluiu := 1;
          v_erro := SQLERRM;
      if v_excluiu = 1 then
        insert into tb_log_erro
           (parametro, processo, erro_oracle, erro_usuario)
         values
           (p_nome, 'excluir', v_erro, 'Erro ao excluir um tutor');
         commit;
      end if;
  end prc_excluir;

  /*Procedure resposável por prc_pesquisar dados de municípios*/
  procedure prc_pesquisar(p_nome in rildolessa.tb_tutor.nome_tutor%type,
                          p_nome_pesquisado out rildolessa.tb_tutor.nome_tutor%type,
                          p_seq_municipio out rildolessa.tb_tutor.seq_municipio%type) is
    v_pesquisou     number := 0;
    v_erro        varchar2(50);
    begin 
       select nome_tutor, seq_municipio
         into p_nome_pesquisado, p_seq_municipio
         from tb_tutor
        where nome_tutor = p_nome;
      exception
        when no_data_found then
        v_pesquisou := 1;
        v_erro := SQLERRM;
      if v_pesquisou = 1 then
       insert into tb_log_erro
           (parametro, processo, erro_oracle, erro_usuario)
         values
           (p_nome, 'pesquisar', v_erro, 'Erro ao pesquisar um tutor');
         commit;
      end if;
  end prc_pesquisar;

end pkg_manter_tutor;
/
