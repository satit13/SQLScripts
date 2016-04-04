select * from 
(
	select b.* , a.*
	 From 
	(
	select sum(payamount) as payamount ,refno  ,docdate
	from BCPayMoney 
		where PaymentType = 2 and YEAR(docdate) in (2012,2013,2014)
		group by RefNo ,docdate
		
	) A full outer join 
	(
		select chqnumber,docno,paymentdate,SUM(amount) as amount ,status,duedate,sum(balance) as balance
		from BCChqOut 
		where year(paymentdate) between 2012 and 2014
		group by ChqNumber,paymentdate ,status,docno,duedate
	) B on a.RefNo = b.ChqNumber

	where isnull(a.RefNo ,'') <> ISNULL(b.chqnumber,'')
) a left join (select docno,canceldatetime from BCPayment 
				union 
				select docno,canceldatetime from BCOtherExpense)  b on a.DocNo = b.DocNo 
				


-- 
select * , isnull(a.payamount,0) - isnull(cd,0) as diff from 
(
	select sum(payamount) as payamount ,docno  ,docdate
	from BCPayMoney 
		where PaymentType = 2 and YEAR(docdate) in (2012,2013,2014)
		group by docno ,docdate
) A Full outer join 	
(	
	select DocNo,SUM(debit) as db ,SUM(credit) as cd  from BCTransSub 
	where Source not  in (0) and  Credit <> 0 and  YEAR(docdate) in (2012,2013,2014) and 
		accountcode in 
		(select accountcode 
			from nebula.npmaster.dbo.TB_GL_ReconcileAccount 
			where reconcilemodule='APCQ1001'
			)
	group by docno
) B on a.DocNo = b.DocNo 	
where ISNULL(a.docno,'') <> ISNULL(b.DocNo,'') or a.payamount <> b.cd