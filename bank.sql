/*Escreva uma consulta que retorne o nome e sobrenome de todos os administradores (officer) com o nome
da empresa que eles administram (business.name) e cidade onde ela está presente (customer.city).
*/
select concat(fname, ' ', lname) nomesobrenome, name, city
from officer o, business b, customer c
where o.cust_id = b.cust_id and c.city is not null and c.cust_id = b.cust_id;

select concat(fname, ' ', lname) Nome_Sobrenome, name, city
from officer o 
inner join business b on (o.cust_id = b.cust_id)
inner join customer c on (b.cust_id = c.cust_id)
where c.city is not null;

/*Escreva uma consulta que retorne os nome dos clientes (nome das pessoas jurídicas ou nome + sobrenome
das pessoas físicas) que possuem uma conta em uma cidade diferente da cidade de estabelecimento.*/

/*Escreva uma consulta que retorne os nome de todos os funcionários(employee) com, se for o caso, os números de
transações por ano envolvendo as contas que eles abriram (usando open_emp_id, account). Ordene os resultados
por ordem alfabética, e depois por ano (do mais antigo para o mais recente).*/

select name, count(account_id)
from employee e, transaction t
left outer join account a on (e.emp_id = a.open_emp_id);
