/* Mostrar os bancos de dados existentes no servidor */

show databases;

/*Criar um novo banco */
create database dbHotel;

/*Selecionar o banco de dados */
use dbHotel;

/*Criar uma nova tabela */
create table funcionarios (
	/*int se refere ao tipo do campo na tabela
    primary key determina que o campo idFunc seja uma chave primária e será responsável por identificar cada funcionário
    auto_increment determina que o MySQL dê um id novo a cada cadastro */
	idFunc int primary key auto_increment,
    
    /* varchar é a quantidade variável de cada caracter no nome (nesse caso, até 100 caracteres)
    not null determina que o campo seja obrigatório */
	nomeFunc varchar(100) not null,

    /* unique determina qye o campo seja único e o valor não possa repetir */
    login varchar(20) not null unique,
    senha varchar(255) not null,
    cargo varchar(20)
);

/* descreve os campos da tabela funcionarios */
describe funcionarios;



/*Mostrar as tabelas */
show tables;

/* CREATE */
/* Inserir um novo funcionário na tabela, com nome, login, senha criptografada e cargo */ 
insert into funcionarios(nomeFunc, login, senha, cargo) values ("Administrator", "admin", md5("admin"), "Administrador");
insert into funcionarios(nomeFunc, login, senha, cargo) values ("Pamella Pereto", "pamellapereto", md5("123@senac"), "TI");
insert into funcionarios(nomeFunc, login, senha, cargo) values ("Breno Silva", "brenosilva", md5("123@senac"), "Contabilidade");
insert into funcionarios(nomeFunc, login, senha, cargo) values ("Victoria Cardoso", "victoriacardoso", md5("123@senac"), "RH");
insert into funcionarios(nomeFunc, login, senha) values ("Laura Lopes", "lauralopes", md5("123@senac"));
insert into funcionarios(nomeFunc, login, email, senha) values ("Fellipe Coelho", "fellipe", "fellipecoelho@gmail.com", md5("123@senac"));


/*READ*/
/*Ler/Buscar as informações da tabela funcionários */
select * from funcionarios;

/*UPDATE*/
/* Atualizar o campo login na tabela funcionários especificando o id */
update funcionarios set login = 'fellipecoelho' where idFunc = 7;
update funcionarios set cargo = 'Gerência' where idFunc = 4;
update funcionarios set cargo = 'Gerência' where idFunc = 8;
update funcionarios set cargo = 'Gerência' where idFunc = 3;

/* Excluir a tabela do banco */
drop table funcionarios;

/*Buscar o ID e o nome do funcionario da tabela funcionarios ordenando o nome alfabeticamente (ascendente, A a Z) */
select idFunc as ID_funcionario, nomeFunc as Nome_Funcionario from funcionarios order by nomeFunc asc;

/*Buscar o ID eo nome do funcionario da tabela funcionarios ordenando o nome alfabeticamente (descendente, de Z a A) */
select idFunc as ID_Funcionario, nomeFunc as Nome_Funcionario from funcionarios order by nomeFunc desc;

/* Buscar cos campos ID com o apelido ID_Funcionario, nomeFunc com o apelido Nome_Funcionario e cargo com o apelido Cargo_Funcionario
da tabela funcionarios ordenado de forma descendente de nulo e ordenado de forma ascendente o ID (do maior para o menor)
<> ESTE SINAL SIGNIFICA DIFERENTE */
select idFunc as ID_Funcionario, nomeFunc as Nome_Funcionario, cargo as
Cargo_Funcionario from funcionarios where cargo <> 'null' order by
idFunc desc;

select idFunc as ID_Funcionario, nomeFunc as Nome_Funcionarios, cargo
as Cargo_Funcionario from funcionarios order by idFunc desc;

delete from funcionarios where idFunc = 7;

create table Quartos (
idQuarto int primary key auto_increment,
andar varchar(10) not null,
numeroQuarto varchar(10) not null,
tipoQuarto varchar(50) not null,
ocupacaoMax int not null,
situacao char(3) not null,
nome varchar(50) not null,
descricao text,
foto varchar (255) not null,
preco decimal (10,2) not null,   
cafeDaManha char (3) not null,
tipoCama varchar (20),
varanda char(3)

);

describe Quartos;

insert into Quartos (andar, numeroQuarto, tipoQuarto, ocupacaoMax, situacao, nome, descricao, foto, preco, cafeDaManha, precoCafe, tipoCama, varanda)
values ("5°", "500", "Quarto de Casal", "2", "nao", "Luxo",
"Aceita Animal, Wifi Gratis, Restaurante, Bar no Hotel, Ar Condicionado, Estacionamento",
"https://imgcy.trivago.com/c_lfill,d_dummy.jpeg,e_sharpen:60,f_auto,h_225,q_auto,w_225/hotelier-images/50/fa/3bd256afa5028bda05c53571c1e24d4442ef710f00b7bdde487eb497e0ae.jpeg",
297.00, "sim", 60.00, "king", "sim");

