use bcvat
drop table tempdb.dbo.bcissue
drop table tempdb.dbo.bcstkissue
drop table tempdb.dbo.bcstkissuesub
drop table tempdb.dbo.bctrans
drop table tempdb.dbo.bctranssub
go 


select docno into tempdb.dbo.bcissue
	from nebula.bcnp.dbo.bcstkissue 
	where year(docdate)=2015
	and (	docno  like '%MX%' or 
			docno like '%PG%' or 
			docno like '%IA%' or 
			docno like '%IC%' or 
			docno like '%PK%' or 
			docno like '%IB%' or 
			docno like '%IW%')
go 


select * into tempdb.dbo.bcstkissue from nebula.bcnp.dbo.bcstkissue where docno in (select docno from tempdb.dbo.bcissue)
select * into tempdb.dbo.bcstkissuesub from nebula.bcnp.dbo.bcstkissuesub where docno in (select docno from tempdb.dbo.bcissue)
select * into tempdb.dbo.bctrans from nebula.bcnp.dbo.bctrans where docno in (select docno from tempdb.dbo.bcissue)
select * into tempdb.dbo.bctranssub from nebula.bcnp.dbo.bctranssub where docno in (select docno from tempdb.dbo.bcissue)
go 

alter table tempdb.dbo.bcstkissue drop column roworder
alter table tempdb.dbo.bcstkissuesub drop column roworder
alter table tempdb.dbo.bctrans drop column roworder
alter table tempdb.dbo.bctranssub drop column roworder
go 

delete bcstkissue where docno in (select docno from tempdb.dbo.bcissue)
delete bcstkissuesub where docno in (select docno from tempdb.dbo.bcissue)
delete bctrans where docno in (select docno from tempdb.dbo.bcissue)
delete bctranssub where docno in (select docno from tempdb.dbo.bcissue)
go 

insert into bcstkissue select * from tempdb.dbo.bcstkissue
insert into bcstkissuesub select * from tempdb.dbo.bcstkissuesub
insert into bctrans select * from tempdb.dbo.bctrans
insert into bctranssub select * from tempdb.dbo.bctranssub
go 


