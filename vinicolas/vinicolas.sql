drop database if exists vinhos;
create database vinhos;
use vinhos;

create table regiao(
	codRegiao bigint not null primary key,
    nomeRegiao varchar(100) not null,
    descricaoRegiao text
);

create table vinicola(
	codVinicola bigint not null primary key,
    nomeVinicola varchar(100) not null,
    descricaoVinicola text,
    foneVinicola varchar(15),
    emailVinicola varchar(15),
    codRegiao bigint not null,
    foreign key(codRegiao) references regiao(codRegiao)
);

create table vinho(
	codVinho bigint not null primary key,
    nomeVinho varchar(50) not null,
    tipoVinho varchar(30) not null,
    anoVinho int not null,
    descricaoVinho text,
    codVinicola bigint not null,
    foreign key(codVinicola) references vinicola(codVinicola)
);

insert into regiao values
	(01, "Espírito Santo do Pinhal SP", "Descrição Região Espírito Santo do Pinhal"),
    (02, "Bento Gonçalves RS", "Descrição Região Bento Gonçalves"),
    (03, "Piranguçu MG", "Descrição Região Piranguçu"),
    (04, "São Bento do Sapucaí SP", "Descrição Região São Bento do Sapucaí"),
    (05, "Campo Largo PR", "Descrição Região Campo Largo");

insert into vinicola values
	(01, "Guaspari", "Descrição Vinícola Guaspari", "(11)00000-0000", "gsp@vin.com.br", 01),
    (02, "Cristofoli", "Descrição Vinícola Cristofoli", "(51)00000-0000", "cf@vin.com.br", 02),
    (03, "Ferreira", "Descrição Vinícola Ferreira", "(31)00000-0000", "frr@vin.com.br", 03),
    (04, "Pizzato", "Descrição Vinícola Pizzato", "(51)11111-1111", "pzzt@vin.com.br", 02),
    (05, "Miolo", "Descrição Vinícola Miolo", "(51)22222-2222", "m@vini.com.br", 02),
    (06, "Villa Santa Maria", "Descrição Vinícola Villa Santa Maria", "(11)11111-1111", "vsm@vin.com.br", 04),
    (07, "Campo Largo", "Descrição Vinícola Campo Largo", "(41)00000-0000", "cl@vin.com.br", 05);
    
insert into vinho values
	(01, "Vinho Guaspari", "Sauvignon Blanc", 2012, "Descrição Vinho Guaspari", 01),
    (02, "Vinho Ferreira", "Sauvignon Blanc", 2014, "Descrição Vinho Ferreira", 03),
    (03, "Vinho Pizzato 1", "Merlot", 2011, "Descrição Vinho Pizzato 1", 04),
    (04, "Vinho Pizzato 2", "Cabernet Sauvignon", 2012, "Descrição Vinho Pizzato 2", 04),
    (05, "Vinho Villa Santa Maria", "Tannat", 2017, "Descrição Vinho Villa Santa Maria", 06),
    (06, "Vinho Campo Largo", "Malbec", 2019, "Descrição Vinho Campo Largo", 07);
    
select v.nomeVinho, v.anoVinho, vc.nomeVinicola, r.nomeRegiao from vinicola vc
join vinho v on v.codVinicola = vc.codVinicola
join regiao r on r.codRegiao = vc.codRegiao;

drop user if exists sommelier@"localhost";
create user sommelier@"localhost" with max_queries_per_hour 40;
grant select on vinhos.vinho to sommelier@"localhost";
grant select (codVinicola, nomeVinicola) on vinhos.vinicola to sommelier@"localhost";
