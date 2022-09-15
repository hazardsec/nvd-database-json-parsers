-- REPLACE <db_name> WITH EXISTING DATABASE NAME
USE [<db_name>]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- REPLACE <db_owner> WITH OWNER NAME
-- REPLACE <table_name> WITH TARGET TABLE NAME
CREATE TABLE [<db_owner>.[<table_name>](
    [nvd_db_id] [bigint] IDENTITY(1,1) NOT NULL,
	[object_filename] [varchar](50) NULL,
	[object_download_datetime] [datetime] NULL,
	[item_cve_data_type] [varchar](50) NULL,
	[item_cve_data_format] [varchar](50) NULL,
	[item_cve_data_version] [numeric](4, 2) NULL,
	[item_cve_data_meta_id] [varchar](50) NULL,
	[item_cve_data_meta_assigner] [varchar](500) NULL,
	[item_cve_problemtype] [nvarchar](max) NULL,
	[item_cve_references] [nvarchar](max) NULL,
	[item_cve_primary_description] [varchar](max) NULL,
	[item_cve_description] [nvarchar](max) NULL,
	[item_configurations] [nvarchar](max) NULL,
	[item_impact] [nvarchar](max) NULL,
	[item_published_datetime] [datetime] NULL,
	[item_modified_datetime] [datetime] NULL,
	[impact_v3_exploitability_score] [numeric](4, 2) NULL,
	[impact_v3_impact_score] [numeric](4, 2) NULL,
	[impact_v3_version] [numeric](4, 2) NULL,
	[impact_v3_vector_string] [varchar](50) NULL,
	[impact_v3_attack_vector] [varchar](50) NULL,
	[impact_v3_attack_complexity] [varchar](50) NULL,
	[impact_v3_priveleges_required] [varchar](50) NULL,
	[impact_v3_user_interaction] [varchar](50) NULL,
	[impact_v3_scope] [varchar](50) NULL,
	[impact_v3_confidentiality_impact] [varchar](50) NULL,
	[impact_v3_integrity_impact] [varchar](50) NULL,
	[impact_v3_availability_impact] [varchar](50) NULL,
	[impact_v3_base_score] [numeric](4, 2) NULL,
	[impact_v3_base_severity] [varchar](50) NULL,
	[impact_v2_severity] [varchar](50) NULL,
	[impact_v2_exploitability_score] [numeric](4, 2) NULL,
	[impact_v2_impact_score] [numeric](4, 2) NULL,
	[impact_v2_obtain_all_privilege] [varchar](50) NULL,
	[impact_v2_obtain_user_privilege] [varchar](50) NULL,
	[impact_v2_obtain_other_privilege] [varchar](50) NULL,
	[impact_v2_user_interaction_required] [varchar](50) NULL,
	[impact_v2_version] [numeric](4, 2) NULL,
	[impact_v2_vector_string] [varchar](50) NULL,
	[impact_v2_access_vector] [varchar](50) NULL,
	[impact_v2_access_complexity] [varchar](50) NULL,
	[impact_v2_authentication] [varchar](50) NULL,
	[impact_v2_confidentiality_impact] [varchar](50) NULL,
	[impact_v2_integrity_impact] [varchar](50) NULL,
	[impact_v2_availability_impact] [varchar](50) NULL,
	[impact_v2_base_score] [numeric](4, 2) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO