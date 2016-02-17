use bcvat
set dateformat dmy
if exists(select name from tempdb.dbo.sysobjects where name = 'BCCASHBANKIN') 
	drop table tempdb.dbo.bccashbankin
if exists(select name from tempdb.dbo.sysobjects where name = 'bctrans_BCCASHBANKIN') 
	drop table tempdb.dbo.bctrans_BCCASHBANKIN
if exists(select name from tempdb.dbo.sysobjects where name = 'bctranssub_BCCASHBANKIN') 
	drop table tempdb.dbo.bctranssub_BCCASHBANKIN
go 

select *  into tempdb.dbo.BCCASHBANKIN
	 from nebula.bcnp.dbo.BCCASHBANKIN
	where docdate between '01/01/2015' and '31/12/2015'
		and  (docno like '%BA%' or docno like '%BF%' or docno like '%BH%')


select * into tempdb.dbo.bctrans_BCCASHBANKIN from nebula.bcnp.dbo.bctrans 
	where docno in (select docno from tempdb.dbo.BCCASHBANKIN)
select * into tempdb.dbo.bctranssub_BCCASHBANKIN from nebula.bcnp.dbo.bctranssub 
	where docno in (select docno from tempdb.dbo.BCCASHBANKIN)
go 

alter table tempdb.dbo.BCCASHBANKIN drop column roworder
alter table tempdb.dbo.bctrans_BCCASHBANKIN drop column roworder
alter table tempdb.dbo.bctranssub_BCCASHBANKIN drop column roworder
go 

delete BCCASHBANKIN where docno in (select docno from tempdb.dbo.BCCASHBANKIN)
delete bctrans where docno in (select docno from tempdb.dbo.BCCASHBANKIN)
delete bctranssub where docno in (select docno from tempdb.dbo.BCCASHBANKIN)
go 

insert into BCCASHBANKIN select * from tempdb.dbo.BCCASHBANKIN
insert into bctrans select * from tempdb.dbo.bctrans_BCCASHBANKIN
insert into bctranssub select * from tempdb.dbo.bctranssub_BCCASHBANKIN
GO 


