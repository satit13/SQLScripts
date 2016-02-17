use BCVAT
select * into tempdb.dbo.bcstkrefund 
	from nebula.bcnp.dbo.bcstkrefund 
	where (DocNo like '%GRV%' or docno like '%GRE%' ) and YEAR(docdate)>=2014



select * into tempdb.dbo.bcstkrefundsub from nebula.bcnp.dbo.bcstkrefundsub where docno in (select docno from tempdb.dbo.bcstkrefund)

select * into tempdb.dbo.bctrans_refund from bctrans where docno in (select docno from tempdb.dbo.bcstkrefund)
select * into tempdb.dbo.bctranssub_refund from bctranssub where docno in (select docno from tempdb.dbo.bcstkrefund)

alter table tempdb.dbo.bcstkrefund drop column roworder
alter table tempdb.dbo.bcstkrefundsub drop column roworder
alter table tempdb.dbo.bctrans_refund drop column roworder
alter table tempdb.dbo.bctranssub_refund drop column roworder

use bcvat 

delete bcstkrefund where docno in (select docno from tempdb.dbo.bcstkrefund)
delete bcstkrefundsub where docno in (select docno from tempdb.dbo.bcstkrefund)
delete bctrans where docno in (select docno from tempdb.dbo.bcstkrefund)
delete bctranssub where docno in (select docno from tempdb.dbo.bcstkrefund)


insert into bcstkrefund select * from tempdb.dbo.bcstkrefund
insert into bcstkrefundsub select * from tempdb.dbo.bcstkrefundsub
insert into bctrans select * from tempdb.dbo.bctrans_refund
insert into bctranssub select * from tempdb.dbo.bctranssub_refund

