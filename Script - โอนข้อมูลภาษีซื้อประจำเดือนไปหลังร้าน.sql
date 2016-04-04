use bcvat
if exists(select name from tempdb.dbo.sysobjects where name = 'invat')
	drop table tempdb.dbo.invat
if exists(select name from tempdb.dbo.sysobjects where name = 'bcinputtax')
	drop table tempdb.dbo.bcinputtax

if exists(select name from tempdb.dbo.sysobjects where name = 'bcapinvoice')
	drop table tempdb.dbo.bcapinvoice

if exists(select name from tempdb.dbo.sysobjects where name = 'bcapinvoicesub')
	drop table tempdb.dbo.bcapinvoicesub

if exists(select name from tempdb.dbo.sysobjects where name = 'bcirsub')
	drop table tempdb.dbo.bcirsub

if exists(select name from tempdb.dbo.sysobjects where name = 'bcstkrefund')
	drop table tempdb.dbo.bcstkrefund

if exists(select name from tempdb.dbo.sysobjects where name = 'bcstkrefundsub')
	drop table tempdb.dbo.bcstkrefundsub

if exists(select name from tempdb.dbo.sysobjects where name = 'bcapotherdebt')
	drop table tempdb.dbo.bcapotherdebt

if exists(select name from tempdb.dbo.sysobjects where name = 'bctrans')
	drop table tempdb.dbo.bctrans

if exists(select name from tempdb.dbo.sysobjects where name = 'bctranssub')
	drop table tempdb.dbo.bctranssub

if exists(select name from tempdb.dbo.sysobjects where name = 'bcotherexpense')
	drop table tempdb.dbo.bcotherexpense


if exists(select name from tempdb.dbo.sysobjects where name = 'bcpayment')
	drop table tempdb.dbo.bcpayment
if exists(select name from tempdb.dbo.sysobjects where name = 'bcpaymentsub')
	drop table tempdb.dbo.bcpaymentsub
if exists(select name from tempdb.dbo.sysobjects where name = 'bcpaymoney')
	drop table tempdb.dbo.bcpaymoney
if exists(select name from tempdb.dbo.sysobjects where name = 'bcchqout')
	drop table tempdb.dbo.bcchqout




GO 







select docno  into tempdb.dbo.invat 
from nebula.bcnp.dbo.bcinputtax 
where year(taxdate)=2016 and month(taxdate)=1
and docno not like '%IS%'
and docno not like '%IR%'
and docno not like '%CNC%'
and docno not like '%IN%'
and docno not like '%CNR%'


-- inputtax 
select * into tempdb.dbo.bcinputtax from nebula.bcnp.dbo.bcinputtax where docno in (select docno from tempdb.dbo.invat)

-- ����+ ����˹�� 
select * into tempdb.dbo.bcapinvoice from nebula.bcnp.dbo.bcapinvoice where docno in (select docno from tempdb.dbo.invat)
select * into tempdb.dbo.bcapinvoicesub from nebula.bcnp.dbo.bcapinvoicesub where docno in (select docno from tempdb.dbo.invat)
select * into tempdb.dbo.bcirsub from nebula.bcnp.dbo.bcirsub where docno in (select docno from tempdb.dbo.invat)
-- Ŵ˹�� 
select * into tempdb.dbo.bcstkrefund  from nebula.bcnp.dbo.bcstkrefund where docno in (select docno from tempdb.dbo.invat)
select * into tempdb.dbo.bcstkrefundsub  from nebula.bcnp.dbo.bcstkrefundsub where docno in (select docno from tempdb.dbo.invat)

-- ����˹������ 
select * into tempdb.dbo.bcapotherdebt from nebula.bcnp.dbo.bcapotherdebt where docno in (select docno from tempdb.dbo.invat)

-- GL 
select * into tempdb.dbo.bctrans  from nebula.bcnp.dbo.bctrans where docno in (select docno from tempdb.dbo.invat)
select * into tempdb.dbo.bctranssub from nebula.bcnp.dbo.bctranssub where docno in (select docno from tempdb.dbo.invat)

