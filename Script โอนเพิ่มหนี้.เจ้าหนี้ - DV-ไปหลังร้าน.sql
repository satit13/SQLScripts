-- Script โอนลดหนี้.ส่งคืน dv ไปหลังร้้าน เฉพาะรายการที่ยังไม่มีหลังร้าน


USE BCVAT


DROP TABLE TEMPDB.DBO.bcdebitnote2_KEY
DROP TABLE TEMPDB.DBO.bcdebitnote2_dv
DROP TABLE TEMPDB.DBO.BCTRANS_dv
DROP TABLE TEMPDB.DBO.BCinputtax_dv
DROP TABLE TEMPDB.DBO.bctranssub_dv
drop table tempdb.dbo.bcinvdebitnote2


select * into tempdb.dbo.bcdebitnote2_key 
	from nebula.bcnp.dbo.bcdebitnote2 
	where docno like '%dv%' 
		AND YEAR(DOCDATE)=2015 
		AND	DOCNO NOT IN (SELECT DOCNO FROM BCVAT.DBO.bcdebitnote2)
		
select * into tempdb.dbo.bcdebitnote2_dv 
	from  nebula.bcnp.dbo.bcdebitnote2 where docno in (select docno from tempdb.dbo.bcdebitnote2_key)
select * into tempdb.dbo.BCTRANS_dv 
	from  nebula.bcnp.dbo.BCTRANS where docno in (select docno from tempdb.dbo.bcdebitnote2_key)
select * into tempdb.dbo.BCTRANSSUB_dv 
	from  nebula.bcnp.dbo.bctranssub where docno in (select docno from tempdb.dbo.bcdebitnote2_key)
select * into tempdb.dbo.bcinputtax_dv 
	from  nebula.bcnp.dbo.bcinputtax where docno in (select docno from tempdb.dbo.bcdebitnote2_key)
select * into tempdb.dbo.bcinvdebitnote2_dv 
	from  nebula.bcnp.dbo.bcinvdebitnote2 where debitnoteno in (select docno from tempdb.dbo.bcdebitnote2_key)
	
	
alter table tempdb.dbo.bcdebitnote2_dv drop column roworder
alter table tempdb.dbo.BCTRANS_dv drop column roworder
alter table tempdb.dbo.BCTRANSSUB_dv drop column roworder
alter table tempdb.dbo.bcinputtax_dv drop column roworder
alter table tempdb.dbo.bcinvdebitnote2_dv drop column roworder

delete bcdebitnote2 where DocNo in (select DocNo from tempdb.dbo.bcdebitnote2_key)
delete BCTRANS where DocNo in (select DocNo from tempdb.dbo.bcdebitnote2_key)
delete BCTRANSSUB where DocNo in (select DocNo from tempdb.dbo.bcdebitnote2_key)
delete bcinputtax where DocNo in (select DocNo from tempdb.dbo.bcdebitnote2_key)
delete bcinvdebitnote2 where debitnoteno in (select DocNo from tempdb.dbo.bcdebitnote2_key)


insert into bcdebitnote2 select * from tempdb.dbo.bcdebitnote2_dv
insert into BCTRANS select * from tempdb.dbo.BCTRANS_dv
insert into BCTRANSSUB select * from tempdb.dbo.BCTRANSSUB_dv
insert into bcinputtax select * from tempdb.dbo.bcinputtax_dv
insert into bcinvdebitnote2 select * from tempdb.dbo.bcinvdebitnote2_dv


go 