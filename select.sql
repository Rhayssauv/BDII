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
select * from account;
select * from branch;

select bc.name Agencia, max(avail_balance) Maior_saldo, b.name Titular
from branch bc
inner join account a on bc.branch_id = a.open_branch_id
inner join business b on a.cust_id = b.cust_id
group by a.open_branch_id
union
select bc.name agencia, max(avail_balance) Maior_Saldo, concat(fname, ' ', lname) Titular
from branch bc
inner join account a on bc.branch_id = a.open_branch_id
inner join individual i on a.cust_id = i.cust_id
group by a.open_branch_id
having Maior_Saldo > Maior_saldo;













select bc.name agencia, max(avail_balance) Maior_Saldo, b.name Titular
from branch bc
inner join account a on bc.branch_id = a.open_branch_id
inner join business b on a.cust_id = b.cust_id
group by a.open_branch_id;



















select distinct bc.name Agencia, concat(fname, ' ', lname) nome, a.account_id ID, MAX(avail_balance) Maior_Saldo
from branch bc
inner join account a on a.open_branch_id = bc.branch_id
inner join individual i on i.cust_id = a.cust_id
group by a.open_branch_id
having Maior_Saldo = max(avail_balance)
union
select distinct bc.name, b.name, a.account_id, max(avail_balance) Maior_Saldo
from branch bc
inner join account a on a.open_branch_id = bc.branch_id
inner join business b on b.cust_id = a.cust_id
group by a.open_branch_id;
