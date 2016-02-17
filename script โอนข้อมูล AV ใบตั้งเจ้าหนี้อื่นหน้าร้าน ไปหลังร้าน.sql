use bcvat
set dateformat dmy
if exists(select name from tempdb.dbo.sysobjects where name = 'bcapotherdebt')
	drop table tempdb.dbo.bcapotherdebt
if exists(select name from tempdb.dbo.sysobjects where name = 'bcinputtax')
	drop table tempdb.dbo.bcinputtax
if exists(select name from tempdb.dbo.sysobjects where name = 'bcapwtaxlist')
	drop table tempdb.dbo.bcapwtaxlist
if exists(select name from tempdb.dbo.sysobjects where name = 'bctrans')
	drop table tempdb.dbo.bctrans
if exists(select name from tempdb.dbo.sysobjects where name = 'bctranssub')
	drop table tempdb.dbo.bctranssub
if exists(select name from tempdb.dbo.sysobjects where name = 'bcpaymoney')
	drop table tempdb.dbo.bcpaymoney

if exists(select name from tempdb.dbo.sysobjects where name = 'apotherdebt_key')
	drop table tempdb.dbo.apotherdebt_key
go
select docno into tempdb.dbo.apotherdebt_key from nebula.bcnp.dbo.bcapotherdebt 
	where year(docdate)=2015 and (docno like '%AV%' or docno like '%AV%')
		and docno not in (select docno from bcvat.dbo.BCAPOtherDebt)
go





print 'เลือกข้อมูล'
select * into tempdb.dbo.bcapotherdebt from nebula.bcnp.dbo.bcapotherdebt where docno in (select docno from tempdb.dbo.apotherdebt_key)
select * into tempdb.dbo.bcinputtax from nebula.bcnp.dbo.bcinputtax  where docno in (select docno from tempdb.dbo.apotherdebt_key)
select * into tempdb.dbo.bcapwtaxlist from nebula.bcnp.dbo.bcapwtaxlist where docno in (select docno from tempdb.dbo.apotherdebt_key)
select * into tempdb.dbo.bctrans from nebula.bcnp.dbo.bctrans where docno in (select docno from tempdb.dbo.apotherdebt_key)
select * into tempdb.dbo.bctranssub from nebula.bcnp.dbo.bctranssub where docno in (select docno from tempdb.dbo.apotherdebt_key)
select * into tempdb.dbo.bcpaymoney from nebula.bcnp.dbo.bcpaymoney  where docno in (select docno from tempdb.dbo.apotherdebt_key)

go

print 'Alter table drop roworder'
alter table tempdb.dbo.bcapotherdebt drop column roworder
alter table tempdb.dbo.bcinputtax	drop column roworder
alter table tempdb.dbo.bcapwtaxlist drop column roworder
alter table tempdb.dbo.bctrans drop column roworder
alter table tempdb.dbo.bctranssub drop column roworder
alter table tempdb.dbo.bcpaymoney drop column roworder

go 
print 'ลบข้อมูลเดิม'
delete bcapotherdebt where docno in (select docno from tempdb.dbo.bcapotherdebt)
delete bcinputtax where docno in (select docno from tempdb.dbo.bcapotherdebt)
delete bcapwtaxlist where docno in (select docno from tempdb.dbo.bcapotherdebt)
delete bctrans where docno in (select docno from tempdb.dbo.bcapotherdebt)
delete bctranssub where docno in (select docno from tempdb.dbo.bcapotherdebt)
delete bcpaymoney where docno in (select docno from tempdb.dbo.bcapotherdebt)

go 

print 'insert new data'
insert into bcapotherdebt select * from tempdb.dbo.bcapotherdebt 
insert into bcinputtax select * from tempdb.dbo.bcinputtax 
insert into bcapwtaxlist select * from tempdb.dbo.bcapwtaxlist 
insert into bctrans select * from tempdb.dbo.bctrans 
insert into bctranssub select * from tempdb.dbo.bctranssub 
insert into bcpaymoney select * from tempdb.dbo.bcpaymoney 

go

