-- Script โอนลดหนี้.ส่งคืน CNV ไปหลังร้้าน เฉพาะรายการที่ยังไม่มีหลังร้าน


USE BCVAT


DROP TABLE TEMPDB.DBO.BCSTKREFUND_KEY
DROP TABLE TEMPDB.DBO.BCSTKREFUND_cnv
DROP TABLE TEMPDB.DBO.BCTRANS_CNV
DROP TABLE TEMPDB.DBO.BCinputtax_cnv
DROP TABLE TEMPDB.DBO.bctranssub_cnv
drop table tempdb.dbo.bcinvstkrefund


select * into tempdb.dbo.bcstkrefund_key 
	from nebula.bcnp.dbo.bcstkrefund 
	where docno like '%CNV%' 
		AND YEAR(DOCDATE)=2015 
		AND	DOCNO NOT IN (SELECT DOCNO FROM BCVAT.DBO.BCSTKREFUND)
		
select * into tempdb.dbo.BCSTKREFUND_cnv 
	from  nebula.bcnp.dbo.bcstkrefund where docno in (select docno from tempdb.dbo.bcstkrefund_key)
select * into tempdb.dbo.BCTRANS_CNV 
	from  nebula.bcnp.dbo.BCTRANS where docno in (select docno from tempdb.dbo.bcstkrefund_key)
select * into tempdb.dbo.BCTRANSSUB_CNV 
	from  nebula.bcnp.dbo.bctranssub where docno in (select docno from tempdb.dbo.bcstkrefund_key)
select * into tempdb.dbo.bcinputtax_cnv 
	from  nebula.bcnp.dbo.bcinputtax where docno in (select docno from tempdb.dbo.bcstkrefund_key)
select * into tempdb.dbo.bcinvstkrefund_cnv 
	from  nebula.bcnp.dbo.bcinvstkrefund where stkrefundno in (select docno from tempdb.dbo.bcstkrefund_key)
	
alter table tempdb.dbo.BCSTKREFUND_cnv drop column roworder
alter table tempdb.dbo.BCTRANS_CNV drop column roworder
alter table tempdb.dbo.BCTRANSSUB_CNV drop column roworder
alter table tempdb.dbo.bcinputtax_cnv drop column roworder
alter table tempdb.dbo.bcinvstkrefund_cnv drop column roworder

delete BCStkRefund where DocNo in (select DocNo from tempdb.dbo.bcstkrefund_key)
delete BCTRANS where DocNo in (select DocNo from tempdb.dbo.bcstkrefund_key)
delete BCTRANSSUB where DocNo in (select DocNo from tempdb.dbo.bcstkrefund_key)
delete bcinputtax where DocNo in (select DocNo from tempdb.dbo.bcstkrefund_key)
delete bcinvstkrefund where stkrefundno in (select DocNo from tempdb.dbo.bcstkrefund_key)


insert into BCStkRefund select * from tempdb.dbo.BCSTKREFUND_cnv
insert into BCTRANS select * from tempdb.dbo.BCTRANS_CNV
insert into BCTRANSSUB select * from tempdb.dbo.BCTRANSSUB_CNV
insert into bcinputtax select * from tempdb.dbo.bcinputtax_cnv
insert into bcinvstkrefund select * from tempdb.dbo.bcinvstkrefund_cnv


go 