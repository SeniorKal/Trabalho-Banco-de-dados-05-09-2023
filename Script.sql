----cliente---------------------------------- 2
create table cliente(
cli_codigo serial not null,
pes_codigo integer not null,
cli_limitecred numeric (18,2)
);
--adicionando chave primaria
alter table cliente add primary key (cli_codigo);

--adicionando chave secundaria
alter table cliente add constraint pes_codigo FOREIGN key (pes_codigo) references pessoa(pes_codigo);

--Loop
DO $$
BEGIN
    FOR i IN 1..10 LOOP
        INSERT INTO cliente (cli_codigo, cli_limitecred,pes_codigo) VALUES (i,10 + i, i);
    END LOOP;
END $$;

--Update
update cliente set cli_limitecred= 100 where cli_codigo between 8 and 9

--Delete
delete from cliente where cli_limitecred = 100

--Mostrar Tabela
select *
from cliente c 

----pessoa---------------------------------- 1
create table pessoa(
pes_codigo serial not null,
pes_nome varchar(80) not null,
pes_fantasia varchar(80),
pes_fisica char(1) not null,
pes_cpfcnpj varchar(20) not null,
pes_rgie varchar(20),
pes_cadastro date,
pes_endereco varchar(120),
pes_numero varchar(10),
pes_complemento varchar(30),
pes_bairro varchar(50), 
pes_cidade varchar(80),
pes_uf char(2),
pes_cep varchar(9),
pes_fone1 varchar(16),
pes_fone2 varchar(16),
pes_celular varchar(16),
pes_site varchar(200),
pes_email varchar(200),
pes_ativo char(1)
);

--Adicionando chave primaria
alter table pessoa add primary key (pes_codigo);

--loop
DO $$
BEGIN
    FOR i IN 1..10 LOOP
	    INSERT INTO pessoa( 
	pes_codigo,
	pes_nome,
    pes_fantasia,
    pes_fisica,
    pes_cpfcnpj,
    pes_rgie,
    pes_cadastro,
    pes_endereco,
    pes_numero,
    pes_complemento,
    pes_bairro,
    pes_cidade,
    pes_uf,
    pes_cep,
    pes_fone1,
    pes_fone2,
    pes_celular,
    pes_site,
    pes_email,
    pes_ativo
	    )
	    VALUES (
	 i,
	'Lorenzo '|| i,
    'marca'|| i,
    'F', -- ou 'J' para Pessoa Jurídica
    '123.456.789-01' || i, -- CPF ou CNPJ
    '1234567' || i, -- RG ou IE
    '2023-08-01', -- Data de Cadastro (formato: AAAA-MM-DD)
    'Rua ' || i,
    '123' || i, -- Número do endereço
    'Apartamento '|| i ,
    'Bairro' || i,
    'Cidade' || i,
    'UF' , -- Estado (ex: 'SP')
    '2345678' || i, -- CEP
    '(12)3456-78' || i , -- Telefone 1
    '(98)7654-32' || i, -- Telefone 2
    '(99)99999-99' || i, -- Celular
    'https://www.site.com' || i, -- Site
    'email@example.com' || i, -- Email
    'S' -- Ativo ('S') ou Inativo ('N')
	    );
    END loop;
    END $$;

--Update
update pessoa set pes_nome ='Joaquim ', pes_email= 'joaquim@hotmail.com' where pes_codigo between 1 and 2

--Delete
delete from pessoa where pes_nome='Joaquim' or pes_email= 'joaquim@hotmail.com';

--mostrar tabela
select *
from pessoa

----fornecedor---------------------------------- 2
create table fornecedor(
for_codigo serial not null,
pes_codigo integer not null,
for_contato varchar(80)
);

--primary key
alter table fornecedor add primary key (for_codigo);

--chave secundaria
alter table fornecedor add constraint pes_codigofk FOREIGN key (pes_codigo) references pessoa(pes_codigo);

--Loop
DO $$
BEGIN
    FOR i IN 1..10 LOOP
        INSERT INTO fornecedor (pes_codigo,for_contato) VALUES (i,'(15) 9943245'|| i);
    END LOOP;
END $$;

--update
update fornecedor set for_contato = '(44) 99432564'  where for_codigo between 1 and 2

--delete
delete from fornecedor where for_contato='(44) 99432564'

select *
from fornecedor

