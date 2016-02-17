-- Script โอนลดหนี้.ส่งคืน dv ไปหลังร้้าน เฉพาะรายการที่ยังไม่มีหลังร้าน


USE BCVAT


DROP TABLE TEMPDB.DBO.bcapdeposit_key
DROP TABLE TEMPDB.DBO.bcapdeposit
DROP TABLE TEMPDB.DBO.BCTRANS_apdep
DROP TABLE TEMPDB.DBO.bcinputtax_apdep
DROP TABLE TEMPDB.DBO.bctranssub_apdep
drop table tempdb.dbo.bcapdeposituse
drop table tempdb.dbo.bcpaymoney_apdep
drop table tempdb.dbo.bcchqout_apdep


select * into tempdb.dbo.bcapdeposit_key 
	from nebula.bcnp.dbo.bcapdeposit 
	where docno like '%DPV%' 
		AND YEAR(DOCDATE)=2015 
		AND	DOCNO NOT IN (SELECT DOCNO FROM BCVAT.DBO.bcapdeposit)
		
select * into tempdb.dbo.bcapdeposit 
	from  nebula.bcnp.dbo.bcapdeposit where docno in (select docno from tempdb.dbo.bcapdeposit_key)
select * into tempdb.dbo.BCTRANS_apdep 
	from  nebula.bcnp.dbo.BCTRANS where docno in (select docno from tempdb.dbo.bcapdeposit_key)
select * into tempdb.dbo.bctranssub_apdep 
	from  nebula.bcnp.dbo.bctranssub where docno in (select docno from tempdb.dbo.bcapdeposit_key)
select * into tempdb.dbo.bcinputtax_apdep 
	from  nebula.bcnp.dbo.bcinputtax where docno in (select docno from tempdb.dbo.bcapdeposit_key)
select * into tempdb.dbo.bcpaymoney_apdep 
	from  nebula.bcnp.dbo.bcpaymoney where docno in (select docno from tempdb.dbo.bcapdeposit_key)
select * into tempdb.dbo.bcchqout_apdep 
	from  nebula.bcnp.dbo.bcchqout where docno in (select docno from tempdb.dbo.bcapdeposit_key)
		
select * into tempdb.dbo.bcapdeposituse
	from  nebula.bcnp.dbo.bcapdeposituse where depositno in (select docno from tempdb.dbo.bcapdeposit_key)
	
	
	
alter table tempdb.dbo.bcapdeposit drop column roworder
alter table tempdb.dbo.BCTRANS_apdep drop column roworder
alter table tempdb.dbo.bctranssub_apdep drop column roworder
alter table tempdb.dbo.bcinputtax_apdep drop column roworder
alter table tempdb.dbo.bcapdeposituse drop column roworder
alter table tempdb.dbo.bcpaymoney_apdep drop column roworder
alter table tempdb.dbo.bcchqout_apdep drop column roworder



delete bcapdeposit where DocNo in (select DocNo from tempdb.dbo.bcapdeposit_key)
delete BCTRANS where DocNo in (select DocNo from tempdb.dbo.bcapdeposit_key)
delete BCTRANSSUB where DocNo in (select DocNo from tempdb.dbo.bcapdeposit_key)
delete bcinputtax where DocNo in (select DocNo from tempdb.dbo.bcapdeposit_key)
delete bcapdeposituse where depositno in (select DocNo from tempdb.dbo.bcapdeposit_key)
delete BCPayMoney where DocNo in (select DocNo from tempdb.dbo.bcapdeposit_key)
delete bcchqout  where DocNo in (select DocNo from tempdb.dbo.bcapdeposit_key)



insert into bcapdeposit select * from tempdb.dbo.bcapdeposit
insert into BCTRANS select * from tempdb.dbo.BCTRANS_apdep
insert into BCTRANSSUB select * from tempdb.dbo.bctranssub_apdep
insert into bcinputtax select * from tempdb.dbo.bcinputtax_apdep
insert into bcapdeposituse select * from tempdb.dbo.bcapdeposituse
insert into BCPayMoney select * from tempdb.dbo.bcpaymoney_apdep
insert into bcchqout  select * from tempdb.dbo.bcchqout_apdep



go 