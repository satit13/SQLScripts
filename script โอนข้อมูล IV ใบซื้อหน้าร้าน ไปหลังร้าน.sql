use bcvat
set dateformat dmy
if exists(select name from tempdb.dbo.sysobjects where name = 'bcapinvoice')
	drop table tempdb.dbo.bcapinvoice
if exists(select name from tempdb.dbo.sysobjects where name = 'bcirsub')
	drop table tempdb.dbo.bcirsub
if exists(select name from tempdb.dbo.sysobjects where name = 'bcinputtax')
	drop table tempdb.dbo.bcinputtax
if exists(select name from tempdb.dbo.sysobjects where name = 'bcapwtaxlist')
	drop table tempdb.dbo.bcapwtaxlist
if exists(select name from tempdb.dbo.sysobjects where name = 'bctrans')
	drop table tempdb.dbo.bctrans
if exists(select name from tempdb.dbo.sysobjects where name = 'bctranssub')
	drop table tempdb.dbo.bctranssub
if exists(select name from tempdb.dbo.sysobjects where name = 'bcapdeposituse')
	drop table tempdb.dbo.bcapdeposituse
if exists(select name from tempdb.dbo.sysobjects where name = 'bcpaymoney')
	drop table tempdb.dbo.bcpaymoney

if exists(select name from tempdb.dbo.sysobjects where name = 'apinvoice_key')
	drop table tempdb.dbo.apinvoice_key
go
select docno into tempdb.dbo.apinvoice_key from nebula.bcnp.dbo.bcapinvoice 
	where docno like '%iv%' and 
	docdate between '10/11/2010' and '10/11/2010'
go

--เดือน 9  วันที่ 3, 9,11, 21, 22 ,29 และ 30
--เดือน 10 วันที่ 2, 9, 11, 18, 20, 23, 25, 26, 29 และ 31
 


print 'เลือกข้อมูล'
select * into tempdb.dbo.bcapinvoice from nebula.bcnp.dbo.bcapinvoice where docno in (select docno from tempdb.dbo.apinvoice_key)
select * into tempdb.dbo.bcirsub from nebula.bcnp.dbo.bcirsub  where docno in (select docno from tempdb.dbo.apinvoice_key)
select * into tempdb.dbo.bcinputtax from nebula.bcnp.dbo.bcinputtax  where docno in (select docno from tempdb.dbo.apinvoice_key)
select * into tempdb.dbo.bcapwtaxlist from nebula.bcnp.dbo.bcapwtaxlist where docno in (select docno from tempdb.dbo.apinvoice_key)
select * into tempdb.dbo.bctrans from nebula.bcnp.dbo.bctrans where docno in (select docno from tempdb.dbo.apinvoice_key)
select * into tempdb.dbo.bctranssub from nebula.bcnp.dbo.bctranssub where docno in (select docno from tempdb.dbo.apinvoice_key)
select * into tempdb.dbo.bcapdeposituse from nebula.bcnp.dbo.bcapdeposituse  where docno in (select docno from tempdb.dbo.apinvoice_key)
select * into tempdb.dbo.bcpaymoney from nebula.bcnp.dbo.bcpaymoney  where docno in (select docno from tempdb.dbo.apinvoice_key)

go

print 'Alter table drop roworder'
alter table tempdb.dbo.bcapinvoice drop column roworder
alter table tempdb.dbo.bcirsub	drop column roworder
alter table tempdb.dbo.bcinputtax	drop column roworder
alter table tempdb.dbo.bcapwtaxlist drop column roworder
alter table tempdb.dbo.bctrans drop column roworder
alter table tempdb.dbo.bctranssub drop column roworder
alter table tempdb.dbo.bcapdeposituse drop column roworder
alter table tempdb.dbo.bcpaymoney drop column roworder

go 
print 'ลบข้อมูลเดิม'
delete bcapinvoice where docno in (select docno from tempdb.dbo.bcapinvoice)
delete bcirsub where docno in (select docno from tempdb.dbo.bcapinvoice)
delete bcinputtax where docno in (select docno from tempdb.dbo.bcapinvoice)
delete bcapwtaxlist where docno in (select docno from tempdb.dbo.bcapinvoice)
delete bctrans where docno in (select docno from tempdb.dbo.bcapinvoice)
delete bctranssub where docno in (select docno from tempdb.dbo.bcapinvoice)
delete bcapdeposituse where docno in (select docno from tempdb.dbo.bcapinvoice)
delete bcpaymoney where docno in (select docno from tempdb.dbo.bcapinvoice)

go 

print 'insert new data'
insert into bcapinvoice select * from tempdb.dbo.bcapinvoice 
insert into bcirsub select * from tempdb.dbo.bcirsub 
insert into bcinputtax select * from tempdb.dbo.bcinputtax 
insert into bcapwtaxlist select * from tempdb.dbo.bcapwtaxlist 
insert into bctrans select * from tempdb.dbo.bctrans 
insert into bctranssub select * from tempdb.dbo.bctranssub 
insert into bcapdeposituse select * from tempdb.dbo.bcapdeposituse 
insert into bcpaymoney select * from tempdb.dbo.bcpaymoney 

go



