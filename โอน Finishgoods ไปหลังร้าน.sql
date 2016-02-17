use bcvat

drop table tempdb.dbo.bcfinishgoods
drop table tempdb.dbo.bcfinishgoodssub


select * into tempdb.dbo.bcfinishgoods from  nebula.bcnp.dbo.bcfinishgoods 
	where docno like '%FNS%' and year(docdate)=2015
	
	
select * into tempdb.dbo.bcfinishgoodssub  from  nebula.bcnp.dbo.bcfinishgoodssub where docno in (select docno from tempdb.dbo.bcfinishgoods)
select * into tempdb.dbo.bctrans_FNS
	from nebula.bcnp.dbo.bctrans 
	where docno in (select  docno from tempdb.dbo.bcfinishgoods)
select * into tempdb.dbo.bctranssub_FNS
	from nebula.bcnp.dbo.bctranssub 
	where docno in (select  docno from tempdb.dbo.bcfinishgoods)


alter table tempdb.dbo.bcfinishgoods drop column roworder
alter table tempdb.dbo.bcfinishgoodssub drop column roworder
alter table tempdb.dbo.bctrans_FNS drop column roworder
alter table tempdb.dbo.bctranssub_FNS drop column roworder


delete bcfinishgoods where docno in (select docno from tempdb.dbo.bcfinishgoods)
delete bcfinishgoodssub where docno in (select docno from tempdb.dbo.bcfinishgoods)
delete bctrans where docno in (select docno from tempdb.dbo.bcfinishgoods)
delete bctranssub where docno in (select docno from tempdb.dbo.bcfinishgoods)



insert into bcfinishgoods select * from tempdb.dbo.bcfinishgoods
insert into bcfinishgoodssub select * from tempdb.dbo.bcfinishgoodssub
insert into bctrans select * from tempdb.dbo.bctrans_FNS
insert into bctranssub select * from tempdb.dbo.bctranssub_FNS

