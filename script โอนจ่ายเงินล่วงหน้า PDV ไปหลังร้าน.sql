use bcvat
set dateformat dmy

drop table tempdb.dbo.bcapdepositspecial
drop table tempdb.dbo.bctrans_depspecial
drop table tempdb.dbo.btranssub_depspecial
drop table tempdb.dbo.bcpaymoney_depspecial
drop table tempdb.dbo.bcchqout_depspecial

drop table tempdb.dbo.bcapdepositspecial_key
select docno into tempdb.dbo.bcapdepositspecial_key
from  nebula.bcnp.dbo.bcapdepositspecial 
	where docno like '%PDV%' and year(docdate)=2015 
		and docno not in (select docno from bcvat.dbo.BCAPDepositSpecial)


select * into tempdb.dbo.bcapdepositspecial 
	from nebula.bcnp.dbo.bcapdepositspecial 
	where docno in (select docno from tempdb.dbo.bcapdepositspecial_key)
select * into tempdb.dbo.bctrans_depspecial  from nebula.bcnp.dbo.bctrans 
	where docno in (select docno from tempdb.dbo.bcapdepositspecial_key)
select * into tempdb.dbo.btranssub_depspecial from nebula.bcnp.dbo.bctranssub  
	where docno in (select docno from tempdb.dbo.bcapdepositspecial_key)


select * into tempdb.dbo.bcpaymoney_depspecial 
	from nebula.bcnp.dbo.bcpaymoney 
	where docno in (select docno from tempdb.dbo.bcapdepositspecial_key)
select * into tempdb.dbo.bcchqout_depspecial  from nebula.bcnp.dbo.bcchqout 
	where docno in (select docno from tempdb.dbo.bcapdepositspecial_key)






alter table tempdb.dbo.bcapdepositspecial drop column roworder
alter table tempdb.dbo.bctrans_depspecial drop column roworder
alter table tempdb.dbo.btranssub_depspecial drop column roworder
alter table tempdb.dbo.bcpaymoney_depspecial drop column roworder
alter table tempdb.dbo.bcchqout_depspecial drop column roworder


delete bcapdepositspecial where docno in (select docno from tempdb.dbo.bcapdepositspecial)
delete bctrans where docno in (select docno from tempdb.dbo.bcapdepositspecial)
delete bctranssub where docno in (select docno from tempdb.dbo.bcapdepositspecial)
delete BCPayMoney  where docno in (select docno from tempdb.dbo.bcapdepositspecial)
delete bcchqout  where docno in (select docno from tempdb.dbo.bcapdepositspecial)


insert into bcapdepositspecial select * from tempdb.dbo.bcapdepositspecial
insert into bctrans select * from tempdb.dbo.bctrans_depspecial
insert into bctranssub select * from tempdb.dbo.btranssub_depspecial
insert into bcpaymoney select * from tempdb.dbo.bcpaymoney_depspecial
insert into bcchqout select * from tempdb.dbo.bcchqout_depspecial