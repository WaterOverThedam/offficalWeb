USE [TLGDB]
GO

/****** Object:  Table [dbo].[TLG_AffiliateInfo]    Script Date: 2020/1/17 9:54:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[TLG_AffiliateInfo](
	[Id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Phone] [nvarchar](50) NULL,
	[Email] [nvarchar](50) NULL,
	[AreaId] [int] NULL,
	[Address] [nvarchar](50) NULL,
	[LinkTime] [int] NULL,
	[CreateTime] [datetime] NULL CONSTRAINT [DF_CreateTime]  DEFAULT (getdate()),
	[Status] [int] NULL CONSTRAINT [df_status]  DEFAULT ((1)),
	[MailStatus] [int] NULL CONSTRAINT [DF_TLG_AffiliateInfo_MailStatus]  DEFAULT ((0)),
	[Search] [nvarchar](2000) NULL,
	[Remark] [nvarchar](4000) NULL,
	[Channel] [nvarchar](4000) NULL,
	[rec_phone] [varchar](20) NULL,
	[rec_name] [nvarchar](20) NULL,
	[isdelete] [int] NULL CONSTRAINT [df_isdelete]  DEFAULT ((0)),
	[FollowerID] [int] NULL CONSTRAINT [df_FolllowerID]  DEFAULT ((0)),
	[nextTime] [datetime] NULL,
	[updateTime] [datetime] NULL,
	[wechatName] [varchar](500) NULL,
	[dtMeetUp] [datetime] NULL,
	[dtSign] [datetime] NULL,
	[amtInvest] [nvarchar](1000) NULL,
 CONSTRAINT [PK_TLG_AFFILIATEINFO] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'1上午 2下午' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TLG_AffiliateInfo', @level2type=N'COLUMN',@level2name=N'LinkTime'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'1提交 2已处理 99作废' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TLG_AffiliateInfo', @level2type=N'COLUMN',@level2name=N'Status'
GO


USE [TLGDB]
GO
/****** Object:  StoredProcedure [dbo].[proc_addMaillist]    Script Date: 2020/1/17 10:08:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[proc_addMaillist]
as
if exists(select 1 from tlgdb.dbo.Fun_genenate_mailText())
begin
   declare @xh int =1
   declare @cmd nvarchar(4000)
   declare @num int
   select identity(int,1,1)xh,cast(id as varchar)id,mailTo,subject,replace(replace(body,'>','^>'),'<','^<')body,cast(type as varchar)type into # from tlgdb.dbo.Fun_genenate_mailText() 
   set @num = @@ROWCOUNT
   while @xh< = @num
   begin
     select @cmd='echo '+body+' >E:\Data\autoMail\maillist\'+mailTo+'#'+subject+'#'+id+'#'+TYPE+'.html' from  # where xh=@xh
     select @cmd
     exec master..xp_cmdshell @cmd ,no_output
     set @xh+=1
   end
   
   insert into mail_log(type,id)
   select 'TLG_FreeAppointment',id from dbo.TLG_FreeAppointment where mailStatus=0
   insert into mail_log(type,id)
   select 'TLG_AffiliateInfo',id from dbo.TLG_AffiliateInfo where isnull(mailStatus,0)=0
   
   update dbo.TLG_FreeAppointment SET mailStatus=1 where mailStatus=0
   update dbo.TLG_AffiliateInfo SET mailStatus=1 where isnull(mailStatus,0)=0
   drop table #

   
   exec master..xp_cmdshell 'E:\Data\autoMail\autoMailOnce.cmd' ,no_output 
end
 

 