----Venda---------------------------------- 4
create table venda(
vda_codigo serial not null,
usu_codigo integer not null,
cli_codigo integer not null,
vda_data date not null,
vda_valor numeric(18,2),
vda_desconto numeric(18,2),
vda_total numeric(18,2),
vda_obs text
);
--chave primaria
alter table venda add primary key (vda_codigo);

--chave secundaria
alter table venda add constraint usu_codigofk foreign key (usu_codigo) references usuario(usu_codigo);
alter table venda add constraint cli_codigofk foreign key (cli_codigo) references cliente(cli_codigo);

--loop
DO $$
BEGIN
    FOR i IN 1..10 LOOP
        INSERT INTO venda (
vda_codigo,
usu_codigo, 
cli_codigo, 
vda_data, 
vda_valor, 
vda_desconto, 
vda_total, 
vda_obs) 
       VALUES (
i,
i, 
i, 
'2023-10-09', 
50+i, 
30+i,
50+i-30+i, 
'observação'||i);
    END LOOP;
END $$;

update venda set vda_data='2022-05-03', vda_obs='informaçoes' where vda_codigo between 1 and 2

delete venda where vda_codigo between 1 and 2

select *
from venda

---Usuario ---------------------------------- 3
create table usuario(
usu_codigo serial not null,
usu_nome varchar(80),
usu_login varchar (20) not null,
usu_senha varchar(20),
usu_cadastro date,
usu_ativo char(1)
);

--chave primaria
alter table usuario add primary key (usu_codigo);

DO $$
BEGIN
    FOR i IN 1..10 LOOP
        INSERT INTO usuario (usu_codigo, usu_nome, usu_login, usu_senha, usu_cadastro, usu_ativo) 
       VALUES (i, 'flavio' || i, 'usuariologin', 'usuariosenha', '2023-10-10', 'S');
    END LOOP;
END $$;

update usuario set usu_login='login', usu_senha='senha' where usu_codigo between 1 and 2

delete from usuario where usu_login='login' and usu_senha='senha'

select *
from usuario

---compra---------------------------------- 4
create table compra(
cpr_codigo serial not null,
usu_codigo integer not null,
for_codigo integer not null,
cpr_emissao date,
cpr_valor numeric(18,2),
cpr_desconto numeric(18,2),
cpr_total numeric (18,2),
cpr_dtentrada date,
cpr_obs text
);

--chave primaria
alter table compra primary key (cpr_codigo);

--chave secundaria
alter table compra add constraint usu_codigofk foreign key (usu_codigo) references usuario(usu_codigo);
alter table compra add constraint for_codigofk foreign key (for_codigo) references fornecedor(for_codigo);

--loop
DO $$
BEGIN
    FOR i IN 1..10 LOOP
        INSERT INTO compra (cpr_codigo,usu_codigo,for_codigo,cpr_emissao,cpr_emissao,cpr_valor,cpr_valor,cpr_desconto,cpr_total,cpr_dtentrada,cpr_obs) 
       VALUES (i,i,i,'2023-10-10',10+i,5+i,10+i-5+i,'2022-12-05','obeservação'||i);
    END LOOP;
END $$;

update compra set cpr_emissao='2020-05-05', cpr_dtentrada='2019-03-03' where cpr_codigo between 1 and 2

delete from compra where cpr_emissao='2020-05-05' or cpr_dtentrada='2019-03-03';

select *
from compra

---formaspagamento----------------------------------
create table formaspagto(
fpg_codigo serial not null,
fpg_nome varchar(80),
fpg_ativo char(1)
);

--chave primaria
alter table formaspagto primary key (fpg_codigo);

--loop
DO $$
BEGIN
    FOR i IN 1..10 LOOP
        INSERT INTO formapagto (fpg_codigo,fpg_nome,fpg,ativo) 
       VALUES (i,'cartão','s');
    END LOOP;
END $$;

update formapagto set fpg_nome='2020-10-09', fpg_ativo='N' where fpg_codigo between 1 and 2

delete from formapagto where fpg_nome='2020-10-09' or fpg_ativo='N';

select *
from formapagto

---venda_pagto----------------------------------
create table venda_pagto(
vdp_codigo serial not null,
vda_codigo integer not null,
fpg_codigo integer not null,
vdp_valor numeric (18,2)
);

--chave primaria
alter table venda_pagto primary key (vdp_codigo);

--chave secundaria
alter table venda_pagto add constraint vda_codigofk foreign key (vda_codigo) references venda(vda_codigo);
alter table venda_pagto add constraint fpg_codigofk foreign key (fpg_codigo) references formapagto(fpg_codigo);