-- ������Թ���� �

select * into tempdb.dbo.bcotherexpense from nebula.bcnp.dbo.bcotherexpense where docno in (select docno from tempdb.dbo.invat)

GO 


select * into tempdb.dbo.bcpayment from nebula.bcnp.dbo.bcpayment where docno in (select docno from tempdb.dbo.invat)
select * into tempdb.dbo.bcpaymentsub from nebula.bcnp.dbo.bcpaymentsub where docno in (select docno from tempdb.dbo.invat)
select * into tempdb.dbo.bcpaymoney from nebula.bcnp.dbo.bcpaymoney where docno in (select docno from tempdb.dbo.invat)
select * into tempdb.dbo.bcchqout  from nebula.bcnp.dbo.bcchqout where docno in (select docno from tempdb.dbo.invat)

GO 




alter table tempdb.dbo.bcinputtax drop column roworder
alter table tempdb.dbo.bcapinvoice drop column roworder
alter table tempdb.dbo.bcapinvoicesub drop column roworder
alter table tempdb.dbo.bcirsub drop column roworder
alter table tempdb.dbo.bcstkrefund drop column roworder
alter table tempdb.dbo.bcstkrefundsub drop column roworder
alter table tempdb.dbo.bcapotherdebt drop column roworder
alter table tempdb.dbo.bctrans drop column roworder
alter table tempdb.dbo.bctranssub drop column roworder
alter table tempdb.dbo.bcotherexpense drop column roworder
alter table tempdb.dbo.bcpayment drop column roworder
alter table tempdb.dbo.bcpaymentsub drop column roworder
alter table tempdb.dbo.bcpaymoney drop column roworder
alter table tempdb.dbo.bcchqout drop column roworder
GO 

delete bcinputtax where docno in (select docno from tempdb.dbo.invat)
delete bcapinvoice where docno in (select docno from tempdb.dbo.invat)
delete bcapinvoicesub where docno in (select docno from tempdb.dbo.invat)
delete bcirsub where docno in (select docno from tempdb.dbo.invat)
delete bcstkrefund where docno in (select docno from tempdb.dbo.invat)
delete bcstkrefundsub where docno in (select docno from tempdb.dbo.invat)
delete bcapotherdebt where docno in (select docno from tempdb.dbo.invat)
delete bctrans where docno in (select docno from tempdb.dbo.invat)
delete bctranssub where docno in (select docno from tempdb.dbo.invat)
delete bcotherexpense where docno in (select docno from tempdb.dbo.invat)

delete BCPayment where docno in (select docno from tempdb.dbo.invat)
delete bcpaymentsub where docno in (select docno from tempdb.dbo.invat)
delete bcpaymoney where docno in (select docno from tempdb.dbo.invat)
delete bcchqout where docno in (select docno from tempdb.dbo.invat)

GO 

insert into bcinputtax select * from tempdb.dbo.bcinputtax
insert into bcapinvoice select * from tempdb.dbo.bcapinvoice
insert into bcapinvoicesub select * from tempdb.dbo.bcapinvoicesub
insert into bcirsub select * from tempdb.dbo.bcirsub
insert into bcstkrefund select * from tempdb.dbo.bcstkrefund
insert into bcstkrefundsub select * from tempdb.dbo.bcstkrefundsub
insert into bcapotherdebt select * from tempdb.dbo.bcapotherdebt
insert into bctrans select * from tempdb.dbo.bctrans
insert into bctranssub select * from tempdb.dbo.bctranssub
insert into bcotherexpense select * from tempdb.dbo.bcotherexpense

insert into bcpayment select * from tempdb.dbo.bcpayment
insert into bcpaymentsub select * from tempdb.dbo.bcpaymentsub
insert into bcpaymoney select * from tempdb.dbo.bcpaymoney
insert into bcchqout select * from tempdb.dbo.bcchqout



GO 