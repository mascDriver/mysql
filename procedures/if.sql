create procedure `cliente_novo_velho` (vCPF varchar(20))
begin
    declare vResultado varchar(20);
    declare vDataNascimento date;
    select data_de_nascimento into vDataNascimento from tabela_de_clientes where CPF = vCPF;
    if vDataNascimento < '20000101' then
        set vResultado = 'Ciente velho';
    else
        set vResultado = 'Ciente novo';
    end if;
    select vResultado;
end;

call cliente_novo_velho('192900992743')


create procedure `acha_status_preco` (vProduto varchar(50))
begin
    declare vPreco FLOAT;
    declare vMensagem varchar(30);
    select preco_de_lista into vPreco from tabela_de_produtos where CODIGO_DO_PRODUTO = vProduto;
    if vPreco >= 12 then
        set vMensagem = 'produto caro';
    elseif vPreco >= 7 and vPreco < 12 then
        set vMensagem = 'produto em conta';
    else
        set vMensagem = 'produto barato';
    end if;
    select vMensagem;
end;

call acha_status_preco('10000889');


create procedure `acha_status_preco_case` (vProduto varchar(50))
begin
    declare vPreco FLOAT;
    declare vMensagem varchar(30);
    select preco_de_lista into vPreco from tabela_de_produtos where CODIGO_DO_PRODUTO = vProduto;
    case
        when vPreco >= 12 then
            set vMensagem = 'produto caro';
        when vPreco >= 7 and vPreco < 12 then
            set vMensagem = 'produto em conta';
        when vPreco < 7 then
            set vMensagem = 'produto barato';
        end case;
    select vMensagem;
end;

call acha_status_preco_case('1000889');

drop procedure acha_status_preco_case;

create table tab_looping(id int );
create procedure `looping_while` (vNumInicial Int, vNumFinal int)
begin
    declare vContador int;
    delete from tab_looping;
    set vContador = vNumInicial;
    while vContador <= vNumFinal
        do
            insert into tab_looping(id) values (vContador);
            set vContador = vContador + 1;
        end while;
    select * from tab_looping;
end;

call looping_while(1, 10);
