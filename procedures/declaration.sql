DELIMITER $$
use sucos_vendas $$
create procedure `Nao_Faz_Nada` ()
BEGIN

END $$
DELIMITER ;

create procedure `alo_mundo` ()
BEGIN
    select 'Alo mundo';
END ;

call alo_mundo();

create procedure `mostra numero` ()
BEGIN
    select ( 1 + 9 ) -5 ;
END ;


call `mostra numero`();


create procedure `mostra numero_alias` ()
BEGIN
    select ( 1 + 9 ) -5 as RESULTADO;
END ;


call `mostra numero_alias`();


create procedure `sp_com_funcoes` ()
BEGIN
    select CONCAT('Alo Mundo', '....', (1 + 9) - 5 ) as itens_combinados;
END ;


call `sp_com_funcoes`();


create procedure `sp_com_comentarios` ()
BEGIN
    /* teste de comentario*/
    -- comentario
    select CONCAT('Alo Mundo', '....', (1 + 9) - 5 ) as itens_combinados;
END ;


call `sp_com_comentarios`();


create procedure `sp_com_comentarios1` ()
BEGIN
    /* teste de comentario*/
    -- comentario
    select CONCAT('Alo Mundo', '....', (1 + 9) - 5 ) as itens_combinados;
END ;

drop procedure if exists sp_com_comentarios1;


create procedure `exibe_variavel` ()
BEGIN
    declare texto char(12) default 'Alo Mundo';
    select texto;
END ;

call `exibe_variavel`();

create procedure `tipo_de_dados` ()
BEGIN
    declare v varchar(5) default 'TEXTO';
    declare i integer default 10;
    declare d decimal(4,2) default 56.12;
    declare dt date default '2021-08-17';
    select v;
    select i;
    select d;
    select dt;
END ;

call `tipo_de_dados`();

create procedure `datetime` ()
BEGIN
    declare ts datetime default localtimestamp;
    select ts;
END ;

call `datetime`();

create procedure `mesmo_tipo_dados` ()
BEGIN
    declare data_1, data_2 date default  '2021-08-17';
    select data_1, data_2;
END ;

call `mesmo_tipo_dados`();

create procedure `atribui_valor` ()
BEGIN
    declare texto varchar(30) default 'Texto Inicial';
    select texto;
    set texto = 'texto modificado';
    select texto;
END ;

call `atribui_valor`();


CREATE PROCEDURE `Exerc01`()

BEGIN

DECLARE Cliente VARCHAR(10);
DECLARE Idade INT;
DECLARE DataNascimento DATE;
DECLARE Custo FLOAT;

SET Cliente = 'João';
SET Idade = 10;
SET DataNascimento = '20170110';
SET Custo = 10.23;

SELECT Cliente;
SELECT Idade;
SELECT DataNascimento;
SELECT Custo;

END;

call `Exerc01`;