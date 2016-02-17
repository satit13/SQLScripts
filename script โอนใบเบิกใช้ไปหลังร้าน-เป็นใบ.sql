drop table tempdb.dbo.bcstkissue
drop table tempdb.dbo.bcstkissuesub
drop table tempdb.dbo.bctrans
drop table tempdb.dbo.bctranssub 

use bcvat2011 
select *  into tempdb.dbo.bcstkissue from   nebula.bcnp.dbo.bcstkissue where docno in 
(
'S01-IC5411-0079', 'S01-IE5411-0002', 'S01-IC5412-0065', 
'S01-IB5412-0030', 'S01-IC5412-0094', 'S01-IC5412-0104'
)

select * into tempdb.dbo.bcstkissuesub from   nebula.bcnp.dbo.bcstkissuesub where docno in 
(
'S01-IC5411-0079', 'S01-IE5411-0002', 'S01-IC5412-0065', 
'S01-IB5412-0030', 'S01-IC5412-0094', 'S01-IC5412-0104'
)

select * into tempdb.dbo.bctrans from   nebula.bcnp.dbo.bctrans where docno in 
(
'S01-IC5411-0079', 'S01-IE5411-0002', 'S01-IC5412-0065', 
'S01-IB5412-0030', 'S01-IC5412-0094', 'S01-IC5412-0104'
)

select * into tempdb.dbo.bctranssub from   nebula.bcnp.dbo.bctranssub where docno in 
(
'S01-IC5411-0079', 'S01-IE5411-0002', 'S01-IC5412-0065', 
'S01-IB5412-0030', 'S01-IC5412-0094', 'S01-IC5412-0104'
)

go 

alter table tempdb.dbo.bcstkissue drop column roworder
alter table tempdb.dbo.bcstkissuesub drop column roworder
alter table tempdb.dbo.bctrans drop column roworder
alter table tempdb.dbo.bctranssub drop column roworder


delete bcstkissue where docno in ( select docno from tempdb.dbo.bcstkissue)
delete bcstkissuesub where docno in ( select docno from tempdb.dbo.bcstkissue)
delete bctrans where docno in ( select docno from tempdb.dbo.bcstkissue)
delete bctranssub where docno in ( select docno from tempdb.dbo.bcstkissue)


insert into bcstkissue select * from tempdb.dbo.bcstkissue
insert into bcstkissuesub select * from tempdb.dbo.bcstkissuesub
insert into bctrans select * from tempdb.dbo.bctrans
insert into bctranssub select * from tempdb.dbo.bctranssub