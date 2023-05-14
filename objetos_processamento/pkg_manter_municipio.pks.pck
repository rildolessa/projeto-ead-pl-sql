create or replace package pkg_manter_municipio is

  procedure prc_inserir(p_nome in rildolessa.tb_municipio.nome_municipio%type);
  
  procedure prc_alterar(p_nome_antigo in rildolessa.tb_municipio.nome_municipio%type,
                        p_nome_atual in rildolessa.tb_municipio.nome_municipio%type);
                        
  procedure prc_excluir(p_nome in rildolessa.tb_municipio.nome_municipio%type);     
  
  procedure prc_pesquisar(p_nome in rildolessa.tb_municipio.nome_municipio%type,
                          p_nome_pesquisado out rildolessa.tb_municipio.nome_municipio%type);                  

end pkg_manter_municipio;
/
create or replace package body pkg_manter_municipio is
  
  /*Procedure resposável por inserir dados de municípios*/
  procedure prc_inserir(p_nome in rildolessa.tb_municipio.nome_municipio%type) is
    v_inseriu  number := 0;
    v_erro        varchar2(50);
    begin 
      insert into rildolessa.tb_municipio
        (seq_municipio, nome_municipio)
      values
        (rildolessa.seq_municipio.nextval, p_nome);
        commit;
      exception
        when others then
          v_inseriu := 1;
          v_erro := SQLERRM;
      if v_inseriu = 1 then
         insert into tb_log_erro
           (parametro, processo, erro_oracle, erro_usuario)
         values
           (p_nome, 'inserir', v_erro, 'Erro ao inserir um munícipio');
         commit;
      end if; 
  end prc_inserir; 

  /*Procedure resposável por alterar dados de municípios*/
  procedure prc_alterar(p_nome_antigo in rildolessa.tb_municipio.nome_municipio%type,
                        p_nome_atual in rildolessa.tb_municipio.nome_municipio%type) is
    v_alterou  number := 0;
    v_erro        varchar2(50);
    begin 
      update tb_municipio
         set nome_municipio = p_nome_atual
       where nome_municipio = p_nome_antigo;
        commit;
      exception
        when others then
          v_alterou := 1;
          v_erro := SQLERRM;
      if v_alterou = 1 then
        insert into tb_log_erro
           (parametro, processo, erro_oracle, erro_usuario)
         values
           (p_nome_antigo, 'alterar', v_erro, 'Erro ao alterar um munícipio');
         commit;
      end if; 
  end prc_alterar;   
  
  /*Procedure resposável por excluir dados de municípios*/
  procedure prc_excluir(p_nome in rildolessa.tb_municipio.nome_municipio%type) is
    v_excluiu     number := 0;
    v_erro        varchar2(5000);
    begin 
    delete tb_municipio
     where nome_municipio = p_nome;
        commit;
      exception
        when others then
          v_excluiu := 1;
          v_erro := SQLERRM;
      if v_excluiu = 1 then
        insert into tb_log_erro
           (parametro, processo, erro_oracle, erro_usuario)
         values
           (p_nome, 'excluir', v_erro, 'Erro ao excluir um munícipio');
         commit;
      end if; 
  end prc_excluir; 
  
  /*Procedure resposável por prc_pesquisar dados de municípios*/
  procedure prc_pesquisar(p_nome in rildolessa.tb_municipio.nome_municipio%type,
                          p_nome_pesquisado out rildolessa.tb_municipio.nome_municipio%type) is
    v_pesquisou     number := 0;
    v_erro        varchar2(50);
    begin 
    select nome_municipio into p_nome_pesquisado
      from tb_municipio
     where nome_municipio = p_nome;
      exception
        when no_data_found then 
        v_pesquisou := 1;
        v_erro := SQLERRM;
      if v_pesquisou = 1 then
       insert into tb_log_erro
           (parametro, processo, erro_oracle, erro_usuario)
         values
           (p_nome, 'pesquisar', v_erro, 'Erro ao pesquisar um munícipio');
         commit;
      end if; 
  end prc_pesquisar;
  
      
end pkg_manter_municipio;


  
/
