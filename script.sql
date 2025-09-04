create database teste1;

create table teste (
	id serial primary key,
	data date,
	numero int,
	n2 numeric (5,2),
	dhora timestamp,
	letras char(10),
	letras2 varchar(100),
	texto text
);

alter table teste alter column numero set data type float;

insert into teste (data, numero, n2, dhora, letras, letras2, texto)
values ('2025-08-23', 1.300, 999.99, '2025-08-23 10:30:00', 'Botafogooo', 'Botafogo GIGANTE', 'BOTAFOGO>times do Brasil');

alter table teste alter column numero set not null;
alter table teste alter column letras set not null;

create table pessoa(
	id serial primary key, 
	nome varchar(20),
	idade int
);

insert into pessoa(nome, idade)
select
	'Pessoa_' || i as nome,
	(random() * 100)::int as idade
from generate_series(1,100) as s(i);

--

create table estudante(
	id serial primary key,
	nome varchar(20),
	matricula char(5),
	turma char(5),
	data_nascimento date,
	endereco_id int,
	foreign key (endereco_id) references endereco(endereco_id)
);

create table endereco(
	endereco_id serial primary key,
	logradouro varchar(20),
	cep char(8)
);

alter table estudante
add constraint matricula unique (matricula);

alter table estudante
alter column nome set not null;

alter table estudante
alter column data_nascimento set not null;

alter table endereco
drop column bairro;

--

alter table estudante
add column idade int check (idade >=16);

alter table estudante
add column cadastro timestamp default now();

alter table estudante
alter column turma set default 'INFOB';

create index idx_nome on estudante(nome);

create view view_estudante_endereco as
select estudante.matricula, estudante.nome, endereco.logradouro
from estudante left join endereco on
endereco.endereco_id = estudante.id;

select * from view_estudante_endereco;

--

create user admin with password '123';
create user estagiario with password '321';

grant all privileges on all tables in schema public to admin;
grant select on endereco, estudante to estagiario;

insert into endereco(logradouro, cep)
values ('Rua Carvalho Júniro', '25720031');

insert into estudante (nome, matricula, data_nascimento, endereco_id)
values ('Lucas', '12345', '2008-05-13', 1)

select * from endereco;
select * from estudante;
rollback;

insert into estudante(nome, matricula, data_nascimento, endereco_id)
values('Felipe', '54321', '2010-05-13', 1);
rollback;

insert into estudante(nome, matricula, data_nascimento, endereco_id)
values('Saur', '09876', '2010-05-13', 1);
rollback;
select * from estudante;

begin;
insert into estudante(nome, matricula, data_nascimento, endereco_id)
values('Jacinto', '99999', '2012-06-09', 1);
	savepoint ponto1;
commit;

select * from endereco;
select * from estudante;

revoke select on estudante from estagiario;

--

insert into estudante (nome, matricula, data_nascimento, endereco_id)
values 	('Cauã', '12245', '2008-12-22', 1),
		('Cauã', '53621', '2008-05-12', 1),
		('Cauã', '12346', '2008-05-12', 1);
		
select estudante.nome from estudante
union
select endereco.logradouro from endereco 
order by nome;

select estudante.nome, endereco.logradouro into ajudante from estudante inner join endereco on estudante.endereco_id = endereco.endereco_id;
