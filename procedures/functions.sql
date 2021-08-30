set global log_bin_trust_function_creators = 1;


create function `f_acha_tipo_sabor` (vSabor varchar(50))
    returns varchar (20)
begin
    declare vRetorno varchar(20) default "";
    case vSabor
        when 'Lima/Limão' then set vRetorno = 'Citrico';
        when 'Laranja' then set vRetorno = 'Citrico';
        when 'Uva' then set vRetorno = 'Neutro';
        else set vRetorno = 'Acidos';
        end case;
    return vRetorno;
end;

select f_acha_tipo_sabor('Laranja') as tipo;


create function  `f_numero_aleatorio` (min int, max int)
    returns integer
begin
    declare vRetorno INT;
    select floor((rand() * (max-min+1)) + min) into vRetorno;
    return vRetorno;
end;

select f_numero_aleatorio(15, 300);


create function `f_cliente_aleatorio`()
    returns varchar(11)
begin
    declare vRetorno varchar(11);
    declare num_max_tabela int;
    declare num_aleatorio int;
    select count(*) into num_max_tabela from tabela_de_clientes;
    set num_aleatorio = f_numero_aleatorio(1, num_max_tabela);
    set num_aleatorio = num_aleatorio - 1;
    select CPF into vRetorno from tabela_de_clientes limit num_aleatorio, 1;
    return vRetorno;
end;

select f_cliente_aleatorio();

CREATE FUNCTION `f_produto_aleatorio`() RETURNS varchar(10) BEGIN
    DECLARE vRetorno VARCHAR(10);
    DECLARE num_max_tabela INT;
    DECLARE num_aleatorio INT;
    SELECT COUNT(*) INTO num_max_tabela FROM tabela_de_produtos;
    SET num_aleatorio = f_numero_aleatorio(1, num_max_tabela);
    SET num_aleatorio = num_aleatorio - 1;
    SELECT CODIGO_DO_PRODUTO INTO vRetorno FROM tabela_de_produtos
    LIMIT num_aleatorio, 1;
    RETURN vRetorno;
END;

CREATE FUNCTION `f_vendedor_aleatorio`() RETURNS varchar(5) BEGIN
    DECLARE vRetorno VARCHAR(5);
    DECLARE num_max_tabela INT;
    DECLARE num_aleatorio INT;
    SELECT COUNT(*) INTO num_max_tabela FROM tabela_de_vendedores;
    SET num_aleatorio = f_numero_aleatorio(1, num_max_tabela);
    SET num_aleatorio = num_aleatorio - 1;
    SELECT MATRICULA INTO vRetorno FROM tabela_de_vendedores
    LIMIT num_aleatorio, 1;
    RETURN vRetorno;
END;

create procedure `p_inserir_venda` (vData date, max_itens int, max_quantidade int)
begin
    declare vCliente varchar(11);
    declare vProduto varchar(10);
    declare vVendedor varchar(5);
    declare vQuantidade int;
    declare vPreco float;
    declare vItens int;
    declare vNumeroNota int;
    declare vContador int default 1;
    declare vNumeroItensNota int;
    select max(numero) + 1 into vNumeroNota from notas_fiscais;
    set vCliente = f_cliente_aleatorio();
    set vVendedor = f_vendedor_aleatorio();
    insert into notas_fiscais(cpf, matricula, data_venda, numero, imposto) values (vCliente, vVendedor, vData, vNumeroNota, 0.10);
    set vItens = f_numero_aleatorio(1, max_itens);
    while vContador <= vItens
        do
            set vProduto = f_produto_aleatorio();
            select count(*) into vNumeroItensNota from itens_notas_fiscais where numero = vNumeroNota and CODIGO_DO_PRODUTO = vProduto;
            if vNumeroItensNota = 0 then
                set vQuantidade = f_numero_aleatorio(10, max_quantidade);
                select PRECO_DE_LISTA into vPreco from tabela_de_produtos where CODIGO_DO_PRODUTO = vProduto;
                insert into itens_notas_fiscais(numero, codigo_do_produto, quantidade, preco) values (vNumeroNota, vProduto, vQuantidade, vPreco);
            end if;
            set vContador = vContador + 1;
        end while;
end;

call p_inserir_venda('2021-08-30', 10, 10)