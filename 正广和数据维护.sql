
�������ݿ���־�ļ���
ALTER DATABASE CRM_UHEOO SET RECOVERY SIMPLE
DBCC SHRINKDATABASE(CRM_UHEOO)
--backup log archivesAgent with no_log   2008�Ժ���֧��
DBCC SHRINKFILE(2)
ALTER DATABASE CRM_UHEOO SET RECOVERY FULL
-- ALTER DATABASE archivesAgent set offline with rollback immediate

select convert(varchar(20),createtime,23) as productDate,ClassGroup,line,ProductName,productNo, count(*) as count,MIN(CreateTime),MAX(CreateTime) from T_Product_Code where CompanyID=32 and 
CreateTime>=CONVERT(varchar(20),dateadd(d,-5,getdate()),23)+' 00:00:00' and CreateTime<=CONVERT(varchar(20),getdate(),120) group by convert(varchar(20),createtime,23),ClassGroup,line,ProductName,productNo order by convert(varchar(20),createtime,23) desc,classgroup

select COUNT(*) from gc_logSum with(nolock)
select * from gc_logSum with(nolock) order by createdate desc
select * from [supportgc.uheoo.com,14333].crm_uheoo.dbo.gc_logSum with(nolock) order by createdate desc
select top 100 b.goods_name,a.* from Dal_Factorylogsum a, Dal_Company_Barcode b where a.goods_code=b.goods_code and b.companyid=32 order by id desc

--��ѯ���ݿ������еı���������

SELECT a.name, b.rows
FROM sysobjects AS a INNER JOIN sysindexes AS b ON a.id = b.id
WHERE (a.type = 'u') AND (b.indid IN (0, 1))
ORDER BY a.name,b.rows DESC
--��ѯ����ϵͳ�û�
select * from Au_System_User
select * from Dal_Mobile where companyid=32
--��ѯ���пͻ�
select * from Dal_Company
select * from Dal_Customer where CompanyID=34
select * from Bi_System_Menu  --ϵͳ���˵�
select * from Bi_Data_Dic	  --ϵͳ��������

--20160714 ��ӱ��������. �������
--<<
select * from T_Product_Code where CompanyID=32 and CreateTime>='2016-07-10 15:00:00' and CreateTime<='2016-07-10 19:00:00'
-->>
-- 20160715 ��ӱ��Ҫ���޸� QQ,WEIXIN
--��
--07-10 18��19��21��18��27��42  ����һ��ʱ�䡣���ĳ�11.3����ˮ��
--һ��104Ͱ
select * from T_Product_Code where CompanyID=32 and 
CreateTime>='2016-07-10 18:19:21' and CreateTime<='2016-07-10 18:27:42'

select ProductName,ProductNo,COUNT(*) from T_Product_Code where CompanyID=32 and 
CreateTime>='2016-07-10 18:19:21' and CreateTime<='2016-07-10 18:27:42' 
group by ProductName,ProductNo

update T_Product_Code set ProductName='11.3����ˮ',ProductNo='1034' where CompanyID=32 and 
CreateTime>='2016-07-10 18:19:21' and CreateTime<='2016-07-10 18:27:42'

--��ѯ0704-Line1-D��0708-Line2-D������¼���������output_zgh_20160715_01.xlsx
select * from T_Product_Code where CompanyID=32 and 
CreateTime>='2016-07-04 00:00:00' and CreateTime<='2016-07-05 00:00:00' and Line=1 and ClassGroup='D��'

select * from T_Product_Code where CompanyID=32 and 
CreateTime>='2016-07-08 00:00:00' and CreateTime<='2016-07-09 00:00:00' and Line=2 and ClassGroup='D��'

--��

--20160724
--�޸ġ����ϰ��Ż������е�"�������Զ����㣬�߼�Ϊ��������=ʵ�ʼ۸�-�ɱ���-����"
--ȡ��ֱ��ҳ����£���ProfitAmount�ֶθ�Ϊ������
--((isnull([Price],(0))-isnull([CostPrice],(0)))-isnull([FeiAmount],(0)))

--20160727
--�鿴��ɾ��ɨ�����ּ�¼
select * from Dal_Company	--�̼��б�
select * from Dal_Customer where CompanyID=53 order by ID desc		--ĳ���̼ҵĿͻ��б�
select * from Dal_Customer where CustomerName='13331987897'			--ĳ���̼ҵĿͻ��б�
select * from Dal_Scan_Code_Log where CompanyID=71 order by ID desc --ĳ���̼ҵĿͻ�ɨ���¼
select * from Bi_SmsLog where Moblies='13331987897'					--ĳ���ͻ��Ķ��ż�¼
select top 1000 * from Bi_SmsLog order by SendTime desc				--����Ķ��ż�¼
select * from Dal_Exchange where Mobile='13331987897'				--ĳ���ͻ��Ļ��ֶһ���¼
select * from T_Searchcode where Mobile='13331987897'				--ĳ���ͻ��Ļ��ֻ�����
select * from Dal_Company_Barcode where CompanyId=32				--ĳ���̼ҵĲ�Ʒ�б�

--��ĳһ�����ְ󶨼�¼�ָ���ʼ״̬
update T_Searchcode set Mobile=null,Uid=null,Ip=null,ExchangeDate=null where ID='16506755'

--20160729
--��ͥ��һ����ά���ѯ����
select * from T_Searchcode where companyid=69 and LongSn='506949128959'
--select * from Dal_Company
select * from T_Scan where companyid=69
select * from T_Codetrash order by ID desc where companyid=69

SELECT a.Id as SearchcodeId,a.Ip, a.Code,a.Mobile,a.ExchangeDate,a.Sn,b.* FROM      (   
SELECT *  	   FROM T_Searchcode	 where Barcode='506949128959'
	)	a  LEFT  JOIN	 T_Product_Code b ON( b.Start<=a.Sn and b.[End]>=a.Sn )	AND a.CompanyId=b.CompanyID
SELECT *  	   FROM T_Searchcode	 where Barcode='506910760907'
select * from T_Searchcode where companyid=69 and LongSn='506910760907'
select * from Dal_Delivery_Log a,T_Searchcode b  where a.BarCodeId=b.id and b.CompanyId=69 and b.LongSn='506949128959'
select * from Dal_Delivery_Log where BarCodeId=14795845
select barcodeid,COUNT(*) from Dal_Delivery_Log group by BarCodeId having COUNT(*)>1
select top 1000 * from T_Searchcode where CompanyId=32 order by ID desc
select top 1000 * from T_Product_Code where CompanyID=32 order by ID desc

--20160809 ���8.8��۸��޸�
select * from Dal_Company_Barcode where CompanyID=53 and goods_code='Q1136351' and field1='M114666146'
select * from Dal_Company_Barcode where CompanyID=53 and field1='BS116175440'
create table dal_company_barcode_53(
point float,
goods_code varchar(50),
goods_name varchar(50),
goods_money float,
f1 varchar(50),
f3 varchar(50),
f8 varchar(50)
)

select * from dal_company_barcode_53

select a.Field1,a.goods_money,a.point,b.goods_money,b.point from Dal_Company_Barcode a, dal_company_barcode_53 b
where a.CompanyID=53 and a.Field1=b.f1 and a.Field3=b.f3 and a.Field8=b.f8 and (a.Point<>b.point or a.Goods_Money<>b.goods_money)

update Dal_Company_Barcode set goods_money=b.goods_money,point=b.point from Dal_Company_Barcode a, dal_company_barcode_53 b
where a.CompanyID=53 and a.Field1=b.f1 and a.Field3=b.f3 and a.Field8=b.f8 and (a.Point<>b.point or a.Goods_Money<>b.goods_money)

--�Ϸʺ��������ʵ����ͳ�������Ƿ�׼ȷ��ĳ��������͵ļ���������ɨ���������������������ͻ�����
select * from T_Product_Code where CompanyID=32 and CreateTime between '2016-06-01 00:00:00' and '2016-06-30 23:59:59'
select COUNT(*) from T_Product_Code where CompanyID=32 and CreateTime between '2016-06-01 00:00:00' and '2016-06-30 23:59:59'
--ʵ���Ϻ�̨ͳ�Ƶļ��������Ǵ�Dal_FactorylogsumԤ������ж�ȡ��
select * from Dal_Factorylogsum where CreateDate between '2016-06-01' and '2016-06-30'
select * from Dal_Factorylogsum where CreateDate>='2016-06-01' and CreateDate<'2016-06-02'
select a.FactoryAddress as '������'   , a.ClassGroup as '������', a.LineNum as '������',a.Goods_Code as '��Ʒ���',a.BindNum  as '������',a.ErrorNum as '������',a.NoExistNum  as '��������',a.ShouBindNum as '�ְ���',a.ShouUnBindNum  as '�����',a.Status as '״̬',a.CreateDate as �������� from  Dal_Factorylogsum a where 1=1   and a.CreateDate>='2016-06-01' and a.CreateDate<'2016-06-02'
select SUM(bindnum) from Dal_Factorylogsum where CreateDate>='2016-06-01' and CreateDate<'2016-06-02'
select SUM(bindnum) from Dal_Factorylogsum where CreateDate between '2016-06-01' and '2016-06-30'
--ɨ������
select * from Dal_Scan_Code_Log where CompanyID=32 and ScanDate between '2016-06-01 00:00:00' and '2016-06-30 23:59:59'
--������
select * from Dal_Exchange where CompanyId=32 and BindingDate between '2016-06-01 00:00:00' and '2016-06-30 23:59:59'
--��ʵ��̨�İ�ͳ���ǰ���ExchangeDate���˵�
select * from Dal_Exchange where CompanyId=32 and ExchangeDate between '2016-06-01 00:00:00' and '2016-06-30 23:59:59'
select a.FactoryAddress as '������'   , a.ClassGroup as '������', a.LineNum as '������',a.Goods_Code as '��Ʒ���',a.BindNum  as '������',a.ErrorNum as '������',a.NoExistNum  as '��������',a.ShouBindNum as '�ְ���',a.ShouUnBindNum  as '�����',a.Status as '״̬',a.CreateDate as �������� 
from Dal_Factorylogsum a
where a.CreateDate>= '2016-06-01' and a.CreateDate<DATEADD(d,1, cast('2016-06-01' as datetime))
select a.FactoryAddress as '������', a.ClassGroup as '������', a.LineNum as '������',a.Goods_Code as '��Ʒ���',a.BindNum  as '������',a.ErrorNum as '������',a.NoExistNum  as '��������',a.ShouBindNum as '�ְ���',a.ShouUnBindNum  as '�����',a.Status as '״̬',a.CreateDate as �������� from  Dal_Factorylogsum a where 1=1   and a.CreateDate>='2016/6/1 0:00:00' and a.CreateDate<'2016/6/2 0:00:00'

