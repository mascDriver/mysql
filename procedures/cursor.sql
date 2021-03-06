create procedure `cursor_primeiro_contato`()
begin
    declare vNome varchar (50);
    declare c CURSOR FOR select nome from tabela_de_clientes limit 4;
    open c;
    fetch c into vNome;
    select vNome;
    fetch c into vNome;
    select vNome;
    fetch c into vNome;
    select vNome;
    fetch c into vNome;
    select vNome;
    close c;
end;

call cursor_primeiro_contato();

create procedure `cursor_looping`()
begin
    declare fim_do_cursor int default 0;
    declare vNome varchar (50);
    declare c CURSOR FOR select nome from tabela_de_clientes;
    declare continue handler for not found set fim_do_cursor = 1;
    open c;
    while fim_do_cursor = 0
        do
            fetch c into vNome;
            if fim_do_cursor = 0 then
                select vNome;
            end if;
        end while;
    close c;
end;

call cursor_looping();

create procedure `looping_cursor_multiplas_colunas`()
begin
    declare fim_do_cursor int default 0;
    declare vCidade, vEstado, vCep varchar (50);
    declare vNome, vEndereco varchar (150);
    declare c CURSOR FOR select nome, endereco_1, cidade, estado, cep from tabela_de_clientes;
    declare continue handler for not found set fim_do_cursor = 1;
    open c;
    while fim_do_cursor = 0
        do
            fetch c into vNome, vEndereco, vCidade, vEstado, vCep;
            if fim_do_cursor = 0 then
                select concat(vNome, 'Endereco ', vEndereco, ', ', vCidade, ' - ', vEstado, 'CEP: ', vCep);
            end if;
        end while;
    close c;
end;

call looping_cursor_multiplas_colunas();