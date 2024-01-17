create database manchester_united_fc;

create table players(
playerid int primary key,
firstname varchar(20) not null,
lastname varchar(20) not null,
nationality varchar(20),
age int not null,
position varchar(20)
);
alter table players add column jersey_no int;
select * from players;
insert into players value(101,'david','degea','spain',32,'goalkeeper',1),
(102,'diago','dalot','portugal',21,'rightback',2),
(103,'rafael','varane','france',30,'centreback',19),
(104,'lisandro','martinez','argentina',25,'centreback',6),
(105,'luke','shaw','england',27,'leftback',23),
(106,'casemiro','desilva','brazil',31,'midfielder',18),
(107,'christian','eriksen','denmark',31,'midfielder',14),
(108,'bruno','fernandes','portugal',28,'midfielder',8),
(109,'jadon','sancho','england',23,'winger',25),
(110,'antony','silva','brazil',23,'winger',21),
(111,'marcus','rashford','england',25,'stricker',10);

create table staff(
managerid int primary key,
firstname varchar(20) not null,
lastname varchar(20) not null,
nationality varchar(20) not null,
manager_role varchar(20) not null
);

select* from staff;
alter table staff rename column manager_role to staff_role;
alter table staff rename column managerid to staffid;

create table board_members(
memberid int primary key ,
firstname varchar(20) not null,
lastname varchar(20) not null,
postion varchar(30) not null);

select * from board_members;

create table playercontractinfo(
playerinfo int,
wage int not null,
contract_starts date, #yyyy-mm-dd
contract_ends date, #yyyy-mm-dd
player_value int not null,
foreign key(playerinfo) references players(playerid)
);
select*from playercontractinfo;
alter table playercontractinfo modify player_value varchar(20);
insert into playercontractinfo values(101,375000,'2018-01-20','2024-06-01','13m'),
(102,85000,'2023-06-19','2027-06-01','35m'),
(103,350000,'2020-06-18','2024-06-01','35m'),
(104,150000,'2022-06-11','2027-06-01','44m'),
(105,150000,'2023-01-21','2027-06-01','30m'),
(106,300000,'2022-06-21','2027-06-01','40m'),
(107,150000,'2022-06-13','2025-06-01','15m'),
(108,240000,'2022-06-15','2026-06-01','65m'),
(109,300000,'2021-06-28','2027-06-01','50m'),
(110,200000,'2022-06-25','2027-06-01','55m'),
(111,200000,'2021-06-11','2024-06-01','70m');

create table managercontractinfo(
managerinfo int not null,
wage int not null,
contract_starts date, #yyyy-mm-dd
contract_ends date, #yyyy-mm-dd
foreign key(managerinfo) references staff(staffid)
);
select * from managercontractinfo;

insert into managercontractinfo values
(201,80000,'2022-07-01','2025-06-30'),
(202,40000,'2022-07-01','2025-06-30'),
(203,20000,'2019-07-01','2024-06-30'),
(204,20000,'2019-07-01','2024-06-30'),
(205,15000,'2022-07-01','2025-06-30'),
(206,15000,'2022-07-30','2025-06-30');

#QUERIES

alter table players modify firstname varchar(25);
alter table players rename column jersey_no to jersey;

update staff set nationality='holland' where staffid=201;
update players set position='defmid' where playerid=106;

#DRL QUERIES

select playerid,firstname,position from players;
select * from players where playerid=104;
select * from players where nationality='england';
select * from staff where nationality!='england';
select * from playercontractinfo where player_value>'40m';

select * from players where jersey between 4 and 11;
select * from managercontractinfo where wage in(80000,20000,50000);

#SORTING

select* from players order by firstname;
select * from players order by lastname desc;
select distinct nationality from players;
select * from players where firstname like '%s';
select * from players where lastname like 's%';

select count(firstname),nationality from players group by nationality;
select count(playerinfo),player_value,sum(wage),min(wage),max(wage) from playercontractinfo group by player_value;

#joins
select lastname,position,age,contract_ends,player_value from players inner join playercontractinfo where playerid=playerinfo;
select * from players where playerid=(select playerinfo from playercontractinfo where player_value='40m');
select * from staff where staffid=(select managerinfo from managercontractinfo where wage=40000);