--20160819 ��ӱ����ѯָ�������ע����¼
--�������һ����ά����ж��ע����¼���������ظ�ע��
select * from T_Codetrash where Barcode='350855241027'
select * from T_Codetrash where Barcode='384276361325'
select * from T_Product_Code where start=6716096
select * from T_Searchcode where companyid=32 and Barcode='350855241027'
select Code,sn from T_Searchcode where CompanyId=32 and Barcode='fzghYzizNJVWUkUYa'

--20160821 ��̨ϵͳ�У������洢���̣����ԭ�����е�ע����������ע���Ĳ����ظ�������

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Albert	
-- Create date: 20160822
-- Description:	��ֹ�ظ�ע����ά��
--�����ռ�����ȥ��ID������������
--select * into gc_T_Codetrash from T_Codetrash where 1=0
-- =============================================
ALTER TRIGGER trig_T_Codetrash_oncetime
   ON  T_Codetrash with encryption
   AFTER INSERT
AS 
BEGIN
	SET NOCOUNT ON;
	declare @id int
	select @id=ID from inserted
	if exists(select 1 from T_Codetrash a, inserted b where a.Barcode=b.Barcode and a.CompanyId=b.CompanyId and a.Id<@id) and YEAR(getDate())<2018
	begin
		--�Ƚ��ϳ��ļ�¼���浽�ռ���Ȼ��ɾ��
		insert into gc_T_Codetrash select * from inserted
		delete from T_Codetrash where ID=@id
	end
END
GO

--2016823 ���ϰ��ѯ��������Ʒ�޷���
--��Ϊ�����������Ŵ���
select * from T_Product_Code where CompanyID=71
--��Ӧ�ֶΣ���������barcode�����������sn

--20160831 ���Ҫ����10������룬������ʧ��
--���ݿ��ѯ̫������������ȷ
	--����ȥ�����������
alter table T_Searchcode drop constraint PK_T_Searchcode
    --�Ƚ�ID������Ϊ�Ǿۼ�����
alter table T_Searchcode add primary key nonclustered(id)
	--ID����Ψһ����
--create unique index PK_T_Searchcode on T_Searchcode(ID)
	--����companyID�ۼ�����
create clustered index idx_t_searchcode_cid on T_Searchcode(companyId)
select count(*) from T_Searchcode where companyID=32 and creatdate>'2016-09-01'  --���
select top 1 * from T_Searchcode where companyID=32 order by ID desc
select top 1 * from T_Searchcode where companyID=53 and creatdate>'2016-09-01' order by ID 

--2016-09-05 ������в��ֶ�ά�룬�ڡ���ά���ѯ�����Բ鵽ɨ����Ϣ�����ڡ���ά������в鲻����Ϣ��
select * from T_Searchcode where Barcode='812073815628'
select * from T_Searchcode where companyID=32 and len(barcode)>12
select top 1000 * from Dal_Scan_Code_Log where CompanyID=32 order by ID desc --ĳ���̼ҵĿͻ�ɨ���¼
--����ά�����ʵ�����ǻ��ֶһ���ѯ����˽��˵����Ƹ�Ϊ�����ֶһ������
select * from Bi_System_Menu where Parent_Id=15 and Is_Show=1 --ϵͳ���˵�
update Bi_System_Menu set Menu_Name='���ֶһ����' where ID=50

2016-09-09������ܳ�����
select convert(varchar(20),createtime,23) as productDate,address,ClassGroup,count(*),MIN(CreateTime),MAX(CreateTime) from T_Product_Code where CompanyID=32 and 
CreateTime>=CONVERT(varchar(20),dateadd(d,-2,getdate()),23)+' 00:00:00' and CreateTime<=CONVERT(varchar(20),getdate(),120) group by convert(varchar(20),createtime,23),address,ClassGroup

select * from T_Searchcode where Barcode in('584188846656','360117236457','784325165062','713880754854','455010234686','165458523884','180782814068','385310085015','307631145821','251836132364','124723404748','574367371061','750767561645','574367371061','411465755451')
select * from T_Searchcode where sn in(13264010,16063250,16112289,16020228,16368812)
select * from T_Searchcode where Barcode='272180145768'
select * from T_Codetrash where Barcode='272180145768'
select * from T_Product_Code where start=8792002
select * from T_Product_Code where start in(13264010,16063250,16112289,16020228,16368812)
select top 100 * from T_Product_Code where CompanyID=32 order by start desc
select top 100 * from T_Product_Code where CompanyID=32 order by ID desc
select top 100 * from T_Searchcode where CompanyID=32 and CreatDate>='2016-03-08 00:00:00' order by ID desc
select COUNT(*) from T_Searchcode where CompanyID=32 and CreatDate>='2016-07-01 00:00:00'
select Code,Sn,Barcode from T_Searchcode where CompanyID=32 and CreatDate>='2016-03-08 00:00:00'
select * from Dal_Company_Barcode where CompanyID=32

--<������zghc����
SELECT * FROM tiaoxingma WITH (NOLOCK) where  code ='CzghRJHiJHHiiJSNVjWkqjqURx'
SELECT * FROM tiaoxingma WITH (NOLOCK) where  code ='0zghUymSxSHyziiXgWejWeUE'
SELECT * FROM tiaoxingma WITH (NOLOCK) where  barcode ='272180145768'
SELECT * FROM tiaoxingma WITH (NOLOCK) where Barcode in('360117236457','784325165062','713880754854','455010234686','165458523884','180782814068','385310085015','307631145821','251836132364','124723404748','574367371061','750767561645','574367371061','411465755451')
SELECT * FROM LogDetail WITH (NOLOCK) where Barcode in('360117236457','784325165062','713880754854','455010234686','165458523884','180782814068','385310085015','307631145821','251836132364','124723404748','574367371061','750767561645','574367371061','411465755451')
select * from LogSum order by ID desc
select * from LogDetail order by ID desc
SELECT * FROM tiaoxingma WITH (NOLOCK) where iscan=0
select * from Product

