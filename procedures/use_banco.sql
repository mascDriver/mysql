create procedure `manipula_dados` ()
begin
    INSERT INTO tabela_de_produtos (CODIGO_DO_PRODUTO,NOME_DO_PRODUTO,SABOR,TAMANHO,EMBALAGEM,PRECO_DE_LISTA)
    VALUES ('2001001','Sabor da Serra 700 ml - Manga','Manga','700 ml','Garrafa',7.50),
           ('2001000','Sabor da Serra  700 ml - Melão','Melão','700 ml','Garrafa',7.50),
           ('2001002','Sabor da Serra  700 ml - Graviola','Graviola','700 ml','Garrafa',7.50),
           ('2001003','Sabor da Serra  700 ml - Tangerina','Tangerina','700 ml','Garrafa',7.50),
           ('2001004','Sabor da Serra  700 ml - Abacate','Abacate','700 ml','Garrafa',7.50),
           ('2001005','Sabor da Serra  700 ml - Açai','Açai','700 ml','Garrafa',7.50),
           ('2001006','Sabor da Serra  1 Litro - Manga','Manga','1 Litro','Garrafa',7.50),
           ('2001007','Sabor da Serra  1 Litro - Melão','Melão','1 Litro','Garrafa',7.50),
           ('2001008','Sabor da Serra  1 Litro - Graviola','Graviola','1 Litro','Garrafa',7.50),
           ('2001009','Sabor da Serra  1 Litro - Tangerina','Tangerina','1 Litro','Garrafa',7.50),
           ('2001010','Sabor da Serra  1 Litro - Abacate','Abacate','1 Litro','Garrafa',7.50),
           ('2001011','Sabor da Serra  1 Litro - Açai','Açai','1 Litro','Garrafa',7.50);

    SELECT * FROM tabela_de_produtos WHERE NOME_DO_PRODUTO LIKE 'Sabor da Serra%';

    UPDATE tabela_de_produtos SET PRECO_DE_LISTA = 8 WHERE NOME_DO_PRODUTO LIKE 'Sabor da Serra%';

    SELECT * FROM tabela_de_produtos WHERE NOME_DO_PRODUTO LIKE 'Sabor da Serra%';

    DELETE FROM tabela_de_produtos WHERE NOME_DO_PRODUTO LIKE 'Sabor da Serra%';

    SELECT * FROM tabela_de_produtos WHERE NOME_DO_PRODUTO LIKE 'Sabor da Serra%';
end;

call manipula_dados();

create procedure `insere_novo_produto` ()
begin
    declare vCodigo varchar(50) default '300001';
    declare vNome varchar(50) default 'Sabor do Mar';
    declare vSabor varchar(50) default 'Manga';
    declare vTamanho varchar(50) default '700 ml';
    declare vEmbalagem varchar(50) default 'Garrafa';
    declare vPreco decimal(10,2) default 9.25;
    INSERT INTO tabela_de_produtos (CODIGO_DO_PRODUTO,NOME_DO_PRODUTO,SABOR,TAMANHO,EMBALAGEM,PRECO_DE_LISTA)
    VALUES (vCodigo, vNome, vSabor, vTamanho, vEmbalagem, vPreco);
end;


call insere_novo_produto();

CREATE PROCEDURE `Calcula_Idade`()
BEGIN
    UPDATE tabela_de_clientes set idade =  TIMESTAMPDIFF(YEAR, data_de_nascimento, CURDATE());
END;

create procedure `insere_novo_produto_parametro` (vCodigo varchar(50), vNome varchar(50), vSabor varchar(50), vTamanho varchar(50),
                                                  vEmbalagem varchar(50),vPreco decimal(10,2) )
begin
    INSERT INTO tabela_de_produtos (CODIGO_DO_PRODUTO,NOME_DO_PRODUTO,SABOR,TAMANHO,EMBALAGEM,PRECO_DE_LISTA)
    VALUES (vCodigo, vNome, vSabor, vTamanho, vEmbalagem, vPreco);
end;


call insere_novo_produto_parametro('40001', 'Sabor do Pantanal', 'Melancia', '1 Litro', 'PET', 4.76);

create procedure `insere_novo_produto_tratamento_erro` (vCodigo varchar(50), vNome varchar(50), vSabor varchar(50), vTamanho varchar(50),
                                                  vEmbalagem varchar(50),vPreco decimal(10,2) )
begin
    DECLARE MENSAGEM VARCHAR(40);
    DECLARE EXIT HANDLER FOR 1062
    BEGIN
        SET MENSAGEM = 'problema com chave primaria';
        select MENSAGEM;
    end;
    INSERT INTO tabela_de_produtos (CODIGO_DO_PRODUTO,NOME_DO_PRODUTO,SABOR,TAMANHO,EMBALAGEM,PRECO_DE_LISTA)
    VALUES (vCodigo, vNome, vSabor, vTamanho, vEmbalagem, vPreco);
end;


call insere_novo_produto_tratamento_erro('40001', 'Sabor do Pantanal', 'Melancia', '1 Litro', 'PET', 4.76);

create procedure `acha_sabor_produto`(vProduto varchar(50))
begin
    declare vSabor varchar(50);
    select SABOR into vSabor from tabela_de_produtos where CODIGO_DO_PRODUTO = vProduto;
    select vSabor;
end;

call acha_sabor_produto('1013793')