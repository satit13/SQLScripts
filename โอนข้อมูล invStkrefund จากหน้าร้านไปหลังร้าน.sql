

if exists(select name from tempdb.dbo.sysobjects where name = 'bcinvstkrefund_add')
	drop table tempdb.dbo.bcinvstkrefund_add

select *
   into tempdb.dbo.bcinvstkrefund_add
   from nebula.bcnp.dbo.bcinvstkrefund 
	where stkrefundno in (select docno from bcstkrefund)
		and stkrefundno not in (select stkrefundno from bcinvstkrefund)


alter table tempdb.dbo.bcinvstkrefund_add drop column roworder
GO 
insert into bcinvstkrefund select * from tempdb.dbo.bcinvstkrefund_add
GO 