--loop
DO $$
BEGIN
    FOR i IN 1..10 LOOP
        INSERT INTO formapagto (vdp_codigo,vda_codigo,fpg_codigo,vdp_valor) 
       VALUES (i,i,i,10+i);
    END LOOP;
END $$;

update formapagto set vdp_valor=30 where vdp_codigo between 1 and 2

delete from formapagto where vdp_valor=30;

select *
from formapagto

---produto----------------------------------
create table produto(
pro_codigo serial not null,
pro_nome varchar(80),
pro_estoque numeric(14,4),
pro_unidade varchar(5),
pro_preco numeric(18,2),
pro_custo numeric(18,2),
pro_atacado numeric (18,2),
pro_min numeric (14,4),
pro_max numeric (14,4),
pro_embalagem decimal (9,0),
pro_peso numeric(14,4),
pro_cadastro date,
pro_obs text,
pro_ativo char(1)
);

--chave primaria
alter table produto primary key (pro_codigo);


DO $$ 
BEGIN
    FOR i IN 1..10 LOOP
        INSERT INTO produto (
            pro_codigo
            pro_nome,
            pro_estoque,
            pro_unidade,
            pro_preco,
            pro_custo,
            pro_atacado,
            pro_min,
            pro_max,
            pro_embalagem,
            pro_peso,
            pro_cadastro,
            pro_obs,
            pro_ativo
        ) VALUES (
            i,
            'Produto ' || i,
            i * 100,
            'un',
            i * 10.50,
            i * 5.75,
            i * 9.80,
            i * 2,
            i * 200,
            i * 10,
            i * 0.5,
            current_date,
            'Observação para o produto ' || i,
            'S'
        );
    END LOOP;
END $$;

update produto set pro_nome='mouse',set pro_obs='Informaçoes para o produto' where pro_codigo between 1 and 2

delete from produto where pro_nome='mouse' and pro_obs='Informaçoes para o produto' ;

select *
from produto

---vendas produtos----------------------------------
create table vendas_produto(  
vep_codigo serial not null,
vda_codigo integer not null,
pro_codigo integer not null,
vep_qtede numeric (14,4),
vep_preco numeric (18,2),
vep_desconto numeric (18,2),
vep_total numeric (18,2)
);

--primary key
alter table vendas_produto add primary key (vep_codigo);

--chave secundaria
alter table vendas_produto add constraint vda_codigofk FOREIGN key (vda_codigo) references venda(vda_codigo);
alter table vendas_produto add constraint pro_codigo foreign key (pro_codigo) references produto(pro_codigo);

--Loop
DO $$
BEGIN
    FOR i IN 1..10 LOOP
        INSERT INTO vendas_produtor (vep_codigo,vda_codigo,pro_codigo,vep_qtede,vep_preco,vep_desconto,vep_total) 
        VALUES (i,i,i, i*1.50,i*3.20,i*4.20,i*1.20);
    END LOOP;
END $$;

--update
update vendas_produto set vep_qtede=10.05,vep_preco=5.10  where vep_codigo between 1 and 2

--delete
delete from vendas_produto where vep_qtede=10.05 and vep_preco=5.10;

select *
from vendas_produto

---compra Produto----------------------------------
create table compra_produto (
cpp_codigo serial not null,
cpr_codigo integer not null,
pro_codigo integer not null,
cpr_qtde numeric (14,4) not null,
cpr_preco numeric(18,2) not null,
cpr_desconto numeric (18,2),
cpr_total numeric (18,2)
);

--chave primaria
alter table compra_produto primary key (cpp_codigo);

--chave secundaria
alter table compra_produto add constraint cpr_codigofk foreign key (cpr_codigo) references compra(cpr_codigo);
alter table compra_produto add constraint pro_codigo foreign key (pro_codigo) references produto(pro_codigo);

--loop
DO $$
DECLARE
    v_cpr_codigo INTEGER;
BEGIN
    FOR i IN 1..10 LOOP
        INSERT INTO compra_produto (
            cpp_codigo,
            cpr_codigo,
            pro_codigo,
            cpr_qtde,
            cpr_preco,
            cpr_desconto,
            cpr_total
        ) VALUES (
            i,
            i,
            i,
            i * 2,
            i * 10.50,
            i * 0.5,
            i * 20
        );
    END LOOP;
END $$;

update compra_produto set cpr_qtde= 50,cpr_preco= 30 where cpp_codigo between 1 and 2

delete from compra_produto where cpr_qtde=50 or cpr_preco= 30;

select *
from compra_produto