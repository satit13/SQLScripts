-- Script �͹������˹�� �ѹ�֡ GL ����ѹ ����ѧ��ҹ ��� GT


use bcvat
set dateformat dmy 

if exists(select name from tempdb.dbo.sysobjects where name = 'bctrans_GT_key')
	drop table tempdb.dbo.bctrans_GT_key
if exists(select name from tempdb.dbo.sysobjects where name = 'bctrans_GT')
	drop table tempdb.dbo.bctrans_GT
if exists(select name from tempdb.dbo.sysobjects where name = 'bctranssub_GT')
	drop table tempdb.dbo.bctranssub_GT


-- ���ҧ Key docno ���ͷӡ���͹��͹
select docno into tempdb.dbo.bctrans_GT_key
	from nebula.bcnp.dbo.bctrans 
	where source=0 and docno like '%GT%' and
	month(docdate) = 6 and year(docdate)=2015



-- �֧��������������� Tempdb ��ѧ��ҹ 
select * into tempdb.dbo.bctrans_GT from nebula.bcnp.dbo.bctrans where docno in (select docno from tempdb.dbo.bctrans_GT_key)
select * into tempdb.dbo.bctranssub_GT from nebula.bcnp.dbo.bctranssub where docno in (select docno from tempdb.dbo.bctrans_GT_key)


alter table tempdb.dbo.bctrans_GT drop column roworder
alter table tempdb.dbo.bctranssub_GT drop column roworder


delete bctrans where docno in (select docno from tempdb.dbo.bctrans_GT_key)
delete bctranssub where docno in (select docno from tempdb.dbo.bctrans_GT_key)

insert into bctrans select * from tempdb.dbo.bctrans_GT
insert into bctranssub select * from tempdb.dbo.bctranssub_GT