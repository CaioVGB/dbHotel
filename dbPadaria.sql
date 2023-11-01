show databases;

use dbPadaria;

create database dbPadaria;


create table Fornecedores (

idFornecedor int primary key auto_increment,
nomeFornecedor varchar(50) not null,
cnpjFornecedor varchar(20) not null,
telefoneFornecedor varchar(20),
emailFornecedor varchar(50) not null,
cep varchar(9),
enderecoFornecedor varchar(100),
numeroEndereco varchar(10),
bairro varchar(40),
cidade varchar(40),
estado varchar(2)
);

insert into Fornecedores (nomeFornecedor, cnpjFornecedor, telefoneFornecedor, emailFornecedor, cep, enderecoFornecedor, numeroEndereco, bairro, cidade, estado)
values ("Farinhas Pablo", "04.145.273/0001-85", "(11)5012-2022", "farinhasescobar@gmail.com", "03649-051", "Rua Colombia", "33", "Medelin", "Carreira", "CO");


select * from Fornecedores;

create table Produtos (

idProduto int primary key auto_increment,
nomeProduto varchar(50) not null,
descricaoProduto varchar(10),
precoProduto decimal(10,2) not null,
estoqueProduto int not null,
categoriaProduto enum("Pães","Bolos","Confeitaria","Salgados"),
idFornecedor int not null,
foreign key (idFornecedor) references Fornecedores (idFornecedor)
);


insert into Produtos (nomeProduto, descricaoProduto, precoProduto, estoqueProduto, categoriaProduto,idFornecedor) 
values ("Pao Frances", "Pao", 1.00, 100, "Pães", 1);
insert into Produtos (nomeProduto, descricaoProduto, precoProduto, estoqueProduto, categoriaProduto,idFornecedor)
values ("Da Pura", "fina", 10.00, 100, "Confeitaria", 1);

select * from Produtos where categoriaProduto = "Pães";
select * from Produtos where precoProduto < 1.00 order by precoProduto asc;

create table Clientes (
idCliente int primary key auto_increment,
nomeCliente varchar(50),
cpfCliente varchar(15) not null unique,
telefoneCliente varchar(20),
emailCliente varchar(50) unique,
cep varchar(9),
enderecoCLiente varchar(100),
numeroEndereco varchar(10),
bairro varchar(40),
cidade varchar(40),
estado varchar(10)
);
insert into clientes (nomeCliente, cpfCliente, telefoneCliente, emailCliente, cep, enderecoCliente, numeroEndereco, bairro, cidade, estado) values ("Pablo Escobar", "919.810.370-98", "(61) 3728-7811", "pabloescobar@gmail.com", "72260-807", "Quadra QNO 18 Conjunto 7", "779", "Ceilândia Norte", "Brasília", "DF");

select * from clientes;

create table Pedidos (
idPedido int primary key auto_increment,
dataPedido timestamp default current_timestamp,
statusPedido enum ("Pendente", "Finalizado", "Cancelado"),
idCliente int not null,
foreign key (idCliente) references clientes(idCliente)
);

insert into Pedidos (statusPedido, idCliente) values ("Finalizado", 1);

select * from Pedidos inner join Clientes on Pedidos.idCliente = Clientes.idCliente;

create table itensPedidos (
idItensPedidos int primary key auto_increment,
idPedido int not null,
foreign key (idPedido) references Pedidos(idPedido),
idProduto int not null,
foreign key (idProduto) references Produtos(idProduto),
quantidade int not null
);

insert into itensPedidos (idPedido, idProduto, quantidade) values (1, 1, 2);

insert into itensPedidos (idPedido, idProduto, quantidade) values (1, 2, 1);

select Pedidos.idPedido, Produtos.idProduto, Clientes.nomeCliente, Produtos.nomeProduto, quantidade, Produtos.precoProduto 
from Pedidos inner join Clientes on Pedidos.idCliente = Clientes.idCliente inner join 
itensPedidos on Pedidos.idPedido = itensPedidos.idPedido inner join 
Produtos on Produtos.idProduto = itensPedidos.idProduto;





 

