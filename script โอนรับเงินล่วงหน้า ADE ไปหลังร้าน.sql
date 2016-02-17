use bcvat
drop table tempdb.dbo.bcardepositspecial
drop table tempdb.dbo.bctrans_depspecial
drop table tempdb.dbo.btranssub_depspecial

select * into tempdb.dbo.bcardepositspecial 
	from nebula.bcnp.dbo.bcardepositspecial 
	where docno like '%ADE%' and year(docdate)=2015
select * into tempdb.dbo.bctrans_depspecial  from nebula.bcnp.dbo.bctrans 
	where docno like '%ADE%' and year(docdate)=2015
select * into tempdb.dbo.btranssub_depspecial from nebula.bcnp.dbo.bctranssub  
	where docno like '%ADE%' and year(docdate)=2015 

alter table tempdb.dbo.bcardepositspecial drop column roworder
alter table tempdb.dbo.bctrans_depspecial drop column roworder
alter table tempdb.dbo.btranssub_depspecial drop column roworder

delete bcardepositspecial where docno in (select docno from tempdb.dbo.bcardepositspecial)
delete bctrans where docno in (select docno from tempdb.dbo.bcardepositspecial)
delete bctranssub where docno in (select docno from tempdb.dbo.bcardepositspecial)

insert into bcardepositspecial select * from tempdb.dbo.bcardepositspecial
insert into bctrans select * from tempdb.dbo.bctrans_depspecial
insert into bctranssub select * from tempdb.dbo.btranssub_depspecial
