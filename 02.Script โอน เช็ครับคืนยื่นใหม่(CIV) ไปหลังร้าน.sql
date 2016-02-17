use bcvat
set dateformat dmy
if exists(select name from tempdb.dbo.sysobjects where name = 'BCCHQINDEPOSIT2') 
	drop table tempdb.dbo.BCCHQINDEPOSIT2
if exists(select name from tempdb.dbo.sysobjects where name = 'BCChqInDepo2Sub') 
	drop table tempdb.dbo.BCChqInDepo2Sub
if exists(select name from tempdb.dbo.sysobjects where name = 'bctrans_chqindep2') 
	drop table tempdb.dbo.bctrans_chqindep2
if exists(select name from tempdb.dbo.sysobjects where name = 'bctranssub_chqindep2') 
	drop table tempdb.dbo.bctranssub_chqindep2
go 

select * into tempdb.dbo.bcchqindeposit2 from nebula.bcnp.dbo.bcchqindeposit2
	where docdate between '01/01/2015' and '31/12/2015'
		and  docno like '%CIV%'
select * into tempdb.dbo.bcchqindepo2sub from nebula.bcnp.dbo.bcchqindepo2sub 
	where docno in (select docno from tempdb.dbo.bcchqindeposit2)
select * into tempdb.dbo.bctrans_chqindep2 from nebula.bcnp.dbo.bctrans 
	where docno in (select docno from tempdb.dbo.bcchqindeposit2)
select * into tempdb.dbo.bctranssub_chqindep2 from nebula.bcnp.dbo.bctranssub 
	where docno in (select docno from tempdb.dbo.bcchqindeposit2)
go 

alter table tempdb.dbo.bcchqindeposit2 drop column roworder
alter table tempdb.dbo.bcchqindepo2sub drop column roworder
alter table tempdb.dbo.bctrans_chqindep2 drop column roworder
alter table tempdb.dbo.bctranssub_chqindep2 drop column roworder
go 

delete bcchqindeposit2 where docno in (select docno from tempdb.dbo.bcchqindeposit2)
delete bcchqindepo2sub where docno in (select docno from tempdb.dbo.bcchqindeposit2)
delete bctrans where docno in (select docno from tempdb.dbo.bcchqindeposit2)
delete bctranssub where docno in (select docno from tempdb.dbo.bcchqindeposit2)
go 

insert into bcchqindeposit2 select * from tempdb.dbo.bcchqindeposit2
insert into bcchqindepo2sub select * from tempdb.dbo.bcchqindepo2sub
insert into bctrans select * from tempdb.dbo.bctrans_chqindep2
insert into bctranssub select * from tempdb.dbo.bctranssub_chqindep2
GO 



