use bcvat
if exists(select name from tempdb.dbo.sysobjects where name = 'tmp_pmimport')
	drop table tempdb.dbo.tmp_pmimport
if exists(select name from tempdb.dbo.sysobjects where name = 'bcpayment')
	drop table tempdb.dbo.bcpayment
if exists(select name from tempdb.dbo.sysobjects where name = 'bcpaymentsub')
	drop table tempdb.dbo.bcpayment
if exists(select name from tempdb.dbo.sysobjects where name = 'bctrans')
	drop table tempdb.dbo.bctrans
if exists(select name from tempdb.dbo.sysobjects where name = 'bctranssub')
	drop table tempdb.dbo.bctranssub
if exists(select name from tempdb.dbo.sysobjects where name = 'bcpaymoney')
	drop table tempdb.dbo.bcpaymoney
if exists(select name from tempdb.dbo.sysobjects where name = 'bcchqout')
	drop table tempdb.dbo.bcchqout
if exists(select name from tempdb.dbo.sysobjects where name = 'bcapwtaxlist')
	drop table tempdb.dbo.bcapwtaxlist

	

select docno 
into tempdb.dbo.tmp_PMimport
from nebula.bcnp.dbo.bcpayment 
where  year(docdate)=2015 
	 and docno not in 
	(select docno from bi.bcvat.dbo.bcpayment)	and 
	(docno like '%PM%' or docno like '%PX%')
	order by docno 





select * into tempdb.dbo.bcpayment  from nebula.bcnp.dbo.bcpayment  where docno in (select docno from tempdb.dbo.tmp_PMimport)
select * into tempdb.dbo.bcpaymentsub  from nebula.bcnp.dbo.bcpaymentsub  where docno in (select docno from tempdb.dbo.tmp_PMimport)
select * into tempdb.dbo.bctrans  from nebula.bcnp.dbo.bctrans  where docno in (select docno from tempdb.dbo.tmp_PMimport)
select * into tempdb.dbo.bctranssub  from nebula.bcnp.dbo.bctranssub  where docno in (select docno from tempdb.dbo.tmp_PMimport)
select * into tempdb.dbo.bcpaymoney  from nebula.bcnp.dbo.bcpaymoney  where docno in (select docno from tempdb.dbo.tmp_PMimport)
select * into tempdb.dbo.bcchqout  from nebula.bcnp.dbo.bcchqout  where docno in (select docno from tempdb.dbo.tmp_PMimport)
select * into tempdb.dbo.bcapwtaxlist  from nebula.bcnp.dbo.bcapwtaxlist  where docno in (select docno from tempdb.dbo.tmp_PMimport)



 
alter table tempdb.dbo.bcpayment drop column roworder
alter table tempdb.dbo.bcpaymentsub drop column roworder
alter table tempdb.dbo.bcpaymoney drop column roworder
alter table tempdb.dbo.bctrans drop column roworder
alter table tempdb.dbo.bctranssub drop column roworder
alter table tempdb.dbo.bcchqout drop column roworder
alter table tempdb.dbo.bcapwtaxlist drop column roworder

 

insert into bcpayment select * from tempdb.dbo.bcpayment 
insert into bcpaymentsub select * from tempdb.dbo.bcpaymentsub
insert into bcpaymoney select * from tempdb.dbo.bcpaymoney
insert into bctrans select * from tempdb.dbo.bctrans
insert into bctranssub select * from tempdb.dbo.bctranssub
insert into bcchqout select * from tempdb.dbo.bcchqout
insert into bcapwtaxlist select * from tempdb.dbo.bcapwtaxlist

GO
