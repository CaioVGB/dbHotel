

create database dbHotel;

use dbHotel;

create table funcionarios (
	idFunc int primary key auto_increment,
	nomeFunc varchar(100) not null,
    login varchar(20) not null unique,
    email varchar(50) not null,
    senha varchar(255) not null,
    cargo varchar(20)
);

describe funcionarios;
insert into funcionarios(nomeFunc, login, email, senha, cargo) values ("Administrator", "admin", "administrador@senacpsp.edu.br", md5("admin"), "Administrador");
insert into funcionarios(nomeFunc, login, email, senha, cargo) values ("Pamella Pereto", "pamellapereto", "pamellapereto@senacsp.edu.br", md5("123@senac"), "TI");
insert into funcionarios(nomeFunc, login, email, senha, cargo) values ("Breno Silva", "brenosilva", "brenosilva@senacsp.edu.br", md5("123@senac"), "Contabilidade");
insert into funcionarios(nomeFunc, login, email, senha, cargo) values ("Victoria Cardoso", "victoriacardoso", "victoriacardoso@senacsp.edu.br", md5("123@senac"), "RH");
insert into funcionarios(nomeFunc, login, email, senha, cargo) values ("Laura Lopes", "lauralopes", "lauralopes@senacsp.edu.br", md5("123@senac"), "Gerência");
insert into funcionarios(nomeFunc, login, email, senha, cargo) values ("Fellipe Coelho", "fellipe", "fellipecoelho@gmail.com", md5("123@senac"), "Gerência");

select * from funcionarios;
select idFunc as ID_funcionario, nomeFunc as Nome_Funcionario from funcionarios order by nomeFunc asc;
select idFunc as ID_Funcionario, nomeFunc as Nome_Funcionario from funcionarios order by nomeFunc desc;
select idFunc as ID_Funcionario, nomeFunc as Nome_Funcionario, cargo as
Cargo_Funcionario from funcionarios where cargo <> 'null' order by
idFunc desc;
select idFunc as ID_Funcionario, nomeFunc as Nome_Funcionarios, cargo
as Cargo_Funcionario from funcionarios order by idFunc desc;

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
precoCafe decimal (10,2),
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
select * from Quartos where situacao = "nao" order by preco asc;
select * from Quartos where cafeDaManha = "sim" and situacao = "nao";
select * from Quartos where preco < 700.00 and situacao = "nao";

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

create table pedido (
idpedido int primary key auto_increment,
datapedido timestamp default current_timestamp,
statuspedido enum("Pendente", "Finalizado", "Cancelado") not null,
idCliente int not null,
foreign key (idCliente) references clientes(idCliente)
);

insert into pedido (statuspedido, idCliente) value ("Pendente", 1);
insert into pedido (statuspedido, idCliente) value ("Finalizado", 2);

select * from pedido;
select * from pedido inner join clientes on pedido.idCliente = clientes.idCliente;

create table reservas (
idreserva int primary key auto_increment,
idpedido int not null,
idQuarto int not null,
foreign key (idpedido) references pedido(idpedido),
foreign key (idQuarto) references Quartos(idQuarto),
checkin datetime not null,
checkout datetime not null
);

insert into reservas (idpedido, idQuarto, checkin, checkout) values(1, 1, "2023-11-02 14:00:00", "2023-11-05 12:00:00");
insert into reservas (idpedido, idQuarto, checkin, checkout) values(1, 2, "2023-11-02 14:00:00", "2023-11-05 12:00:00");

select * from reservas;
select reservas.idreserva, pedido.idpedido, Quartos.idQuarto, Quartos.nome, Quartos.andar, Quartos.numeroQuarto from (reservas inner join pedido on reservas.idpedido = pedido.idpedido) inner join Quartos on reservas.idQuarto = Quartos.idQuarto;
