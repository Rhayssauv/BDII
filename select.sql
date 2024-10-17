/* 1. Junções Internas
Escreva uma consulta que retorne o nome e sobrenome de todos os administradores (officer) com o nome
da empresa que eles administram (business.name) e cidade onde ela está presente (customer.city).
*/

select concat(fname, ' ', lname) Nome_Sobrenome, name, city
from officer o 
inner join business b on (o.cust_id = b.cust_id)
inner join customer c on (b.cust_id = c.cust_id)
where c.city is not null;

/* 2. Junções Internas, União e Seleção
Escreva uma consulta que retorne os nome dos clientes (nome das pessoas jurídicas ou nome + sobrenome
das pessoas físicas) que possuem uma conta em uma cidade diferente da cidade de estabelecimento.*/

select CONCAT(fname, ' ', lname)nome 
from individual i
inner join account a on a.cust_id = i.cust_id
inner join customer c on c.cust_id = i.cust_id
inner join branch bc on a.open_branch_id = bc.branch_id
where not bc.city = c.city
union
select b.name 
from business b
inner join customer c on c.cust_id = b.cust_id
inner join account a on a.cust_id = b.cust_id
inner join branch bc on a.open_branch_id = bc.branch_id
where not bc.city = c.city;

/* 3. Junção Externa, Agrupamento, Agregação e Ordenação
Escreva uma consulta que retorne os nome de todos os funcionários com, se for o caso, os números de
transações por ano envolvendo as contas que eles abriram (usando open_emp_id). Ordene os resultados
por ordem alfabética, e depois por ano (do mais antigo para o mais recente).
*/

select  concat(fname, ' ',lname) nome, count(t.account_id) n_transacoes,  year(txn_date) as ano
from  employee e
left join account a on e.emp_id = a.open_emp_id
left join transaction t on t.account_id = a.account_id
group by nome, ano
order by nome, txn_date asc;

/* 4. Junções Internas, Agrupamento, Agregação, União e Concatenação
Escreva uma consulta que retorne os identificadores de contas com maior saldo de dinheiro por agência,
juntamente com os nomes dos titulares (nome da empresa ou nome e sobrenome da pessoa física) e os
nomes dessas agências.
*/

select a.account_id ID, b.name Titular, max(avail_balance) Maior_Saldo, bc.name Agencia
from account a
inner join branch bc on bc.branch_id = a.open_branch_id
inner join business b on b.cust_id = a.cust_id
where a.avail_balance = (select max(avail_balance) from account a where a.open_branch_id = bc.branch_id)
group by Agencia
union
select a.account_id ID, concat(fname, ' ', lname), max(avail_balance) Maior_Saldo, bc.name Agencia
from account a
inner join branch bc on bc.branch_id = a.open_branch_id
inner join individual i on i.cust_id = a.cust_id
where a.avail_balance = (select max(avail_balance) from account a where a.open_branch_id = bc.branch_id)
group by Agencia;




/*5. Visualização
Escreva de novo e modularize as consultas 2. e 4. utilizando uma visualização (CREATE VIEW).
*/
-- 2 --
create view pessoa_fisica_juridica as 
select concat (fname, ' ', lname) Nome, i.cust_id ID, c.city City
from individual i
inner join customer c on c.cust_id = i.cust_id
union 
select b.name Nome, b.cust_id, c.city
from business b
inner join customer c on c.cust_id = b.cust_id;

select distinct p.Nome
from pessoa_fisica_juridica p
inner join account a on p.ID = a.cust_id
inner join branch b on a.open_branch_id = b.branch_id
where not b.city = p.City;


-- 4 --

create view pessoa as
select b.name titular, b.cust_id idtitular
from business b
union
select concat(fname, ' ', lname), i.cust_id
from individual i; 


select a.account_id ID, p.titular Titular, max(avail_balance) Maior_Saldo, bc.name Agencia
from pessoa p
inner join account a on p.idtitular = a.cust_id
inner join branch bc on bc.branch_id = a.open_branch_id
where a.avail_balance = (select max(avail_balance) from account a where a.open_branch_id = bc.branch_id)
group by Agencia;

