use bcvat

--- �͹�������١��ҷ���ѧ�������ѧ��ҹ
select * into tempdb.dbo.bcar_Add from nebula.bcnp.dbo.bcar where code not in (select code from bi.bcvat.dbo.bcar)

alter table tempdb.dbo.bcar_Add drop column roworder

insert into bcar select * from tempdb.dbo.bcar_add