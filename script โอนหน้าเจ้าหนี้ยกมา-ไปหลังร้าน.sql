if exists(select name from  tempdb.dbo.sysobjects where name = 'bcapinvbalance')
	drop table tempdb.dbo.bcapinvbalance


select * 
into tempdb.dbo.bcapinvbalance 
from nebula.bcnp.dbo.bcapinvbalance where docno in ( 'IV5312-1283','IV5307-1434')

alter table tempdb.dbo.bcapinvbalance  drop column roworder
go
delete bcapinvbalance where docno  in (select docno from tempdb.dbo.bcapinvbalance)
go
insert into bcapinvbalance select * from tempdb.dbo.bcapinvbalance
go




