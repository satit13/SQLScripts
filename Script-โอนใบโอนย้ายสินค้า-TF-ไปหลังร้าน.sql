use bcvat



drop table tempdb.dbo.bcstktransfer 
drop table tempdb.dbo.bcstktransfsub 
drop table tempdb.dbo.bcstktransfsub3


select * into tempdb.dbo.bcstktransfer 
	from nebula.bcnp.dbo.bcstktransfer where docno like '%TF%' and YEAR(docdate)=2015
go 

select * into tempdb.dbo.bcstktransfsub 
	from nebula.bcnp.dbo.bcstktransfsub where docno in (select docno from tempdb.dbo.bcstktransfer)
select * into tempdb.dbo.bcstktransfsub3 
	from nebula.bcnp.dbo.bcstktransfsub3 where docno in (select docno from tempdb.dbo.bcstktransfer)
go 


alter table tempdb.dbo.bcstktransfer drop column roworder
alter table tempdb.dbo.bcstktransfsub drop column roworder
alter table tempdb.dbo.bcstktransfsub3 drop column roworder
go 


delete BCStkTransfer where  docno in (select docno from tempdb.dbo.bcstktransfer)
delete BCStkTransfSub where  docno in (select docno from tempdb.dbo.bcstktransfer)
delete BCStkTransfSub3 where  docno in (select docno from tempdb.dbo.bcstktransfer)
go 


insert into BCStkTransfer select * from tempdb.dbo.bcstktransfer
insert into BCStkTransfSub select * from tempdb.dbo.bcstktransfsub
insert into BCStkTransfSub3 select * from tempdb.dbo.bcstktransfsub3
go 