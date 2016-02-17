use bcvat
set dateformat dmy
if exists(select name from tempdb.dbo.sysobjects where name = 'BCCASHBANKOUT') 
	drop table tempdb.dbo.bccashbankout
if exists(select name from tempdb.dbo.sysobjects where name = 'bctrans_BCCASHBANKOUT') 
	drop table tempdb.dbo.bctrans_BCCASHBANKOUT
if exists(select name from tempdb.dbo.sysobjects where name = 'bctranssub_BCCASHBANKOUT') 
	drop table tempdb.dbo.bctranssub_BCCASHBANKOUT
go 

select *  into tempdb.dbo.BCCASHBANKOUT
	 from nebula.bcnp.dbo.BCCASHBANKOUT
	where docdate between '01/06/2015' and '30/06/2015'
		and  (docno like '%BBV%' )


select * into tempdb.dbo.bctrans_BCCASHBANKOUT from nebula.bcnp.dbo.bctrans 
	where docno in (select docno from tempdb.dbo.BCCASHBANKOUT)
select * into tempdb.dbo.bctranssub_BCCASHBANKOUT from nebula.bcnp.dbo.bctranssub 
	where docno in (select docno from tempdb.dbo.BCCASHBANKOUT)
go 

alter table tempdb.dbo.BCCASHBANKOUT drop column roworder
alter table tempdb.dbo.bctrans_BCCASHBANKOUT drop column roworder
alter table tempdb.dbo.bctranssub_BCCASHBANKOUT drop column roworder
go 

delete BCCASHBANKOUT where docno in (select docno from tempdb.dbo.BCCASHBANKOUT)
delete bctrans where docno in (select docno from tempdb.dbo.BCCASHBANKOUT)
delete bctranssub where docno in (select docno from tempdb.dbo.BCCASHBANKOUT)
go 

insert into BCCASHBANKOUT select * from tempdb.dbo.BCCASHBANKOUT
insert into bctrans select * from tempdb.dbo.bctrans_BCCASHBANKOUT
insert into bctranssub select * from tempdb.dbo.bctranssub_BCCASHBANKOUT
GO 