insert into Quartos (andar, numeroQuarto, tipoQuarto, ocupacaoMax, situacao, nome, descricao, foto, preco, cafeDaManha, precoCafe, tipoCama, varanda) values
("4°", "405", "Quarto de Casal", "2", "nao", "Luxo", "Nao Aceita Animais, Wifi Gratis, Estacionamento, Restaurante, Ar Condicionado, Piscina",
"https://imgcy.trivago.com/c_lfill,d_dummy.jpeg,e_sharpen:60,f_auto,h_225,q_auto,w_225/hotelier-images/3e/bc/a4133ec083a75cabdc715acb70b1b89852af6e3d1d3abff5668d6c4c0f7c.jpeg",
197.00, "sim", 60.00, "king", "sim");

select * from Quartos;

select * from quartos where situacao = "nao" order by preco asc;

select * from quartos where cafeDaManha = "sim" and situacao = "nao";

select * from quartos where preco < 700.00 and situacao = "nao";


create table clientes (
idCliente int primary key auto_increment,
nomeComplete varchar(100) not null,
cpf char(14) not null unique,
rg char(12) not null unique,
email varchar(50) unique,
celular varchar(20) not null
);

describe clientes;

insert into clientes (nomeComplete, cpf, rg, email,celular) values ("José de Assis", "829.942.570-09", "48.353.888-7", "josedeassis@gmail.com", "(96) 99338-2803");

insert into clientes (nomeComplete, cpf, rg, email, celular) values ("Pedroca Mussolini", "111.222.333-04", "11.222.333-4", "pedromussolini@gmail.com", "(96) 99999-9999");

select * from clientes;

drop table clientes;

/* Buscar TODAS AS INFORMAÇÕES da tabela quartos que está vinculada à tabela clientes pelo campo idQuarto */

select *
from Quartos inner join clientes
on Quartos.idQuarto = clientes.idQuarto;

/* Buscar o nome completo e o celular do cliente que alugou o quarto de número 505, pois a tabela está vinculada à tabela clientes pelo idQuarto */
select clientes.nomeComplete,
clientes.celular
from Quartos inner join clientes
on Quartos.idQuarto = clientes.idQuarto where numeroQuarto = 500;

/*Buscar o nome completo e data/horário do checkout do cliente que alugou o quarto de número 500 */
select clientes.nomeComplete as Nome, date_format(clientes.checkout, '%d/%m/%Y - %H:%i') as Checkout from Quartos inner join clientes on Quartos.idQuarto = clientes.idQuarto where numeroQuarto = 500;

drop table clientes;

/*dataPedido timesatamp default current_timestamp significa que a data do pedido sera do pedido sera o mesmo sistema, ou seja, a data atual
statusPedido significa que a situacao do pedido sera uma das seguintes opcoes: Pendente, Finalizado, Cancelado */
create table pedido (
idpedido int primary key auto_increment,
datapedido timestamp default current_timestamp,
statuspedido enum("Pendente", "Finalizado", "Cancelado") not null,
idCliente int not null,
foreign key (idCliente) references clientes(idCliente)
);


/*Abertura de pedidos */
insert into pedido (statuspedido, idCliente) value ("Pendente", 1);
insert into pedido (statuspedido, idCliente) value ("Finalizado", 2);

select * from pedido;


create table reservas (
idreserva int primary key auto_increment,
idpedido int not null,
idQuarto int not null,
foreign key (idpedido) references pedido(idpedido),
foreign key (idQuarto) references Quartos(idQuarto)
);

describe pedido;

drop table reservas;

select * from pedido inner join clientes on pedido.idCliente = clientes.idClientes;

select * from pedido;

select * from reservas;

insert into reservas (idpedido, idQuarto, checkin, checkout) values(1, 1, "2023-11-02 14:00:00", "2023-11-05 12:00:00");

insert into reservas (idpedido, idQuarto, checkin, checkout) values(1, 2, "2023-11-02 14:00:00", "2023-11-05 12:00:00");

alter table revervas add column checkin datetime not null;

alter table revervas add column checkout datetime not null;

describe reservas;

select * from reservas;

select reservas.idreserva, pedido.idpedido, Quartos.idQuarto, Quartos.nome, Quartos.andar, Quartos.numeroQuarto from (reservas inner join pedido on reservas.idpedido = pedido.idpedido) inner join Quartos on reservas.idQuarto = Quartos.idQuarto;

alter table Quartos add column precoCafe decimal(10,2) after cafeDaManha;

alter table Quartos drop column precoCafe;

update Quartos set precoCafe = 60.00 where idQuarto = 1;