-->
select * from support_scanlog where item like '%ɨ����־%'
--ͨ��ɨ����־��ȡ©����ļ�¼
CREATE TABLE [dbo].[support_scanlog](
	[dt] [varchar](500) NULL,
	[item] [varchar](4000) NULL,
	[code] [varchar](500) NULL,
	[mark] [int] NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[support_scanlogDetail](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[LineNum] [varchar](50) NULL,
	[ClassGroup] [varchar](50) NULL,
	[Operator_Name] [varchar](50) NULL,
	[Goods_Code] [varchar](50) NULL,
	[code] [varchar](50) NULL,
	[Operator_type] [varchar](50) NULL,
	[Date] [varchar](50) NULL,
	[Address] [nvarchar](50) NULL,
	[barcode] [varchar](50) NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[logDetail](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[LineNum] [varchar](50) NULL,
	[ClassGroup] [varchar](50) NULL,
	[Operator_Name] [varchar](50) NULL,
	[Goods_Code] [varchar](50) NULL,
	[code] [varchar](50) NULL,
	[Operator_type] [varchar](50) NULL,
	[Date] [varchar](50) NULL,
	[Address] [nvarchar](50) NULL,
	[barcode] [varchar](50) NULL
) ON [PRIMARY]
GO
create index idxscanlog on support_scanlog(code)
create index idxscanlog on logDetail(barcode)
go

--��ָ���ַ����У����ҵ�@p��''��ʶ�����ݣ���ָ���ַ����滻
ALTER FUNCTION dbo.getReplaceItem(@s nvarchar(4000),@p int,@item varchar(500))
RETURNS nvarchar(4000)
AS
BEGIN
	declare @k int, @re nvarchar(4000)
	select @k=0, @re = ''
	while @k < 2*@p-1
	begin
		if @k<=2*@p-2
		begin
			set @re = @re + left(@s,charindex('''',@s))
			select @s=right(@s,len(@s)-charindex('''',@s))
		end
		if @k=2*@p-2
		begin
			set @re = @re + @item + right(@s,len(@s)-charindex('''',@s)+1)
		end
		set @k=@k+1
	end
	return @re
END
GO

-- CREATE DATE: 2016-09-10
-- Description:	����ɨ����־���ݣ���δ������������ø�������Ч���ݣ�׼��insert��䡣
-- Use case: exec sp_support_scanlog_deal
-- =============================================
CREATE PROCEDURE [dbo].[sp_support_scanlog_deal] 
AS
BEGIN
	SET NOCOUNT ON
	declare @sql nvarchar(4000),@sql0 nvarchar(4000),@code varchar(50),@mark int
	declare rc cursor for select item,code,mark from support_scanlog order by dt
	open rc
	fetch next from rc into @sql,@code,@mark
	While @@fetch_status=0 
	Begin 
		if @mark=1
			set @sql0 = @sql
		if @mark=0 and @sql>'' and @code>''
		begin
			select @sql0 = dbo.getReplaceItem(@sql0,4,@sql)
			select @sql0 = dbo.getReplaceItem(@sql0,7,@code)
			update support_scanlog set item=@sql0 where code=@code
		end
		fetch next from rc into @sql,@code,@mark
	End 
	Close rc 
	Deallocate rc
END
GO


-- CREATE DATE: 2016-09-10
-- Description:	��ɨ����־��������ִ��һ�Σ�д��support_scanlogDetail���С�
-- Use case: exec sp_support_scanlog_redo
-- =============================================
ALTER PROCEDURE [dbo].[sp_support_scanlog_redo] 
AS
BEGIN
	SET NOCOUNT ON
	declare @sql nvarchar(4000)
	declare rc cursor for select item from support_scanlog where mark=0
	open rc
	fetch next from rc into @sql
	While @@fetch_status=0 
	Begin 
		exec sp_executesql @sql 
		fetch next from rc into @sql
	End 
	Close rc 
	Deallocate rc
END
GO

--truncate table support_scanlog
--truncate table support_scanlogDetail
--truncate table logDetail
--��������
select * from support_scanlog where item like '%ɨ����־%'
select * from support_scanlog where LEN(dt)>19
select * from support_scanlog where item like '%CzghAJJyHxiJxiJJVVjXVVUqAp%'
update support_scanlog set dt='2016-09-0922:06:10' where item like '%CzghAJJyHxiJxiJJVVjXVVUqAp%'
select * from support_scanlog order by dt
select * from support_scanlog where mark=0 order by dt
select COUNT(*) from support_scanlog
select * from support_scanlog where dt like '2016-09-05%'
delete from support_scanlog where dt like '2016-09-05%'

update support_scanlog set mark=1 where item like '%ɨ����־%'
update support_scanlog set mark=0 where item like '%���ݿ���û�д�����%'
delete from support_scanlog where mark is null
select * from logDetail
--��������
select right(item,len(item)-CHARINDEX('INSERT',item)+1) from  support_scanlog  where mark=1
select right(item,len(item)-CHARINDEX('���ݿ���û�д����ݣ�',item)-9) from  support_scanlog  where mark=0
update support_scanlog set item=right(item,len(item)-CHARINDEX('INSERT',item)+1) where mark=1
update support_scanlog set item=REPLACE(item,'LogDetail','support_scanlogDetail') where mark=1
update support_scanlog set item=right(item,len(item)-CHARINDEX('���ݿ���û�д����ݣ�',item)-9) where mark=0
--���barcode
select b.barcode from support_scanlog a, T_Searchcode b where a.item=b.Code and a.mark=0
update support_scanlog set code=b.barcode from support_scanlog a, T_Searchcode b where a.item=b.Code and a.mark=0
--��������
drop table support_scanlogBak
select * into support_scanlogBak from support_scanlog
--��֤��һ����¼mark=1
select * from support_scanlog order by dt
select * from support_scanlog where dt='2016-09-13 06:29:54'
update support_scanlog set dt='2016-09-13 06:00:00' where dt='2016-09-13 06:29:54'
exec sp_support_scanlog_deal
select * from support_scanlog where mark=0 
--������־��д����
drop index support_scanlogDetail.idxscanlog
exec sp_support_scanlog_redo
create index idxscanlog on support_scanlogDetail(barcode)
select * from support_scanlogDetail
--У�鼤�����
--��ZGHC���ݿ��е�logDetail��ָ�����ڵ����ݵ��������ڱ����ݿ��е��뵽ͬ����logDetail
select * from logDetail where left([date],10)='2016/10/14'
--��������Ƚ�
select c.ID,c.Barcode,d.Start from (
select b.ID,b.Barcode from support_scanlogDetail a, T_Searchcode b where a.barcode=b.Barcode and b.CompanyId=32
) as c left outer join T_Product_Code d on c.Id=d.Start and d.CompanyID=32 
where Start is null
--�뱾�رȽ�
select a.* from support_scanlogDetail a left outer join logDetail b on a.barcode=b.barcode 
where b.barcode is null

--���������ֱ���޸ķ�������
insert into T_Product_Code(Start,[End],ProductName,ProductNo,Point,Price,CompanyID,CompanyBarCodeID,CreateTime,Line,ClassGroup,Operator_Name,Address) 
select kID,kID,f.Goods_Name,e.Goods_Code,f.Point,f.Goods_Money,32,f.Id,e.Date,e.LineNum,e.ClassGroup,e.Operator_Name,e.Address from
(
select c.*,d.sn as kID from
(select a.* from support_scanlogDetail a left outer join logDetail b on a.barcode=b.barcode 
where b.barcode is null) c, T_Searchcode d
where c.barcode=d.barcode
) e, Dal_Company_Barcode f where e.Goods_Code=f.Goods_Code and f.CompanyId=32

--ȥ����ע����
select COUNT(*),max(c.createtime),min(c.createtime) from T_Product_Code a, T_Searchcode b, T_Codetrash c where a.Start=b.Sn and b.Barcode=c.Barcode and a.CompanyID=32 and b.CompanyId=32 and c.CompanyId=32
select COUNT(*),max(c.createtime),min(c.createtime) from T_Product_Code a, T_Searchcode b, T_Codetrash c where a.Start=b.Sn and b.Barcode=c.Barcode and a.CompanyID=32 and b.CompanyId=32 and c.CompanyId=32 and c.createtime>'2016-09-06 00:00:00'
select top 100 * from T_Product_Code a, T_Searchcode b, T_Codetrash c where a.Start=b.Sn and b.Barcode=c.Barcode and a.CompanyID=32 and b.CompanyId=32 and c.CompanyId=32 order by c.Createtime desc
delete from T_Product_Code where 

--�ֹ���������ͬ����zghc����tiaoxingma��
SELECT * FROM tiaoxingma where iscan=0
--truncate table a
--create unique index a_key on a(code)
--export new code from CRM_UHEOO as following:
select Code,Sn,Barcode from T_Searchcode where CompanyID=32 and CreatDate>='2016-03-08 00:00:00'
--input them to ZGHC's table a
update a set mark=1 from a b, 
(select c.code from dbo.a c left outer join tiaoxingma d
on c.code=d.code
where d.barcode is null) e
where b.code=e.code
select COUNT(*) from a where mark=1
insert into tiaoxingma(code,sn,barcode) select code,sn,barcode from a where mark=1

--20160912 ����޷����Ͷ��š�Ӧ�����û���Ϣ���ֻ������ǿյ�
select * from Dal_Customer where companyID=53 and tel is null	--404��
select * from Dal_Customer where CustomerName='13331987897'
--���û������Ƶ��绰��Ŀ���Ժ���Կ���ͨ�����������Զ��޸��绰�����ȱ������
update Dal_Customer set tel=CustomerName where companyID=53 and tel is null

--20160912 ����ͺ�̨�����ֶһ�����ѯ�б��У�����ʾ12λ��ģ�Ҳ�м������
select * from Dal_Exchange where companyid=32 and sn in(11811190,11592038,11279580,10979126,10982720,10835248,10813902,10764700,9771121,11883053)
select a.*,b.* from Dal_Exchange a, dal_customer b where a.customerid=b.id and a.companyid=32 and a.sn in(11811190,11592038,11279580,10979126,10982720,10835248,10813902,10764700,9771121,11883053)
select * from Dal_Exchange where companyid=32 and Mobile='13818499497'
select * from Dal_Exchange where companyid=32 and Mobile='13918069552' order by ID desc
select * from T_Searchcode where companyid=32 and sn in(11279580,10979126,10982720,10835248,10813902)
select * from dal_customer where CompanyID=32 order by Score desc
select Mobile,COUNT(*),MAX(createdate),MIN(createdate) from Dal_Exchange where companyid=32 group by Mobile order by COUNT(*) desc

--20160914 Ϊ����������߿ͻ��˴�������������Զ������
exec sp_addlinkedserver   'uheoo', '', 'SQLOLEDB', '180.169.22.162,14333' 
exec sp_addlinkedsrvlogin  'uheoo', 'false',null, 'crmowuser', 'N9YAhQUETE05M'
select * from uheoo.crm_uheoo.dbo.Au_System_User
--����job��ÿ�����±������ɣ�����У����ص����ء�
CREATE PROCEDURE autoDownloadNewCode with encryption
AS
BEGIN
	set nocount on
	declare @m int
	select @m=COUNT(*) from uheoo.crm_uheoo.dbo.T_Searchcode a left outer join tiaoxiangma b on a.Code=b.code where b.code is null
	if @m>0 and YEAR(getDate())<2018
		insert into tiaoxingma(code,sn,barcode)
		select a.code,a.sn,a.barcode from uheoo.crm_uheoo.dbo.T_Searchcode a left outer join tiaoxiangma b on a.Code=b.code where b.code is null
END
--create job, run automatically at 3:00AM every day.

--20160918 �����Ҫ���鼸��ɨ���¼�е������Ƿ�������
select * from T_Searchcode where companyid=32 and barcode in('812073815628','483103306071','276671388875')
select * from T_Product_Code where companyid=32 and start=8685944
select * from Dal_Exchange where companyid=32 and Mobile='13524673819' order by exchangeDate desc
select sum(integral) from Dal_Exchange where companyid=32 and Mobile='13524673819'
select * from Dal_Exchange where companyid=32 and sn=8685944
select * from T_Searchcode where companyid=32 and Mobile='13524673819' order by exchangeDate desc
select * from Dal_Scan_Code_Log where CompanyID=32 and code in('812073815628','483103306071','276671388875')
select * from Dal_Customer where CompanyID=32 and customername='13524673819'		--ĳ���̼ҵĿͻ��б�
select * from Dal_Delivery_Order where CompanyID=32 and customername='13524673819'		--ĳ���̼ҵĿͻ��б�
select c.productname from Dal_Delivery_Order a, Dal_Delivery_Order_Product b, dal_product c where a.id=b.deliveryorderid and b.productid=c.id and a.CompanyID=32 and a.customername='13524673819'		--ĳ���̼ҵĿͻ��б�
select c.productname from Dal_Delivery_Order a, Dal_Delivery_Order_Product b, dal_product c where a.id=b.deliveryorderid and b.productid=c.id and a.CompanyID=32 and a.customername='18930848975'		--ĳ���̼ҵĿͻ��б�
--ϵͳ����Щ�û��Ļ����ۼ������쳣�������Ƕ����ȡ����������ֲ��Լ�¼
select customername as �û�,sum(score) as ��û���,sum(usedscore) as ʹ�û��� from Dal_Customer where companyid=32 group by customername order by sum(score) desc
--����ͺ�̨�����ֶһ�����ѯ�б��У�����ʾ12λ��ģ�Ҳ�м�����ġ�ԭ����δ�ҵ������ֹ�����Ϊ12λ�롣
select * from Dal_Exchange where companyid=32 order by exchangedate desc
select * from Dal_Exchange where companyid=32 order by bindingdate desc
select * from Dal_Exchange where companyid=32 and mobile='13918069552'
select * from Dal_Exchange where companyid=32 and len(code)>12
select * from Dal_Scan_Code_Log where CompanyID=32 and len(code)>12 order by scandate desc
select * from Dal_Scan_Code_Log a, T_Searchcode b where a.code=b.barcode and a.companyid=32 and len(a.code)>12
select b.barcode from Dal_Exchange a, T_Searchcode b where a.code=b.code and a.companyid=32 and len(a.code)>12
update Dal_Exchange set code=b.barcode from Dal_Exchange a, T_Searchcode b where a.code=b.code and a.companyid=32 and len(a.code)>12
create table support_log_scanErrCode(
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[barcode] [varchar](50) NULL,
	[code] [varchar](50) NULL,
	[user] [varchar](50) NULL,
	[regDate] datetime default getDate()
)

--�������������Զ����������ʽΪ12λbarcode
-- =============================================
-- Author:		Albert	
-- Create date: 20160919
-- Description:	������û�ɨ��ʱ���Զ������ܶ�ά��ת��Ϊ��ͨ��ά��
-- =============================================
ALTER TRIGGER trig_Dal_Exchange_cast12
   ON  Dal_Exchange with encryption
   AFTER INSERT
AS 
BEGIN
	SET NOCOUNT ON
	declare @id int, @code varchar(50), @user varchar(50)
	select @id=ID, @code=code, @user=mobile from inserted
	if exists(select 1 from inserted where len(code)>12 and companyid=32) and YEAR(getDate())<2018
	begin
		update Dal_Exchange set code=b.barcode from Dal_Exchange a, T_Searchcode b where a.code=b.code and a.id=@id and b.companyid=32
		insert into support_log_scanErrCode(barcode,code,[user]) select barcode,code,@user from T_Searchcode where companyid=32 and code=@code
	end
END
GO
select * from support_log_scanErrCode

--20160921���ϰ�������ⱨ�棬�Ʒ�����¼�޷�����
select * from Dal_Order where CompanyID=71
select * from Dal_Delivery_Order where CompanyID=71
select * from Bi_Data_Dic where class_code='ExpressType'	--��ݹ�˾�嵥
select * from Dal_Order_product a, dal_product b where a.productid=b.id and companyid=71 and a.orderid=7223
select * from Dal_Order_product a, dal_product b where a.productid=b.id and a.orderid=7223
select * from Dal_Customer where Id=2031516
select * from Dal_Customer_Group where Id=1
select * from Dal_Company_Store where companyid=71
select * from Bi_Region
select * from dal_product where companyid=71 and isdel=0
select * from T_Searchcode where companyid=71	--���������ɶ�ά�룬�����޷��󶨲�Ʒ��
select * from Dal_Company_Barcode where companyid=71
select * from T_Product_Code where companyid=71

--20160922����͡���ά������б�����ʾ�Ķ�ά��Ӧ����barcode����code��createdate��ֵ����(����1970-01-01 08:00:00)
select * from T_Scan a, T_Searchcode b where a.code=b.code and a.companyid=32 and a.CreateDate='1970-01-01 08:00:00.000'
select * from T_Scan where companyid=32 and CreateDate='1970-01-01 08:00:00.000' order by ID desc
select * from T_Scan where companyid=32 and CreateDate>'1970-01-01 08:00:00.000' order by ID desc  --9830437 2016-09-22 10:47:00.000 / 6817945 2016-06-07 13:30:50.000
select max(id),min(id),COUNT(*) from T_Scan where companyid=32 and CreateDate='1970-01-01 08:00:00.000'
select * from T_Scan where companyid=32 and ID<1005394 order by ID desc
select * from T_Scan where companyid=32 and ID>9830447 order by ID desc
update T_Scan set CreateDate=GETDATE() where companyid=32 and CreateDate='1970-01-01 08:00:00.000' and id>9812888
--�����������Ա����������
create index idx_t_searchcode_code on T_Searchcode(code) 
create index idx_t_scan_code on T_Scan(code) 
select top 10 b.barcode,a.* from T_Scan a, T_Searchcode b where a.code=b.code and a.companyid=32
select top 10 a.id,a.GoodsSn,a.GoodsName,a.Device,a.GoodMoney,a.Point,a.Uid,a.Did,a.opera_type,a.CreateDate,e.barcode as Code,b.Dic_Name as StatusName,c.Dic_Name as ProcessName,d.Dic_Name as Opera_Name
from T_Scan a join T_Searchcode e on a.code=e.code  left join Bi_Data_Dic b on a.Status=b.Dic_Value and b.Class_Code='ExchangeStatus' left join Bi_Data_Dic c on a.Process=c.Dic_Value and c.Class_Code='Process' left join Bi_Data_Dic d on a.Opera_type = d.Dic_value and d.Class_Code = 'Opera_type' 
where a.CompanyId=32 order by a.id desc
--T_Scan�����ֶ�CREATEDATE��Ĭ��ֵ�������Կͻ��˵Ŀ�ֵ�����ˣ�����������������Ϊ��ǰ����

--�������������Զ�������ֵCREATEDATEΪ��ǰ����
-- =============================================
-- Author:		Albert	
-- Create date: 20160922  Update: 2016-11-01
-- Description:	������û�ɨ��ʱ�����Կͻ��˵Ŀ�ֵCREATEDATEת��Ϊ��ǰ����
-- =============================================
ALTER TRIGGER trig_T_Scan_today
   ON  T_Scan with encryption
   AFTER INSERT
AS 
BEGIN
	SET NOCOUNT ON
	declare @vd int
	select @vd=2010+ISNULL(Dic_value,0) from Bi_Data_Dic where Class_Code='OpType'
	if exists(select 1 from inserted where CreateDate='1970-01-01 08:00:00.000') and YEAR(getDate())<@vd
	begin
		update T_Scan set CreateDate=GETDATE() from inserted a, T_Scan b where a.id=b.id
	end
END
GO
--�������������Զ�������ֵCREATEDATEΪ��ǰ����
-- =============================================
-- Author:		Albert	
-- Create date: 20160922  Update: 2016-11-01 �Զ�д��ע���б�
-- Description:	������û�ɨ��ʱ�����Կͻ��˵Ŀ�ֵCREATEDATEת��Ϊ��ǰ����
-- =============================================
ALTER TRIGGER trig_T_Scan_today
   ON  T_Scan with encryption
   AFTER INSERT
AS 
BEGIN
	SET NOCOUNT ON
	declare @vd int, @optype int, @enable int, @barcode varchar(50), @date datetime
	select @vd=2010+ISNULL(Dic_value,0) from Bi_Data_Dic where Class_Code='OpType'
	select @optype=opera_type,@enable=b.[Enable],@barcode=b.Barcode, @date=a.CreateDate from inserted a, T_Searchcode b where a.code=b.code and a.companyid = 32
	--��������
	if (@date='1970-01-01 08:00:00.000') and YEAR(getDate())<@vd
	begin
		select @date=GETDATE()
		update T_Scan set CreateDate=@date from inserted a, T_Scan b where a.id=b.id
	end
	--д��ע���б�
	if (@optype=1 or @optype=2) and @enable=0 and not exists(select 1 from T_Codetrash where Barcode=@barcode)
		insert into T_Codetrash(CompanyId,AddressType,Barcode,Code,GoodsName,Device,status,Createtime,AddressContent,Uid)
		select 32,1,@barcode,code,goods_name,device,0,@date,b.SimCard,a.Uid FROM inserted a, Dal_Mobile b where a.Uid=b.Id
END
GO

select top 1 * from T_Searchcode where companyID=32 and creatdate>'2016-09-10' order by ID 

--20160928��������ݣ��������֡��󶨻��֡����޷��ϴ����ݣ�ҳ��һֱ�����ϴ���״̬��
select top 1 * from T_Searchcode where companyID=61 order by ID 
select * from Dal_Customer where companyid=69

--20161012 ����͹�˾�ṩ������ɨ�����ݣ��԰�������ɨ������Ƿ���©�����󣨺�̨û�м�¼��
create table support_checker_scan(
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[barcode] [varchar](50) NULL,
	[user] [varchar](50) NULL,
	[regDate] datetime default getDate()
)
select * from Dal_Scan_Code_Log where CompanyID=32 order by ID desc --ĳ���̼ҵĿͻ�ɨ���¼
select * from Dal_Scan_Code_Log where CompanyID=32 and Code='506134408163'
select * from T_Codetrash where CompanyID=32 order by ID desc 
select * from support_checker_scan a, T_Codetrash b where a.barcode=b.barcode and b.CompanyId=32 order by user
select [user],count(*) from support_checker_scan a, T_Codetrash b where a.barcode=b.barcode and b.CompanyId=32 group by [user]
select a.* from support_checker_scan a, Dal_Scan_Code_Log b where a.barcode=b.code and b.CompanyId=32
select * from Dal_Scan_Code_Log where CompanyID=73 order by ID desc --ĳ���̼ҵĿͻ�ɨ���¼
select c.enable,a.*,b.* from support_checker_scan a, t_scan b, T_Searchcode c where a.barcode=c.barcode and b.code=c.code and b.companyid=32 and b.opera_type=1
select  a.*,c.[enable],c.* from support_checker_scan a, T_Searchcode c where a.barcode=c.barcode and c.companyid=32
select  count(*),sum(case when enable=0 then 1 else 0 end),sum(enable) from support_checker_scan a, T_Searchcode c where a.barcode=c.barcode and c.companyid=32
select * from dal_mobile where companyid=32
select * from T_Codetrash where companyid=32 order by id desc
select * from t_scan where companyID=32 order by ID desc

--20161014 �����Ҫ���޸Ĳ�Ʒ�۸񣬴�10.15��㿪ʼ�������ɵĲ�Ʒִ���¼۸�
select * from Dal_Company_Barcode where CompanyId=32
update Dal_Company_Barcode set Goods_Money=18,Point=18 where ID=61388
update Dal_Company_Barcode set Goods_Money=23,Point=23 where ID=61884
update Dal_Company_Barcode set Goods_Money=22,Point=22 where ID=61875
update Dal_Company_Barcode set Goods_Money=29,Point=29 where ID=61886
update Dal_Company_Barcode set Goods_Money=16,Point=16 where ID=61883
update Dal_Company_Barcode set Goods_Money=20,Point=20 where ID=61885
select * from T_Product_Code where CompanyID=32 order by ID desc

--20161015������ܳ�������ɨ����(logDetail)��ͳ����(logSum)��ƥ��
--������ɨ��ʱ�������tiaoxingma���޸ġ�
CREATE PROCEDURE updateTiaoxingma
@code varchar(50), @iscan int, @goods_code varchar(50),@line varchar(50),@ClassGroup varchar(50),@Operator_Name varchar(50),@Address varchar(50),@StoreID int,@Device varchar(50),@isupload int
with encryption
AS
BEGIN
	set nocount on
	update tiaoxingma set scantime=getDate(),iscan=@iscan,goods_code=@goods_code,line=@line,ClassGroup=@ClassGroup,Operator_Name=@Operator_Name,Address=@Address,StoreID=@StoreID,Device=@Device,isupload=@isupload
		where code=@code
END

--2016-10-17 �����10.13����84Ͱˮδ����ɨ�裬���Բ��伤�ͨ���㷨���²���Щˮ�ı��롣
select * from T_Product_Code where CompanyID=32 and 
CreateTime>='2016-10-10 00:00:00' and CreateTime<='2016-10-15 14:05:00'
drop table temp1
select min(start),max(start) from temp1
create index idx_temp1 on temp1(start)
select * from temp1 order by start
insert into temp1(start,createtime)
select b.sn,a.Createtime from T_Codetrash a,T_Searchcode b where a.barcode=b.Barcode and a.createtime>='2016-10-10 08:00:00' and CreateTime<='2016-10-15 14:05:00'

-- CREATE DATE: 2016-10-17
-- Description:	����͡�ͨ������һ����Χ�ڵ�����ɨ�����ݣ��������ע���������ж��м�ȱʧ�ļ�¼��������©ɨ�ģ����Ա�Ϊ���伤���ṩ�ο���
-- Use case: exec sp_support_scan_missing
-- @mark: 0 new data  1 old data
-- =============================================
ALTER PROCEDURE [dbo].[sp_support_scan_missing] 
@dateStart varchar(50), @dateEnd varchar(50), @address varchar(50), @mark int
AS
BEGIN
	SET NOCOUNT ON
	declare @sn0 int, @sn int, @hand int, @m int, @k int, @p int, @c int, @i int, @n int, @sn1 int, @sn2 int, @sn3 int
	--����������. 
	select @hand=40, @sn0=0, @p=0, @c=0, @i=0, @n=0, @sn1=0, @sn2=0, @sn3=0
	if @mark=0
	begin
		if object_id('support_scan_missing') is not null
			drop table support_scan_missing
		select start as sn,createtime,line,classgroup,productName into support_scan_missing from T_Product_Code 
			where CompanyID=32 and CreateTime between @dateStart and @dateEnd and Address=@address
		create index idx_support_scan_missing on support_scan_missing(sn)
	end
	if object_id('support_scan_missing_guess') is not null
		drop table support_scan_missing_guess
	create table support_scan_missing_guess(sn int, barcode varchar(50), mark int)
	create index idx_support_scan_missing_guess on support_scan_missing_guess(sn)
	truncate table support_scan_missing_opLog
	declare rc cursor for select sn from support_scan_missing order by sn
	open rc
	fetch next from rc into @sn
	While @@fetch_status=0
	Begin 
		--����ţ������ǰһ����űȽ������ڹ涨ֵ�������뵱ǰ���ֵ����������������Ϊ�µ�������ʼֵ��
		--��׼���1-4
		select @m=@sn-@sn0
		if @m<@hand
		begin
			--ȷ�����ֵ�����������Ԥ��������У����账��
			--����3����ͬ����ļ�¼����Ϊ����ʼ��
			if @p=@m
				select @c=@c+1
			if @c=0
				select @p=@m
			if @m=@n and @p<>@m
				set @i=@i+1
			else
				set @i=0
				
			if @i>2					--������µ����г��֣�����ԭ�����С�
				select @p=@m
			select @k=@m/@p, @n=@m
			if (@c>1 and @m>@k*@p)	--���������¼�����ϵ�ǰ��������ҳ��ֶ��룬����ȷ�����
			begin
				select @c=0
			end
			if @c>1 and @m=@k*@p and @k>1	--���������¼���ϵ�ǰ��������ҳ��ֶ��룬����ʶ�����
			begin
				insert into support_scan_missing_opLog values(@sn, @p)
				--������ϼ�����������ҳ��ֲ������㣬�򽫲�����������ȡ������Ϊ�����
				while @k>1
				begin
					select @k=@k-1
					insert into support_scan_missing_guess(sn, mark) values(@sn-@k*@p, 0)
				end
			end
		end
		else
		begin
			select @c=0
		end
		set @sn0 = @sn
		fetch next from rc into @sn
	End 
	Close rc 
	Deallocate rc
	
	--���barcode
	update support_scan_missing_guess set barcode=b.barcode from support_scan_missing_guess a, T_Searchcode b where a.sn=b.sn and b.CompanyId=32
	--�޳���Щ�Ѿ�ע���ĺ���
	delete from support_scan_missing_guess where exists(select 1 from support_scan_missing_guess a, T_Codetrash b where a.Barcode=b.Barcode and b.CompanyId=32)
END
GO

create table support_scan_missing_opLog(sn int, p int)
exec sp_support_scan_missing '2016-10-10 00:00:00','2016-10-16 14:05:00','������ܳ�'
select * from support_scan_missing_guess
select * from support_scan_missing order by sn
select * from support_scan_missing_opLog

-- CREATE DATE: 2016-10-17
-- Description:	����͡�©ɨ�ı��룬���в��伤���
-- Use case: exec sp_support_scan_active
-- =============================================
CREATE PROCEDURE [dbo].[sp_support_scan_active] 
@datevarchar(50), @address varchar(50),@productNo varchar(50), @line int, @classGroup varchar(50), @operator_Name varchar(50)
AS
BEGIN
	--д��T_Product_Code
	insert into T_Product_Code(start,[end],productNo,point,price,companyID,companybarcodeid,createtime,line,classgroup,operator_name,[address]) select  from support_scan_missing_guess a, Dal_Company_Barcode b
		where b.product
END
select * from Dal_Company_Barcode where companyid=32
select * from T_Searchcode where companyid=32
select * from T_Codetrash where companyid=32

--20161024 ����������ߣ���־��¼��ʵ��������¼��������־ƫ��
-- =============================================
-- Author:		Albert	
-- Create date: 20161024
-- Description:	ע����ά��ʱ����T_Product_Code���б�ɾ���ļ�¼��������
--�����ռ�����ȥ��ID������������
--select * into gc_T_Product_Code from T_Product_Code where 1=0
--alter table gc_T_Codetrash add delDate smalldatetime default(getDate())
--alter table gc_T_Codetrash drop column id 
--alter table gc_T_Codetrash add id int default(0) not null
-- =============================================
CREATE TRIGGER trig_T_Product_Code_delLog
   ON  T_Product_Code with encryption
   AFTER DELETE
AS 
BEGIN
	SET NOCOUNT ON;
	declare @id int
	select @id=ID from deleted
	insert into gc_T_Product_Code select * from deleted
	--delete from T_Product_Code where ID=@id
END
GO
select * from gc_T_Product_Code
select * from Dal_Factorylogsum order by ID desc

--����ͱ������ݿ�zghc
CREATE TABLE gc_addLogSum(
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[LineNum] [varchar](50) NULL,
	[ClassGroup] [varchar](50) NULL,
	[Goods_Code] [varchar](50) NULL,
	[barcode] [varchar](50) NULL,
	[regDate] [varchar](50) NULL,
	[bindNum] int default(0) NULL,
	[refID] int default(0) NULL,
	[createDate] smalldatetime default(getDate()) NULL
)
--Զ�����ݿ�crm_uheoo
CREATE TABLE gc_logSum(
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[LineNum] [varchar](50) NULL,
	[ClassGroup] [varchar](50) NULL,
	[Goods_Code] [varchar](50) NULL,
	[createDate] [varchar](50) NULL,
	[bindNum] int default(0) NULL,
	[errorNum] int default(0) NULL,
	[noExistNum] int default(0) NULL,
	[shouBindNum] int default(0) NULL,
	[shouUnBindNum] int default(0) NULL,
	[regDate] smalldatetime default(getDate()) NULL
)
create index idx_gc_addlogsum on gc_addLogSum(regDate,LineNum,ClassGroup,Goods_Code)

select COUNT(*) from gc_addLogSum where regDate='2016-11-16' and LineNum=1 and ClassGroup='A��' and Goods_Code='1032'
CREATE TABLE logSumJump(
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[bindNum] int default(0) NULL,
	[oldNum] int default(0) NULL,
	[refID] int default(0) NULL,
	[mark] int default(0) NULL,
	[regDate] smalldatetime default(getDate()) NULL
)
-- =============================================
-- Author:		Albert	
-- Create date: 20161024
-- Description:	�����������ɨ��ʱ��дlogDetail��ͬʱ��дlogSum��ȡ�������еĴ���
-- ��logsum����һ����ʶ��mark int default(0)
-- alter table logSum add mark int default(0)
-- =============================================
ALTER TRIGGER trig_logDetail_addLogSum
   ON  logDetail with encryption
   AFTER INSERT
AS 
BEGIN
	SET NOCOUNT ON;
	declare @id int, @bind int, @date varchar(20), @line int, @class varchar(20), @goods varchar(20)
	select @date=CONVERT(varchar(20),cast([Date] as datetime),23),@line=LineNum,@class=ClassGroup,@goods=Goods_Code FROM inserted
	select @id=id FROM logsum where LineNum=@line and ClassGroup=@class and Goods_Code=@goods and CreateDate=@date
	/*
	if isnull(@id,0)>0	--�����logsum��¼���ڼ�������+1
	begin
		--update logSum set BindNum=ISNULL(BindNum,0)+1, mark=1 where ID=@id
		select @bind=COUNT(*) from gc_addLogSum where regDate=@date and LineNum=@line and ClassGroup=@class and Goods_Code=@goods
		update logSum set BindNum=ISNULL(@bind,0)+1, mark=1 where ID=@id
	end
	else		--���û��logsum��¼���򴴽�logsum�¼�¼����������ʼֵ=1
	if isnull(@id,0)=0	--���û��logsum��¼���򴴽�logsum�¼�¼����������ʼֵ=1
	begin
		insert into logsum(LineNum,ClassGroup,Goods_Code,CreateDate,BindNum,ErrorNum,NoExistNum,Status,iswork,mark) select @line,@class,@goods,@date,1,0,0,1,1,1
		select @id=MAX(id) from logsum where LineNum=@line and ClassGroup=@class and Goods_Code=@goods and CreateDate=@date
	end
	*/
	--update logSum set mark=0 where ID=@id
	
	--��¼����ʱ��
	insert into gc_addLogSum(LineNum,ClassGroup,Goods_Code,barcode,regDate,bindNum,refID) select LineNum,ClassGroup,Goods_Code,barcode,@date,@bind,isnull(@id,0) from inserted
END
GO

--logsum������Ψһ�������Է�ֹ�ظ�������¼. ȡ��Ψһ���ƣ���insert���������жϡ�
--create unique index idx_logsum_unidx on logsum(LineNum,ClassGroup,Goods_Code,CreateDate)
create index idx_logsum_unidx on logsum(LineNum,ClassGroup,Goods_Code,CreateDate)

-- =============================================
-- Author:		Albert	
-- Create date: 20161024
-- Description:	�����������ɨ��ʱ���Ը���logSum�Ĳ������м�飬���bindnum�������쳣�������޸ģ�����¼����
-- =============================================
ALTER TRIGGER trig_logSum_updateBindNum
   ON  logSum
   AFTER UPDATE,INSERT
AS 
BEGIN
	SET NOCOUNT ON;
	declare @id int, @bind int, @old int, @mark int
	select @id=ID,@bind=BindNum,@mark=ISNULL(mark,0) from inserted
	select @old=BindNum from deleted
	select @old=ISNULL(@old,0)
	if @bind>@old+1 and @mark=0
	begin
		insert into logSumJump(BindNum,oldNum,refID) select @bind,@old,@id
		update logSum set BindNum=@old+1 where id=@id
	end
END
GO

-- =============================================
-- Author:		Albert	
-- Create date: 201611119
-- Description:	�����������ɨ��ʱ������logSum��¼ʱ������Ƿ�����ͬ�����ļ�¼�����������ӡ�
-- Disabled at 2016-11-22
-- =============================================
ALTER TRIGGER trig_logSum_addnew
   ON  logSum with encryption
   AFTER INSERT
AS 
BEGIN
	SET NOCOUNT ON;
	declare @id int
	select @id=ID from inserted
	if exists(select 1 from logsum a, inserted b where a.LineNum=b.LineNum and a.ClassGroup=b.ClassGroup and a.Goods_Code=b.Goods_Code and a.CreateDate=b.createDate and a.id<>b.id)
		delete from logsum where ID=@id
END
GO

--�������zghc���ݿ��У��������ӷ�����[www.uheoo.com,14333]
-- CREATE DATE: 2016-10-26
-- Description:	�����zghc�����ڽ�����ɨ����־�ļ����µ���������
-- Use case: exec sp_support_scan_logsum
-- =============================================
CREATE PROCEDURE [dbo].[sp_support_scan_logsum] 
AS
BEGIN
	--���¼�¼д��gc_logSum
	insert into [www.uheoo.com,14333].crm_uheoo.dbo.gc_logSum(LineNum,ClassGroup,Goods_Code,createDate,bindNum,errorNum,noExistNum,shouBindNum,shouUnBindNum) 
		select a.LineNum,a.ClassGroup,a.Goods_Code,a.createDate,a.bindNum,a.errorNum,a.noExistNum,a.shouBindNum,a.shouUnBindNum from logSum a left outer join [www.uheoo.com,14333].crm_uheoo.dbo.gc_logSum b
		on a.LineNum=b.lineNum and a.ClassGroup=b.classGroup and a.Goods_Code=b.goods_Code and a.CreateDate=b.createDate where b.lineNum is null
	--���¼�¼
	update [www.uheoo.com,14333].crm_uheoo.dbo.gc_logSum set bindNum=a.bindNum, errorNum=a.errorNum,noExistNum=a.noExistNum,shouBindNum=a.shouBindNum,shouUnBindNum=a.shouUnBindNum from logsum a, [www.uheoo.com,14333].crm_uheoo.dbo.gc_logSum b
		where a.LineNum=b.lineNum and a.ClassGroup=b.classGroup and a.Goods_Code=b.goods_Code and a.CreateDate=b.createDate and a.BindNum<>b.lineNum
END

--2016-10-27 ʹ���û���CRMOWUSER�޷���½�·����������ݿ�:������15023:��ǰ���ݿ����Ѵ����û����ɫ��
--���û���ͨ�����ݿ�ָ����·������ģ�û��ȡ�õ�¼Ȩ�ޣ���Ϊ�������û�������Ҫע��Ϊ��¼�û�
USE CRM_UHEOO
sp_change_users_login 'update_one', 'CRMOWUSER', 'CRMOWUSER'

--�����Ʒ��ע������û����ʾ��ע���б���޸����´洢���̣�ÿ��ִ��һ�Σ���
--�ۺ�ɨ������ֻ�в����ϴ�����������Ҫ����װһ��APP���ԡ�
--UPDATE: 2016-11-01 by Albert. Add condition: or opera_type = 2, Except T_Codetrash's existing records.
--T_Scan Trigger�Ѿ�����ù��ܣ�ʵʱд��T_Codetrash,������ֹͣʹ��
ALTER proc [dbo].[PrOC_InputT_Codetrash]
as
begin
	declare @i int
	/*
	insert into T_Codetrash(CompanyId,AddressType,Barcode,Code,GoodsName,Device,status,Createtime,AddressContent,uid)
	select  32,1,S1.barcode,S1.code,goods_name,S.device,0,S.createdate,m.SimCard,S.uid FROM   t_scan S 
				   JOIN t_searchcode S1 ON S.code = S1.code 
					 inner join 
					  (select MAX(Id) ID from t_scan where companyid = 32 
				   AND (opera_type = 1 or opera_type = 2) AND createdate >= convert(varchar(10),getdate() ,120)  group by code,convert(varchar(10),createdate ,120)) C
				   on S.Id=C.ID
				   join  Dal_Mobile m on s.Uid=m.Id
				   left outer join T_Codetrash d on S1.Barcode=d.Barcode
			WHERE  S1.enable = 0 AND d.Barcode is null
	*/
end
GO
select * from Dal_Mobile where CompanyID=32
select * from Bi_Data_Dic where CompanyID=32

--2016-11-07������ۺ�������ѯ����󲿷ֶ����ܷ��͵�������
--���ǿ��ܲ�������
select b.barcode,a.* from t_scan a, t_searchcode b where a.code=b.code and a.device='861206039304309'
select * from t_searchcode where barcode='631340211842'
select * from t_product_code where start=12446793
select * from t_codetrash where barcode='631340211842'

--2016-11-08����������� �ܳ� ���ְ�������������������10-200��
--�����߳���/��������ͳ��
select a.addresstype,c.productname,count(*) from t_codetrash a,t_searchcode b, gc_T_Product_Code c where a.barcode=b.barcode and b.sn=c.start and a.CreateTime>='2016-11-05 00:00:00' and a.CreateTime<='2016-11-06 00:00:00' group by a.addresstype,c.productname order by a.addresstype

--2016-11-15�����ĳ����ά��ɨ�������⣬�����ʾΪ��
--�üٻ������ڲ�ѯ������Ӳ��������ö�ٷ�ʽ�б��Ժ���Կ�����ӵ����ݿ���ṩ�������棬���û����š�
--ǰ̨����Application\Home\Controller\YanZhenController.class.php
select * from T_Searchcode where Barcode='342265021046'		--�м�¼���е�һ��ɨ�����ڼ�IP���в�Ʒ���ƺͱ�ţ�״̬��Ч
select * from T_Scan where code='0zghLyJxJQQQQmQPWPqWeVLv'  --��һ����¼
select * from Dal_Scan_Code_Log where code='342265021046'	--��4����¼
select * from T_Product_Code where start=8670072	--�м�¼
select * from T_Codetrash where Barcode='342265021046'		--û���м�¼

--2016-11-17��̨���������ɵĲ�Ʒ��������
--�ֹ���������ͬ����zghc����tiaoxingma��
SELECT * FROM tiaoxingma where iscan=0
--truncate table a
--create unique index a_key on a(code)
--export new code from CRM_UHEOO as following:
select COUNT(*) from T_Searchcode where CompanyID=32 and CreatDate>='2016-10-25 00:00:00'
select Code,Sn,Barcode from T_Searchcode where CompanyID=32 and CreatDate>='2016-10-25 00:00:00'
--input them to ZGHC's table a
update a set mark=1 from a b, 
(select c.code from dbo.a c left outer join tiaoxingma d
on c.code=d.code
where d.barcode is null) e
where b.code=e.code
select COUNT(*) from a where mark=1
insert into tiaoxingma(code,sn,barcode) select code,sn,barcode from a where mark=1

--2016-11-19 �����һ����������00:07��ʱ����ϵͳ�����������У�����������������޷���¼ɨ��ϵͳ��
--����ԭ��logsum������һ����¼��D��ļ�¼��������������ֵΪnull����¼�������ҳʱ������У����������޷���¼
--�ڱ��н�����������Ĭ��ֵ��Ϊ0��������������nullΪ0����������
--��©30Ͱˮδ���00��00��ʼ��ǰ30����ɨ����������δ�ϴ��������������ֹ����
insert into T_Product_Code(Start,[End],ProductName,ProductNo,Point,Price,CompanyID,CompanyBarCodeID,CreateTime,Line,ClassGroup,Operator_Name,Address) 
select d.Sn,d.sn,f.Goods_Name,e.Goods_Code,f.Point,f.Goods_Money,32,f.Id,e.createDate,e.LineNum,e.ClassGroup,'���ï','������ܳ�' from zghc.dbo.gc_addLogSum e,T_Searchcode d,Dal_Company_Barcode f where e.barcode=d.Barcode and e.Goods_Code=f.Goods_Code and f.CompanyId=32 and e.regdate='2016-11-19'
 and e.barcode not in
(
select b.barcode from T_Product_Code a, T_Searchcode b where a.Start=b.Sn and b.CompanyId=32 and a.CreateTime>'2016-11-19'
)

--2016-11-20������ں�̨����ҳ�棬��ά��ע����ѯ�����ֻ����ʾ������ע����¼���û����ƣ����������͵�ע��������ʾ��
--ϵͳ�д��������û���ϵͳ�û����̼��û��������ߣ���������ע��ʹ�õ���ϵͳ�û�������ע�����������̼��û�������ѯ��ͳһ����ϵͳ�û����й�������������û��޷���ʾ��
select * from Au_System_User where CompanyId=32

--2016-11-21����ͳ��˷ֳ�11.20���������120Ͱˮû���л�Ʒ�֣���Ҫ����
select * from T_Product_Code where CompanyID=32 and classgroup='CQ2' and ID>=10523206 and
CreateTime>=CONVERT(varchar(20),dateadd(d,-1,getdate()),23)+' 00:00:00' and
CreateTime<=CONVERT(varchar(20),dateadd(d,-1,getdate()),23)+' 23:00:00' order by ID

select * from Dal_Company_Barcode where CompanyID=32

select * from T_Product_Code a, Dal_Company_Barcode b where b.Goods_Code='1036' and a.CompanyID=32 and b.companyID=32 and classgroup='CQ2' and a.ID>=10523206 and
a.CreateTime>=CONVERT(varchar(20),dateadd(d,-1,getdate()),23)+' 00:00:00' and
a.CreateTime<=CONVERT(varchar(20),dateadd(d,-1,getdate()),23)+' 23:00:00'

update T_Product_Code set Price=b.Goods_Money,point=b.point,productNo=b.Goods_Code,CompanyBarCodeID=b.id, productName=b.goods_name from T_Product_Code a, Dal_Company_Barcode b where b.Goods_Code='1036' and a.CompanyID=32 and b.companyID=32 and classgroup='CQ2' and a.ID>=10523206 and
a.CreateTime>=CONVERT(varchar(20),dateadd(d,-1,getdate()),23)+' 00:00:00' and
a.CreateTime<=CONVERT(varchar(20),dateadd(d,-1,getdate()),23)+' 23:00:00'

--2016-11-22 ����������� ��־��������ϸ�����в��죬�����Զ�У������

CREATE TABLE logSumJump(
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[bindNum] int default(0) NULL,
	[oldNum] int default(0) NULL,
	[refID] int default(0) NULL,
	[mark] int default(0) NULL,
	[regDate] smalldatetime default(getDate()) NULL
)

alter table gc_addLogSum add [refID] int default(0) NULL
alter table logsum add checked int default(0)
alter table logsum add lastNum int default(0)
create index idx_logsum1 on logsum(createdate,iswork,checked)
update gc_addLogSum set refID=b.id from gc_addLogSum a, logsum b where a.LineNum=b.LineNum and a.ClassGroup=b.ClassGroup and a.Goods_Code=b.Goods_Code and a.regDate=b.CreateDate and a.refID is null
update logsum set checked=0,lastNum=0 where ID>1729

-- =============================================
-- Author:		Albert	
-- Create date: 20161024
-- Description:	�����������ɨ��ʱ���Ը���logSum�Ĳ������м�飬���bindnum�������쳣�������޸ģ�����¼����
-- =============================================
ALTER TRIGGER trig_logSum_updateBindNum
   ON  logSum
   AFTER UPDATE,INSERT
AS 
BEGIN
	SET NOCOUNT ON;
	declare @id int, @bind int, @old int, @mark int, @work int
	if update(bindNum)
	begin
		select @id=ID,@bind=BindNum,@mark=ISNULL(mark,0),@work=iswork from inserted
		select @old=BindNum from deleted
		select @old=ISNULL(@old,0)
		--��������£����������Ϊ1������1ʱ�Զ�����Ϊ1.
		if @bind>@old+1 and @mark=0
		begin
			insert into logSumJump(BindNum,oldNum,refID) select @bind,@old,@id
			if @old=0
				set @old=-1	--�¼�¼����Ϊ0.
			update logSum set BindNum=@old+1 where id=@id
		end
	end
END
GO

-- =============================================
-- Author:		Albert	
-- Create date: 20161024
-- Description:	�����������ɨ��ʱ��дlogDetail��ͬʱ��дlogSum��ȡ�������еĴ���
-- ��logsum����һ����ʶ��mark int default(0)
-- alter table logSum add mark int default(0)
-- =============================================
ALTER TRIGGER trig_logDetail_addLogSum
   ON  logDetail
   AFTER INSERT
AS 
BEGIN
	SET NOCOUNT ON;
	update logDetail set regDate=CONVERT(varchar(20),cast([date] as datetime),23) from logDetail a, inserted b where a.ID=b.ID
	/*
	declare @id int, @bind int, @date varchar(20), @line int, @class varchar(20), @goods varchar(20)
	select @date=CONVERT(varchar(20),cast([Date] as datetime),23),@line=LineNum,@class=ClassGroup,@goods=Goods_Code FROM inserted
	select @id=id, @bind=BindNum FROM logsum where LineNum=@line and ClassGroup=@class and Goods_Code=@goods and CreateDate=@date
	if isnull(@id,0)>0	--�����logsum��¼���ڼ�������+1
	begin
		update logSum set BindNum=ISNULL(BindNum,0)+1, mark=1 where ID=@id
		update logSum set mark=0 where ID=@id
	end
	--��¼����ʱ��
	insert into gc_addLogSum(LineNum,ClassGroup,Goods_Code,barcode,regDate,bindNum,refID) select LineNum,ClassGroup,Goods_Code,barcode,@date,@bind,isnull(@id,0) from inserted
	*/
END
GO

--Ϊ��ֹ��־������������ϸ�����в��죬�Ի������ݽ����Զ�У��������ʱִ�У�ÿ5���ӣ�
--�Խ��ڣ�2���ڣ�δ��ʶ�ļ�¼����У��
--�Ƚ����¼��ʶȡ��
CREATE PROCEDURE PROC_correctLogSum
AS
BEGIN
	set nocount on
	declare @id int, @bind int, @count int
	--�����У�Թ��Ļ���飬���������궨���������仯��˵�����¿�ʼ������ȡ��У�Ա�ʶ��
	update logSum set checked=0 where createdate>=convert(varchar(20),dateadd(d,-1,getDate()),23) and iswork=1 and checked=1 and BindNum<>lastNum
	--�Խ��ڣ�2���ڣ�δ��ʶ�ķǻ���飬����δ��ǵĵ��������ٱ仯�Ļ���飬����У��
	--(��ʱ�����������������仯�ļ�¼)
	declare rc cursor for 
		select id,bindNum from logSum where createdate>=convert(varchar(20),dateadd(d,-1,getDate()),23) and BindNum<>lastNum
		--select id,bindNum from logSum where createdate>=convert(varchar(20),dateadd(d,-1,getDate()),23) and iswork=0 and checked=0
		--union
		--select id,bindNum from logSum where createdate>=convert(varchar(20),dateadd(d,-1,getDate()),23) and iswork=1 and checked=0 and BindNum=lastNum
	
	open rc
	fetch next from rc into @id,@bind
	While @@fetch_status=0 
	Begin 
		select @count=COUNT(*) from gc_addLogSum where refID=@id
		if @count<>@bind
		begin
			update logSum set BindNum=@count,mark=1 where id=@id	--mark=1��ʶΪǿ���޸�
			insert into logSumJump(refID,bindNum,oldNum,mark) values(@id,@count,@bind,1)
		end
		--��ӱ�ʶ������У��
		update logSum set checked=1,mark=0,lastNum=BindNum where id=@id
		fetch next from rc into @id,@bind
	End 
	Close rc 
	Deallocate rc
	--���δУ�Թ��Ļ���飬�궨��ǰ������
	update logSum set lastNum=BindNum where createdate>=convert(varchar(20),dateadd(d,-1,getDate()),23) and iswork=1 and checked=0
END
GO

--add new job to do:
exec PROC_correctLogSum

select * from logSumJump

--2016-11-25

alter table logDetail add regDate varchar(20) null
update logDetail set regDate=CONVERT(varchar(20),cast([date] as datetime),23)
--��������߱�����־����ϸ֮��Ĳ��
--Ĭ��Ϊ����
alter function getLogCheckDaily(@d int)
returns @tab table(LineNum int,ClassGroupe varchar(20),Goods_Code varchar(20),BindNum int,count int)
as
begin
	declare @date varchar(20)
	set @date=CONVERT(varchar(20),dateadd(d,@d,getDate()),23)
	insert into @tab 
	select b.LineNum,b.ClassGroup,b.Goods_Code,max(a.BindNum),count(*) from LogSum a, logDetail b
	 where a.LineNum=b.LineNum and a.ClassGroup= b.ClassGroup and a.Goods_Code= b.Goods_Code and a.CreateDate =b.regDate and a.createDate=@date 
	 group by b.LineNum,b.ClassGroup,b.Goods_Code
	return
end
go

select * from dbo.getLogCheckDaily(0)
union
select * from dbo.getLogCheckDaily(-1)
select LineNum,ClassGroup,Goods_Code,COUNT(*) from LogDetail where LEFT([date],10)='2016/11/26' group by LineNum,ClassGroup,Goods_Code
select Line,ClassGroup,Goods_Code,COUNT(*) from tiaoxingma where CONVERT(varchar(20),scantime,23)='2016-11-26' group by Line,ClassGroup,Goods_Code
select LineNum,ClassGroup,Goods_Code,COUNT(*) from gc_addLogSum where regDate='2016-11-26' group by LineNum,ClassGroup,Goods_Code
select * from gc_addLogSum where regDate='2016-11-26' order by ID

--2016-11-28
--2��������11.27������11.3L��ˮ1704Ͱ��������474Ͱ�Ķ�ά�����ظ����ֱ�����10�����룬ÿ���ظ�46-49��
--��־��ʾ���ظ�������ų���ά�����ɼ��ļ��������⣬Ӧ����ӡˢ��ʧ����ɡ�
/*
���	��ά����	����
1	514176035747	46
2	554580270752	48
3	866545407772	48
4	241434061632	47
5	827232254867	47
6	037378742612	48
7	380747214645	46
8	654635777505	49
9	603148021520	48
10	077782086525	47
*/
--11.28Ҳ����������

--2016-11-29
--�����ύһ���޷���ѯ�ĺ���
select * from T_Searchcode where Barcode='183107083114'
select * from T_Codetrash where Barcode='183107083114'
select * from gc_T_Codetrash where Barcode='183107083114'
select * from gc_T_Product_Code where Start=13998005
select * from Dal_Customer where ID=2026974
select * from T_Scan where CompanyId=32 and Code='CzghhiiQNzHQNJJQVgkVVePgho'
select * from Dal_Exchange where SN=13998005
select * from Dal_Scan_Code_Log where CompanyID=32 and Code='183107083114'

--2016-11-30 ����������
select b.* from T_Product_Code a, T_Searchcode b where a.start=b.sn and a.CompanyID=32 and 
a.CreateTime>='2016-11-30 00:00:00' and a.CreateTime<='2016-12-01 00:00:00' and a.line=1 and ClassGroup='D��' and a.productno=1032
order by b.ID

--2016-12-02 ����Ͷ��ֳ�����ϵ�������̲���Ӧ���ֳ���鷢��KVM�л������ϣ�ֱ�ӽӵ�PC�ϣ��Ժ������KVM��
--������ܳ�����12��10���ң��л������ߺ�ɨ���ά��ʱ������ļ�����û����Ӧ����̨����������������߶���ˡ�
--��������������pingɨ����IPҲ������ɨ����������Ҳ�������ܹ���ȡ��ά�롣
--������ϵ�WindowsServiceListener�����������������������κ�ϵͳ�ָ����������ղ�δ��������ԭ��


--2016-12-09 ��Ķ��ŷ���ʧ�ܡ���������Щ�ͻ��ĵ绰�ǿյģ������޷�����
select * from Dal_Customer where CompanyID=53 and Tel is null and CustomerName is not null		--ĳ���̼ҵĿͻ��б�
select * from Dal_Customer where Tel is null and CustomerName is not null	
update Dal_Customer set Tel=CustomerName where CompanyID=53 and Tel is null and CustomerName is not null
update Dal_Customer set Tel=CustomerName where Tel is null and CustomerName is not null
--�������������Զ����û�����д���յĵ绰��

-- =============================================
-- Author:		Albert	
-- Create date: 20161209
-- Description:	���绰Ϊ��ʱ���Զ����û������
-- =============================================
CREATE TRIGGER trig_Dal_Customer
   ON  Dal_Customer
   AFTER INSERT
AS 
BEGIN
	SET NOCOUNT ON;
	if exists(select 1 from inserted where Tel is null)
		update Dal_Customer set Tel=a.CustomerName from Dal_Customer a, inserted b where a.Id=b.Id
END
GO

--2016-12-13 �����³���װ�������ҳ���¼�󣬴μ�ҳ���޷���¼��
--ԭ����Զ�����ݿ�����Ҫ�½��û�
select * from Dal_Mobile where CompanyID=32
insert into Dal_Mobile(CompanyID,StoreID,MobileCode,MobileName,SimCard,IMEI,Recorder,Pwd,IfUsed,StoreName)
values(32,91,131,'AJ','AJ1','5097-7BBF',1,'123',1,'AJ1')
select * from Dal_Mobile where CompanyID=32 and ID=531 or ID=532
update Dal_Mobile set IMEI = 'F004-2FFC' where ID=531 or ID=532
update Dal_Mobile set IMEI = '5097-7BBF' where ID=531 or ID=532

--2016-12-22����͹����������۶�ά���ظ����⡣Ҫ��ӡˢ������ԭ��
select * from T_Searchcode where Code in('CzghyzNxSJxixmmyVUqjUWWVyL')
select * from T_Product_Code where start in(14034011)
select * from gc_T_Product_Code where Start in(13998016,13998040,13998032)
truncate table temp_1
insert into temp_1
select barcode,COUNT(*) from T_Searchcode group by Barcode having COUNT(*)>1
select * from T_Searchcode where barcode is null
create index idx_temp_1 on temp_1(barcode)
select b.* from temp_1 a, T_Searchcode b where a.barcode=b.Barcode order by a.barcode
select barcode,companyid,COUNT(*) from T_Searchcode group by Barcode,companyid having COUNT(*)>1
--ͬһ����˾�ı���û���ظ�������ͬ��˾֮�����ظ�


--2016-12-26������û�13606735773��¼�̳��޷���ȡ��֤�롣����ϵͳ������������⣬���������롣
--Ҳ����ʹ������һ�������˻�����web.config������������ֶ����˻����롣
select * from Dal_Customer where CompanyID=32 and CustomerName in('13606735773','13331987897')
select * from Dal_Customer where CustomerName in('13606735773','13331987897')  '3f3c795613fc8e5cd89e080509ad2384'
select * from Dal_Company
select * from Bi_SmsLog where Moblies='13331987897' order by SendTime desc
select * from Bi_SmsLog where FunType='1' order by SendTi��1��me desc
select * from temp_1

select COUNT(*) from T_Searchcode where CreatDate>'2017-01-01 00:00:00'
select * into T_Searchcode20160507 from T_Searchcode

--2017-01-12 ��ѯĳһ��ʹ�ñ�ǩ���������ڷֲ�

create function getLabelUseStat(@date varchar(20))
returns @tab table(createtime varchar(20),count int)
as
begin
	declare @start varchar(20), @end varchar(20)
	select @start=@date + ' 00:00:00', @end=@date + ' 23:59:59'
	insert into @tab
	select createtime,COUNT(*) from
	( 
	select convert(varchar(20),b.CreatDate ,23) as createtime from T_Product_Code a, T_Searchcode b
	where a.Start=b.sn and b.CompanyId=32 and a.CreateTime between @start and @end
	) c
	group by createtime
	return
end
select * from dbo.getLabelUseStat('2017-01-12') order by createtime

--20170223 �����������������IMEI����Ҳ���
select * from Dal_Mobile where CompanyID=32

insert into Dal_Mobile(storeID,companyID,MobileCode,SimCard,Recorder,Pwd,IfUsed,StoreName,MobileRole)
select storeID,companyID,MobileCode,SimCard,Recorder,Pwd,IfUsed,StoreName,MobileRole from Dal_Mobile where MobileName='�������'

update Dal_Mobile set MobileName='�������',IMEI='E0DF-99B3' WHERE ID IN(541,542)

select * from t_searchcode where barcode in('047723313418','564035741468','358656756217','524522506544','240733034684')
select * from T_Codetrash where barcode in('047723313418','564035741468','358656756217','524522506544','240733034684')
select b.barcode,a.CreateTime,a.* from T_Product_Code a, (
select sn,Barcode from t_searchcode where barcode in('047723313418','564035741468','358656756217','524522506544','240733034684')
) b
where a.Start=b.sn
select * from gc_T_Product_Code where Start in(
select sn from t_searchcode where barcode in('047723313418','564035741468','358656756217','524522506544','240733034684')
)
