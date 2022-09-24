--Dynamic Runtime Parameters [file_name_prefix, file_path, db_name, schema_name, import_table_name, target_table_name, history_table_name, incremental (1|0)]
USE [$(db_name)]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF (EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.TABLES 
                 WHERE TABLE_SCHEMA = '$(schema_name)' 
                 AND  TABLE_NAME = '$(import_table_name)'))
    BEGIN
        SET NOEXEC ON;
    END
        CREATE TABLE [$(schema_name)].[$(import_table_name)] (
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
            [impact_v3_privileges_required] [varchar](50) NULL,
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
            [impact_v2_ac_insuf_info] [varchar](50) NULL,
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
    SET NOEXEC OFF;    

-- CONDITIONALLY CREATE TARGET TABLE BASED ON PARAMS PASSED IN
IF (EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.TABLES 
                 WHERE TABLE_SCHEMA = '$(schema_name)' 
                 AND  TABLE_NAME = '$(target_table_name)'))
    BEGIN
        SET NOEXEC ON;
    END
        CREATE TABLE [$(schema_name)].[$(target_table_name)](
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
            [impact_v3_privileges_required] [varchar](50) NULL,
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
            [impact_v2_ac_insuf_info] [varchar](50) NULL,
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
    SET NOEXEC OFF;    

-- CONDITIONALLY CREATE HISTORY TABLE BASED ON PARAMS PASSED IN
IF (EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.TABLES 
                 WHERE TABLE_SCHEMA = '$(schema_name)' 
                 AND  TABLE_NAME = '$(history_table_name)'))
    BEGIN
        SET NOEXEC ON;
    END
        CREATE TABLE [$(schema_name)].[$(history_table_name)] (
            [nvd_db_history_id] [bigint] IDENTITY(1,1) NOT NULL,
            [nvd_db_id] [bigint] NULL,
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
            [impact_v3_privileges_required] [varchar](50) NULL,
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
            [impact_v2_ac_insuf_info] [varchar](50) NULL,
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
            [impact_v2_base_score] [numeric](4, 2) NULL,
            [nvd_db_import_datetime] [datetime] NULL
        ) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
        GO
        ALTER TABLE [$(schema_name)].[$(history_table_name)] ADD  CONSTRAINT [DF_$(history_table_name)_nvd_db_import_datetime]  DEFAULT (getdate()) FOR [nvd_db_import_datetime]
        GO
    SET NOEXEC OFF;    

DECLARE @query_truncate [nvarchar](MAX) = N'TRUNCATE TABLE [$(db_name)].[$(schema_name)].[$(import_table_name)];'

EXEC sp_executesql @query_truncate

-- IF INCREMENTAL UPDATE, DO NOT INSERT INTO HISTORY
IF $(incremental) = 1
    BEGIN
        SET NOEXEC ON;
    END
        INSERT INTO [$(schema_name)].[$(history_table_name)]
                ([nvd_db_id]
                ,[object_filename]
                ,[object_download_datetime]
                ,[item_cve_data_type]
                ,[item_cve_data_format]
                ,[item_cve_data_version]
                ,[item_cve_data_meta_id]
                ,[item_cve_data_meta_assigner]
                ,[item_cve_problemtype]
                ,[item_cve_references]
                ,[item_cve_primary_description]
                ,[item_cve_description]
                ,[item_configurations]
                ,[item_impact]
                ,[item_published_datetime]
                ,[item_modified_datetime]
                ,[impact_v3_exploitability_score]
                ,[impact_v3_impact_score]
                ,[impact_v3_version]
                ,[impact_v3_vector_string]
                ,[impact_v3_attack_vector]
                ,[impact_v3_attack_complexity]
                ,[impact_v3_privileges_required]
                ,[impact_v3_user_interaction]
                ,[impact_v3_scope]
                ,[impact_v3_confidentiality_impact]
                ,[impact_v3_integrity_impact]
                ,[impact_v3_availability_impact]
                ,[impact_v3_base_score]
                ,[impact_v3_base_severity]
                ,[impact_v2_severity]
                ,[impact_v2_exploitability_score]
                ,[impact_v2_impact_score]
                ,[impact_v2_ac_insuf_info]
                ,[impact_v2_obtain_all_privilege]
                ,[impact_v2_obtain_user_privilege]
                ,[impact_v2_obtain_other_privilege]
                ,[impact_v2_user_interaction_required]
                ,[impact_v2_version]
                ,[impact_v2_vector_string]
                ,[impact_v2_access_vector]
                ,[impact_v2_access_complexity]
                ,[impact_v2_authentication]
                ,[impact_v2_confidentiality_impact]
                ,[impact_v2_integrity_impact]
                ,[impact_v2_availability_impact]
                ,[impact_v2_base_score])
            SELECT * FROM $(target_table_name);
        GO    
    SET NOEXEC OFF;            

-- IF INCREMENTAL UPDATE, DO NOT RUN YEARLY IMPORTS
IF $(incremental) = 1
    BEGIN
        SET NOEXEC ON;
    END

    DECLARE @year int = 2002

    DECLARE @query_year_import nvarchar(MAX)
    DECLARE @query_year_import_part_1 nvarchar(MAX)
    DECLARE @query_year_import_part_2 nvarchar(MAX)
    DECLARE @query_year_import_part_3 nvarchar(MAX)

    WHILE @year <= YEAR(GETDATE())
        BEGIN
            SET @query_year_import_part_1 = N'INSERT INTO [$(db_name)].[$(schema_name)].[$(import_table_name)] (
                [object_filename]
                ,[object_download_datetime]
                    ,[item_cve_data_type]
                ,[item_cve_data_format]
                ,[item_cve_data_version]
                ,[item_cve_data_meta_id]
                ,[item_cve_data_meta_assigner]
                ,[item_cve_problemtype]
                ,[item_cve_references]
                    ,[item_cve_primary_description]
                ,[item_cve_description]
                ,[item_configurations]
                ,[item_impact]      
                ,[item_published_datetime]
                ,[item_modified_datetime]
                    ,[impact_v3_exploitability_score]
                ,[impact_v3_impact_score]
                ,[impact_v3_version]
                ,[impact_v3_vector_string]
                ,[impact_v3_attack_vector]
                ,[impact_v3_attack_complexity]
                ,[impact_v3_privileges_required]
                ,[impact_v3_user_interaction]
                ,[impact_v3_scope]
                ,[impact_v3_confidentiality_impact]
                ,[impact_v3_integrity_impact]
                ,[impact_v3_availability_impact]
                ,[impact_v3_base_score]
                ,[impact_v3_base_severity]
                ,[impact_v2_severity]
                ,[impact_v2_exploitability_score]
                ,[impact_v2_impact_score]
                ,[impact_v2_ac_insuf_info]
                ,[impact_v2_obtain_all_privilege]
                ,[impact_v2_obtain_user_privilege]
                ,[impact_v2_obtain_other_privilege]
                ,[impact_v2_user_interaction_required]
                ,[impact_v2_version]
                ,[impact_v2_vector_string]
                ,[impact_v2_access_vector]
                ,[impact_v2_access_complexity]
                ,[impact_v2_authentication]
                ,[impact_v2_confidentiality_impact]
                ,[impact_v2_integrity_impact]
                ,[impact_v2_availability_impact]
                ,[impact_v2_base_score]
                )
            SELECT ''$(file_name_prefix)' + CONVERT(char(4), @year) + '.json'' as [object_filename]
                ,REPLACE(REPLACE([object_download_datetime], ''Z'', ''''), ''T'', '' '')
                    ,[item_cve_data_type]
                ,[item_cve_data_format]
                ,[item_cve_data_version]
                ,[item_cve_data_meta_id]
                ,[item_cve_data_meta_assigner]
                ,[item_cve_problemtype]
                ,[item_cve_references]
                    ,[item_cve_primary_description]
                ,[item_cve_description]
                ,[item_configurations]
                ,[item_impact]
                ,REPLACE(REPLACE([item_published_datetime], ''Z'', ''''), ''T'', '' '')
                ,REPLACE(REPLACE([item_modified_datetime], ''Z'', ''''), ''T'', '' '')
                    ,[impact_v3_exploitability_score]
                ,[impact_v3_impact_score]
                ,[impact_v3_version]
                ,[impact_v3_vector_string]
                ,[impact_v3_attack_vector]
                ,[impact_v3_attack_complexity]
                ,[impact_v3_privileges_required]
                ,[impact_v3_user_interaction]
                ,[impact_v3_scope]
                ,[impact_v3_confidentiality_impact]
                ,[impact_v3_integrity_impact]
                ,[impact_v3_availability_impact]
                ,[impact_v3_base_score]
                ,[impact_v3_base_severity]
                ,[impact_v2_severity]
                ,[impact_v2_exploitability_score]
                ,[impact_v2_impact_score]
                ,[impact_v2_ac_insuf_info]
                ,[impact_v2_obtain_all_privilege]
                ,[impact_v2_obtain_user_privilege]
                ,[impact_v2_obtain_other_privilege] 
                '
            SET @query_year_import_part_2 = N' ,[impact_v2_user_interaction_required]
                ,[impact_v2_version]
                ,[impact_v2_vector_string]
                ,[impact_v2_access_vector]
                ,[impact_v2_access_complexity]
                ,[impact_v2_authentication]
                ,[impact_v2_confidentiality_impact]
                ,[impact_v2_integrity_impact]
                ,[impact_v2_availability_impact]
                ,[impact_v2_base_score] 
            FROM OPENROWSET (BULK ''$(file_path)$(file_name_prefix)' + CONVERT(char(4), @year) + '.json'', SINGLE_CLOB) as j
            CROSS APPLY OPENJSON(BulkColumn)
            WITH (
                [object_download_datetime] [nvarchar](50) ''$.CVE_data_timestamp''
                ,[cve_items] [nvarchar](MAX) ''$.CVE_Items'' AS JSON
            )
            OUTER APPLY OPENJSON(cve_items)
            WITH (
                [item_cve_data_type] [varchar](50) ''$.cve.data_type''
                ,[item_cve_data_format] [varchar](50) ''$.cve.data_format''
                ,[item_cve_data_version] [numeric](4, 2) ''$.cve.data_version''
                ,[item_cve_data_meta_id] [varchar](50) ''$.cve.CVE_data_meta.ID''
                ,[item_cve_data_meta_assigner] [varchar](500) ''$.cve.CVE_data_meta.ASSIGNER''
                ,[item_cve_problemtype] [nvarchar](MAX) ''$.cve.problemtype'' AS JSON
                ,[item_cve_references] [nvarchar](MAX) ''$.cve.references'' AS JSON
                ,[item_cve_primary_description] varchar(MAX) ''$.cve.description.description_data[0].value''
                ,[item_cve_description] [nvarchar](MAX) ''$.cve.description'' AS JSON
                ,[item_configurations] [nvarchar](MAX) ''$.configurations'' AS JSON
                ,[item_impact] [nvarchar](MAX) ''$.impact'' AS JSON
                ,[item_published_datetime] [nvarchar](50) ''$.publishedDate''
                ,[item_modified_datetime] [nvarchar](50) ''$.lastModifiedDate''
                ,[impact_v3_exploitability_score] [numeric](4, 2) ''$.impact.baseMetricV3.exploitabilityScore''
                ,[impact_v3_impact_score] [numeric](4, 2) ''$.impact.baseMetricV3.impactScore''
                ,[impact_v3_version] [numeric](4, 2) ''$.impact.baseMetricV3.cvssV3.version''
                ,[impact_v3_vector_string] [varchar](50) ''$.impact.baseMetricV3.cvssV3.vectorString''
                ,[impact_v3_attack_vector] [varchar](50) ''$.impact.baseMetricV3.cvssV3.attackVector''
                ,[impact_v3_attack_complexity] [varchar](50) ''$.impact.baseMetricV3.cvssV3.attackComplexity''
                ,[impact_v3_privileges_required] [varchar](50) ''$.impact.baseMetricV3.cvssV3.privilegesRequired''
                ,[impact_v3_user_interaction] [varchar](50) ''$.impact.baseMetricV3.cvssV3.userInteraction''
                ,[impact_v3_scope] [varchar](50) ''$.impact.baseMetricV3.cvssV3.scope''
                ,[impact_v3_confidentiality_impact] [varchar](50) ''$.impact.baseMetricV3.cvssV3.confidentialityImpact''
                ,[impact_v3_integrity_impact] [varchar](50) ''$.impact.baseMetricV3.cvssV3.integrityImpact''
                ,[impact_v3_availability_impact] [varchar](50) ''$.impact.baseMetricV3.cvssV3.availabilityImpact''
                ,[impact_v3_base_score] [numeric](4, 2) ''$.impact.baseMetricV3.cvssV3.baseScore''
                ,[impact_v3_base_severity] [varchar](50) ''$.impact.baseMetricV3.cvssV3.baseSeverity'' '
            SET @query_year_import_part_3 = N',[impact_v2_severity] [varchar](50) ''$.impact.baseMetricV2.severity''
                ,[impact_v2_exploitability_score] [numeric](4, 2) ''$.impact.baseMetricV2.exploitabilityScore''
                ,[impact_v2_impact_score] [numeric](4, 2) ''$.impact.baseMetricV2.impactScore''
                ,[impact_v2_ac_insuf_info] [bit] ''$.impact.baseMetricV2.acInsufInfo''
                ,[impact_v2_obtain_all_privilege] [bit] ''$.impact.baseMetricV2.obtainAllPrivilege''
                ,[impact_v2_obtain_user_privilege] [bit] ''$.impact.baseMetricV2.obtainUserPrivilege''
                ,[impact_v2_obtain_other_privilege] [bit] ''$.impact.baseMetricV2.obtainOtherPrivilege''
                ,[impact_v2_user_interaction_required] [bit] ''$.impact.baseMetricV2.userInteractionRequired''
                ,[impact_v2_version] [numeric](4, 2) ''$.impact.baseMetricV2.cvssV2.version''
                ,[impact_v2_vector_string] [varchar](50) ''$.impact.baseMetricV2.cvssV2.vectorString''
                ,[impact_v2_access_vector] [varchar](50) ''$.impact.baseMetricV2.cvssV2.accessVector''
                ,[impact_v2_access_complexity] [varchar](50) ''$.impact.baseMetricV2.cvssV2.accessComplexity''
                ,[impact_v2_authentication] [varchar](50) ''$.impact.baseMetricV2.cvssV2.authentication''
                ,[impact_v2_confidentiality_impact] [varchar](50) ''$.impact.baseMetricV2.cvssV2.confidentialityImpact''
                ,[impact_v2_integrity_impact] [varchar](50) ''$.impact.baseMetricV2.cvssV2.integrityImpact''
                ,[impact_v2_availability_impact] [varchar](50) ''$.impact.baseMetricV2.cvssV2.availabilityImpact''
                ,[impact_v2_base_score] [numeric](4, 2) ''$.impact.baseMetricV2.cvssV2.baseScore''
            )';
            SET @query_year_import = @query_year_import_part_1 + @query_year_import_part_2 + @query_year_import_part_3
            EXEC sp_executesql @query_year_import;        
            SET @year = @year + 1
        END
        GO

        MERGE [$(db_name)].[$(schema_name)].[$(target_table_name)] AS target_table
        USING [$(db_name)].[$(schema_name)].[$(import_table_name)] AS source_table
            ON target_table.item_cve_data_meta_id = source_table.item_cve_data_meta_id
        WHEN MATCHED THEN 
            UPDATE SET 
            target_table.object_filename = source_table.object_filename
            ,target_table.object_download_datetime = source_table.object_download_datetime
            ,target_table.item_cve_data_type = source_table.item_cve_data_type
            ,target_table.item_cve_data_format = source_table.item_cve_data_format
            ,target_table.item_cve_data_version = source_table.item_cve_data_version
            ,target_table.item_cve_data_meta_assigner = source_table.item_cve_data_meta_assigner
            ,target_table.item_cve_problemtype = source_table.item_cve_problemtype
            ,target_table.item_cve_references = source_table.item_cve_references
            ,target_table.item_cve_primary_description = source_table.item_cve_primary_description
            ,target_table.item_cve_description = source_table.item_cve_description
            ,target_table.item_impact = source_table.item_impact
            ,target_table.item_configurations = source_table.item_configurations
            ,target_table.item_published_datetime = source_table.item_published_datetime
            ,target_table.item_modified_datetime = source_table.item_modified_datetime
            ,target_table.impact_v3_exploitability_score = source_table.impact_v3_exploitability_score
            ,target_table.impact_v3_impact_score = source_table.impact_v3_impact_score
            ,target_table.impact_v3_version = source_table.impact_v3_version
            ,target_table.impact_v3_vector_string = source_table.impact_v3_vector_string
            ,target_table.impact_v3_attack_vector = source_table.impact_v3_attack_vector
            ,target_table.impact_v3_attack_complexity = source_table.impact_v3_attack_complexity
            ,target_table.impact_v3_privileges_required = source_table.impact_v3_privileges_required
            ,target_table.impact_v3_user_interaction = source_table.impact_v3_user_interaction
            ,target_table.impact_v3_scope = source_table.impact_v3_scope
            ,target_table.impact_v3_confidentiality_impact = source_table.impact_v3_confidentiality_impact
            ,target_table.impact_v3_integrity_impact = source_table.impact_v3_integrity_impact
            ,target_table.impact_v3_availability_impact = source_table.impact_v3_availability_impact
            ,target_table.impact_v3_base_score = source_table.impact_v3_base_score
            ,target_table.impact_v3_base_severity = source_table.impact_v3_base_severity
            ,target_table.impact_v2_severity = source_table.impact_v2_severity
            ,target_table.impact_v2_exploitability_score = source_table.impact_v2_exploitability_score
            ,target_table.impact_v2_impact_score = source_table.impact_v2_impact_score
            ,target_table.impact_v2_ac_insuf_info = source_table.impact_v2_ac_insuf_info
            ,target_table.impact_v2_obtain_all_privilege = source_table.impact_v2_obtain_all_privilege
            ,target_table.impact_v2_obtain_user_privilege = source_table.impact_v2_obtain_user_privilege
            ,target_table.impact_v2_obtain_other_privilege = source_table.impact_v2_obtain_other_privilege
            ,target_table.impact_v2_user_interaction_required = source_table.impact_v2_user_interaction_required
            ,target_table.impact_v2_version = source_table.impact_v2_version
            ,target_table.impact_v2_vector_string = source_table.impact_v2_vector_string
            ,target_table.impact_v2_access_vector = source_table.impact_v2_access_vector
            ,target_table.impact_v2_access_complexity = source_table.impact_v2_access_complexity
            ,target_table.impact_v2_authentication = source_table.impact_v2_authentication
            ,target_table.impact_v2_confidentiality_impact = source_table.impact_v2_confidentiality_impact
            ,target_table.impact_v2_integrity_impact = source_table.impact_v2_integrity_impact
            ,target_table.impact_v2_availability_impact = source_table.impact_v2_availability_impact
            ,target_table.impact_v2_base_score = source_table.impact_v2_base_score
        WHEN NOT MATCHED BY TARGET THEN INSERT (
            [object_filename]
            ,[object_download_datetime]
            ,[item_cve_data_type]
            ,[item_cve_data_format]
            ,[item_cve_data_version]
            ,[item_cve_data_meta_id]
            ,[item_cve_data_meta_assigner]
            ,[item_cve_problemtype]
            ,[item_cve_references]
            ,[item_cve_primary_description]
            ,[item_cve_description]
            ,[item_configurations]
            ,[item_impact]
            ,[item_published_datetime]
            ,[item_modified_datetime]
            ,[impact_v3_exploitability_score]
            ,[impact_v3_impact_score]
            ,[impact_v3_version]
            ,[impact_v3_vector_string]
            ,[impact_v3_attack_vector]
            ,[impact_v3_attack_complexity]
            ,[impact_v3_privileges_required]
            ,[impact_v3_user_interaction]
            ,[impact_v3_scope]
            ,[impact_v3_confidentiality_impact]
            ,[impact_v3_integrity_impact]
            ,[impact_v3_availability_impact]
            ,[impact_v3_base_score]
            ,[impact_v3_base_severity]
            ,[impact_v2_severity]
            ,[impact_v2_exploitability_score]
            ,[impact_v2_impact_score]
            ,[impact_v2_ac_insuf_info]
            ,[impact_v2_obtain_all_privilege]
            ,[impact_v2_obtain_user_privilege]
            ,[impact_v2_obtain_other_privilege]
            ,[impact_v2_user_interaction_required]
            ,[impact_v2_version]
            ,[impact_v2_vector_string]
            ,[impact_v2_access_vector]
            ,[impact_v2_access_complexity]
            ,[impact_v2_authentication]
            ,[impact_v2_confidentiality_impact]
            ,[impact_v2_integrity_impact]
            ,[impact_v2_availability_impact]
            ,[impact_v2_base_score]
        ) VALUES(
            [object_filename]
            ,[object_download_datetime]
            ,[item_cve_data_type]
            ,[item_cve_data_format]
            ,[item_cve_data_version]
            ,[item_cve_data_meta_id]
            ,[item_cve_data_meta_assigner]
            ,[item_cve_problemtype]
            ,[item_cve_references]
            ,[item_cve_primary_description]
            ,[item_cve_description]
            ,[item_configurations]
            ,[item_impact]
            ,[item_published_datetime]
            ,[item_modified_datetime]
            ,[impact_v3_exploitability_score]
            ,[impact_v3_impact_score]
            ,[impact_v3_version]
            ,[impact_v3_vector_string]
            ,[impact_v3_attack_vector]
            ,[impact_v3_attack_complexity]
            ,[impact_v3_privileges_required]
            ,[impact_v3_user_interaction]
            ,[impact_v3_scope]
            ,[impact_v3_confidentiality_impact]
            ,[impact_v3_integrity_impact]
            ,[impact_v3_availability_impact]
            ,[impact_v3_base_score]
            ,[impact_v3_base_severity]
            ,[impact_v2_severity]
            ,[impact_v2_exploitability_score]
            ,[impact_v2_impact_score]
            ,[impact_v2_ac_insuf_info]
            ,[impact_v2_obtain_all_privilege]
            ,[impact_v2_obtain_user_privilege]
            ,[impact_v2_obtain_other_privilege]
            ,[impact_v2_user_interaction_required]
            ,[impact_v2_version]
            ,[impact_v2_vector_string]
            ,[impact_v2_access_vector]
            ,[impact_v2_access_complexity]
            ,[impact_v2_authentication]
            ,[impact_v2_confidentiality_impact]
            ,[impact_v2_integrity_impact]
            ,[impact_v2_availability_impact]
            ,[impact_v2_base_score]
        )

        OUTPUT $ACTION, INSERTED.nvd_db_id, INSERTED.item_cve_data_meta_id;
        GO
    SET NOEXEC OFF;            

DECLARE @query_truncate_1 [nvarchar](MAX) = N'TRUNCATE TABLE [$(db_name)].[$(schema_name)].[$(import_table_name)];'

EXEC sp_executesql @query_truncate_1;

DECLARE @query_recent_import nvarchar(MAX)
DECLARE @query_recent_import_part_1 nvarchar(MAX)
DECLARE @query_recent_import_part_2 nvarchar(MAX)
DECLARE @query_recent_import_part_3 nvarchar(MAX)

SET @query_recent_import_part_1 = N'INSERT INTO [$(db_name)].[$(schema_name)].[$(import_table_name)] (
    [object_filename]
    ,[object_download_datetime]
        ,[item_cve_data_type]
    ,[item_cve_data_format]
    ,[item_cve_data_version]
    ,[item_cve_data_meta_id]
    ,[item_cve_data_meta_assigner]
    ,[item_cve_problemtype]
    ,[item_cve_references]
        ,[item_cve_primary_description]
    ,[item_cve_description]
    ,[item_configurations]
    ,[item_impact]      
    ,[item_published_datetime]
    ,[item_modified_datetime]
        ,[impact_v3_exploitability_score]
    ,[impact_v3_impact_score]
    ,[impact_v3_version]
    ,[impact_v3_vector_string]
    ,[impact_v3_attack_vector]
    ,[impact_v3_attack_complexity]
    ,[impact_v3_privileges_required]
    ,[impact_v3_user_interaction]
    ,[impact_v3_scope]
    ,[impact_v3_confidentiality_impact]
    ,[impact_v3_integrity_impact]
    ,[impact_v3_availability_impact]
    ,[impact_v3_base_score]
    ,[impact_v3_base_severity]
    ,[impact_v2_severity]
    ,[impact_v2_exploitability_score]
    ,[impact_v2_impact_score]
    ,[impact_v2_ac_insuf_info]
    ,[impact_v2_obtain_all_privilege]
    ,[impact_v2_obtain_user_privilege]
    ,[impact_v2_obtain_other_privilege]
    ,[impact_v2_user_interaction_required]
    ,[impact_v2_version]
    ,[impact_v2_vector_string]
    ,[impact_v2_access_vector]
    ,[impact_v2_access_complexity]
    ,[impact_v2_authentication]
    ,[impact_v2_confidentiality_impact]
    ,[impact_v2_integrity_impact]
    ,[impact_v2_availability_impact]
    ,[impact_v2_base_score]
    )
SELECT ''$(file_name_prefix)recent.json'' as [object_filename]
    ,REPLACE(REPLACE([object_download_datetime], ''Z'', ''''), ''T'', '' '')
        ,[item_cve_data_type]
    ,[item_cve_data_format]
    ,[item_cve_data_version]
    ,[item_cve_data_meta_id]
    ,[item_cve_data_meta_assigner]
    ,[item_cve_problemtype]
    ,[item_cve_references]
        ,[item_cve_primary_description]
    ,[item_cve_description]
    ,[item_configurations]
    ,[item_impact]
    ,REPLACE(REPLACE([item_published_datetime], ''Z'', ''''), ''T'', '' '')
    ,REPLACE(REPLACE([item_modified_datetime], ''Z'', ''''), ''T'', '' '')
        ,[impact_v3_exploitability_score]
    ,[impact_v3_impact_score]
    ,[impact_v3_version]
    ,[impact_v3_vector_string]
    ,[impact_v3_attack_vector]
    ,[impact_v3_attack_complexity]
    ,[impact_v3_privileges_required]
    ,[impact_v3_user_interaction]
    ,[impact_v3_scope]
    ,[impact_v3_confidentiality_impact]
    ,[impact_v3_integrity_impact]
    ,[impact_v3_availability_impact]
    ,[impact_v3_base_score]
    ,[impact_v3_base_severity]
    ,[impact_v2_severity]
    ,[impact_v2_exploitability_score]
    ,[impact_v2_impact_score]
    ,[impact_v2_ac_insuf_info]
    ,[impact_v2_obtain_all_privilege]
    ,[impact_v2_obtain_user_privilege]
    ,[impact_v2_obtain_other_privilege] 
    '
SET @query_recent_import_part_2 = N' ,[impact_v2_user_interaction_required]
    ,[impact_v2_version]
    ,[impact_v2_vector_string]
    ,[impact_v2_access_vector]
    ,[impact_v2_access_complexity]
    ,[impact_v2_authentication]
    ,[impact_v2_confidentiality_impact]
    ,[impact_v2_integrity_impact]
    ,[impact_v2_availability_impact]
    ,[impact_v2_base_score] 
FROM OPENROWSET (BULK ''$(file_path)$(file_name_prefix)recent.json'', SINGLE_CLOB) as j
CROSS APPLY OPENJSON(BulkColumn)
WITH (
    [object_download_datetime] [nvarchar](50) ''$.CVE_data_timestamp''
    ,[cve_items] [nvarchar](MAX) ''$.CVE_Items'' AS JSON
)
OUTER APPLY OPENJSON(cve_items)
WITH (
    [item_cve_data_type] [varchar](50) ''$.cve.data_type''
    ,[item_cve_data_format] [varchar](50) ''$.cve.data_format''
    ,[item_cve_data_version] [numeric](4, 2) ''$.cve.data_version''
    ,[item_cve_data_meta_id] [varchar](50) ''$.cve.CVE_data_meta.ID''
    ,[item_cve_data_meta_assigner] [varchar](500) ''$.cve.CVE_data_meta.ASSIGNER''
    ,[item_cve_problemtype] [nvarchar](MAX) ''$.cve.problemtype'' AS JSON
    ,[item_cve_references] [nvarchar](MAX) ''$.cve.references'' AS JSON
    ,[item_cve_primary_description] varchar(MAX) ''$.cve.description.description_data[0].value''
    ,[item_cve_description] [nvarchar](MAX) ''$.cve.description'' AS JSON
    ,[item_configurations] [nvarchar](MAX) ''$.configurations'' AS JSON
    ,[item_impact] [nvarchar](MAX) ''$.impact'' AS JSON
    ,[item_published_datetime] [nvarchar](50) ''$.publishedDate''
    ,[item_modified_datetime] [nvarchar](50) ''$.lastModifiedDate''
    ,[impact_v3_exploitability_score] [numeric](4, 2) ''$.impact.baseMetricV3.exploitabilityScore''
    ,[impact_v3_impact_score] [numeric](4, 2) ''$.impact.baseMetricV3.impactScore''
    ,[impact_v3_version] [numeric](4, 2) ''$.impact.baseMetricV3.cvssV3.version''
    ,[impact_v3_vector_string] [varchar](50) ''$.impact.baseMetricV3.cvssV3.vectorString''
    ,[impact_v3_attack_vector] [varchar](50) ''$.impact.baseMetricV3.cvssV3.attackVector''
    ,[impact_v3_attack_complexity] [varchar](50) ''$.impact.baseMetricV3.cvssV3.attackComplexity''
    ,[impact_v3_privileges_required] [varchar](50) ''$.impact.baseMetricV3.cvssV3.privilegesRequired''
    ,[impact_v3_user_interaction] [varchar](50) ''$.impact.baseMetricV3.cvssV3.userInteraction''
    ,[impact_v3_scope] [varchar](50) ''$.impact.baseMetricV3.cvssV3.scope''
    ,[impact_v3_confidentiality_impact] [varchar](50) ''$.impact.baseMetricV3.cvssV3.confidentialityImpact''
    ,[impact_v3_integrity_impact] [varchar](50) ''$.impact.baseMetricV3.cvssV3.integrityImpact''
    ,[impact_v3_availability_impact] [varchar](50) ''$.impact.baseMetricV3.cvssV3.availabilityImpact''
    ,[impact_v3_base_score] [numeric](4, 2) ''$.impact.baseMetricV3.cvssV3.baseScore''
    ,[impact_v3_base_severity] [varchar](50) ''$.impact.baseMetricV3.cvssV3.baseSeverity'' '
SET @query_recent_import_part_3 = N',[impact_v2_severity] [varchar](50) ''$.impact.baseMetricV2.severity''
    ,[impact_v2_exploitability_score] [numeric](4, 2) ''$.impact.baseMetricV2.exploitabilityScore''
    ,[impact_v2_impact_score] [numeric](4, 2) ''$.impact.baseMetricV2.impactScore''
    ,[impact_v2_ac_insuf_info] [bit] ''$.impact.baseMetricV2.acInsufInfo''
    ,[impact_v2_obtain_all_privilege] [bit] ''$.impact.baseMetricV2.obtainAllPrivilege''
    ,[impact_v2_obtain_user_privilege] [bit] ''$.impact.baseMetricV2.obtainUserPrivilege''
    ,[impact_v2_obtain_other_privilege] [bit] ''$.impact.baseMetricV2.obtainOtherPrivilege''
    ,[impact_v2_user_interaction_required] [bit] ''$.impact.baseMetricV2.userInteractionRequired''
    ,[impact_v2_version] [numeric](4, 2) ''$.impact.baseMetricV2.cvssV2.version''
    ,[impact_v2_vector_string] [varchar](50) ''$.impact.baseMetricV2.cvssV2.vectorString''
    ,[impact_v2_access_vector] [varchar](50) ''$.impact.baseMetricV2.cvssV2.accessVector''
    ,[impact_v2_access_complexity] [varchar](50) ''$.impact.baseMetricV2.cvssV2.accessComplexity''
    ,[impact_v2_authentication] [varchar](50) ''$.impact.baseMetricV2.cvssV2.authentication''
    ,[impact_v2_confidentiality_impact] [varchar](50) ''$.impact.baseMetricV2.cvssV2.confidentialityImpact''
    ,[impact_v2_integrity_impact] [varchar](50) ''$.impact.baseMetricV2.cvssV2.integrityImpact''
    ,[impact_v2_availability_impact] [varchar](50) ''$.impact.baseMetricV2.cvssV2.availabilityImpact''
    ,[impact_v2_base_score] [numeric](4, 2) ''$.impact.baseMetricV2.cvssV2.baseScore''
)';
SET @query_recent_import = @query_recent_import_part_1 + @query_recent_import_part_2 + @query_recent_import_part_3
EXEC sp_executesql @query_recent_import;        

MERGE [$(db_name)].[$(schema_name)].[$(target_table_name)] AS target_table
USING [$(db_name)].[$(schema_name)].[$(import_table_name)] AS source_table
    ON target_table.item_cve_data_meta_id = source_table.item_cve_data_meta_id
WHEN MATCHED THEN 
    UPDATE SET 
    target_table.object_filename = source_table.object_filename
    ,target_table.object_download_datetime = source_table.object_download_datetime
    ,target_table.item_cve_data_type = source_table.item_cve_data_type
    ,target_table.item_cve_data_format = source_table.item_cve_data_format
    ,target_table.item_cve_data_version = source_table.item_cve_data_version
    ,target_table.item_cve_data_meta_assigner = source_table.item_cve_data_meta_assigner
    ,target_table.item_cve_problemtype = source_table.item_cve_problemtype
    ,target_table.item_cve_references = source_table.item_cve_references
    ,target_table.item_cve_primary_description = source_table.item_cve_primary_description
    ,target_table.item_cve_description = source_table.item_cve_description
    ,target_table.item_impact = source_table.item_impact
    ,target_table.item_configurations = source_table.item_configurations
    ,target_table.item_published_datetime = source_table.item_published_datetime
    ,target_table.item_modified_datetime = source_table.item_modified_datetime
    ,target_table.impact_v3_exploitability_score = source_table.impact_v3_exploitability_score
    ,target_table.impact_v3_impact_score = source_table.impact_v3_impact_score
    ,target_table.impact_v3_version = source_table.impact_v3_version
    ,target_table.impact_v3_vector_string = source_table.impact_v3_vector_string
    ,target_table.impact_v3_attack_vector = source_table.impact_v3_attack_vector
    ,target_table.impact_v3_attack_complexity = source_table.impact_v3_attack_complexity
    ,target_table.impact_v3_privileges_required = source_table.impact_v3_privileges_required
    ,target_table.impact_v3_user_interaction = source_table.impact_v3_user_interaction
    ,target_table.impact_v3_scope = source_table.impact_v3_scope
    ,target_table.impact_v3_confidentiality_impact = source_table.impact_v3_confidentiality_impact
    ,target_table.impact_v3_integrity_impact = source_table.impact_v3_integrity_impact
    ,target_table.impact_v3_availability_impact = source_table.impact_v3_availability_impact
    ,target_table.impact_v3_base_score = source_table.impact_v3_base_score
    ,target_table.impact_v3_base_severity = source_table.impact_v3_base_severity
    ,target_table.impact_v2_severity = source_table.impact_v2_severity
    ,target_table.impact_v2_exploitability_score = source_table.impact_v2_exploitability_score
    ,target_table.impact_v2_impact_score = source_table.impact_v2_impact_score
    ,target_table.impact_v2_ac_insuf_info = source_table.impact_v2_ac_insuf_info
    ,target_table.impact_v2_obtain_all_privilege = source_table.impact_v2_obtain_all_privilege
    ,target_table.impact_v2_obtain_user_privilege = source_table.impact_v2_obtain_user_privilege
    ,target_table.impact_v2_obtain_other_privilege = source_table.impact_v2_obtain_other_privilege
    ,target_table.impact_v2_user_interaction_required = source_table.impact_v2_user_interaction_required
    ,target_table.impact_v2_version = source_table.impact_v2_version
    ,target_table.impact_v2_vector_string = source_table.impact_v2_vector_string
    ,target_table.impact_v2_access_vector = source_table.impact_v2_access_vector
    ,target_table.impact_v2_access_complexity = source_table.impact_v2_access_complexity
    ,target_table.impact_v2_authentication = source_table.impact_v2_authentication
    ,target_table.impact_v2_confidentiality_impact = source_table.impact_v2_confidentiality_impact
    ,target_table.impact_v2_integrity_impact = source_table.impact_v2_integrity_impact
    ,target_table.impact_v2_availability_impact = source_table.impact_v2_availability_impact
    ,target_table.impact_v2_base_score = source_table.impact_v2_base_score
WHEN NOT MATCHED BY TARGET THEN INSERT (
    [object_filename]
    ,[object_download_datetime]
    ,[item_cve_data_type]
    ,[item_cve_data_format]
    ,[item_cve_data_version]
    ,[item_cve_data_meta_id]
    ,[item_cve_data_meta_assigner]
    ,[item_cve_problemtype]
    ,[item_cve_references]
    ,[item_cve_primary_description]
    ,[item_cve_description]
    ,[item_configurations]
    ,[item_impact]
    ,[item_published_datetime]
    ,[item_modified_datetime]
    ,[impact_v3_exploitability_score]
    ,[impact_v3_impact_score]
    ,[impact_v3_version]
    ,[impact_v3_vector_string]
    ,[impact_v3_attack_vector]
    ,[impact_v3_attack_complexity]
    ,[impact_v3_privileges_required]
    ,[impact_v3_user_interaction]
    ,[impact_v3_scope]
    ,[impact_v3_confidentiality_impact]
    ,[impact_v3_integrity_impact]
    ,[impact_v3_availability_impact]
    ,[impact_v3_base_score]
    ,[impact_v3_base_severity]
    ,[impact_v2_severity]
    ,[impact_v2_exploitability_score]
    ,[impact_v2_impact_score]
    ,[impact_v2_ac_insuf_info]
    ,[impact_v2_obtain_all_privilege]
    ,[impact_v2_obtain_user_privilege]
    ,[impact_v2_obtain_other_privilege]
    ,[impact_v2_user_interaction_required]
    ,[impact_v2_version]
    ,[impact_v2_vector_string]
    ,[impact_v2_access_vector]
    ,[impact_v2_access_complexity]
    ,[impact_v2_authentication]
    ,[impact_v2_confidentiality_impact]
    ,[impact_v2_integrity_impact]
    ,[impact_v2_availability_impact]
    ,[impact_v2_base_score]
) VALUES(
    [object_filename]
    ,[object_download_datetime]
    ,[item_cve_data_type]
    ,[item_cve_data_format]
    ,[item_cve_data_version]
    ,[item_cve_data_meta_id]
    ,[item_cve_data_meta_assigner]
    ,[item_cve_problemtype]
    ,[item_cve_references]
    ,[item_cve_primary_description]
    ,[item_cve_description]
    ,[item_configurations]
    ,[item_impact]
    ,[item_published_datetime]
    ,[item_modified_datetime]
    ,[impact_v3_exploitability_score]
    ,[impact_v3_impact_score]
    ,[impact_v3_version]
    ,[impact_v3_vector_string]
    ,[impact_v3_attack_vector]
    ,[impact_v3_attack_complexity]
    ,[impact_v3_privileges_required]
    ,[impact_v3_user_interaction]
    ,[impact_v3_scope]
    ,[impact_v3_confidentiality_impact]
    ,[impact_v3_integrity_impact]
    ,[impact_v3_availability_impact]
    ,[impact_v3_base_score]
    ,[impact_v3_base_severity]
    ,[impact_v2_severity]
    ,[impact_v2_exploitability_score]
    ,[impact_v2_impact_score]
    ,[impact_v2_ac_insuf_info]
    ,[impact_v2_obtain_all_privilege]
    ,[impact_v2_obtain_user_privilege]
    ,[impact_v2_obtain_other_privilege]
    ,[impact_v2_user_interaction_required]
    ,[impact_v2_version]
    ,[impact_v2_vector_string]
    ,[impact_v2_access_vector]
    ,[impact_v2_access_complexity]
    ,[impact_v2_authentication]
    ,[impact_v2_confidentiality_impact]
    ,[impact_v2_integrity_impact]
    ,[impact_v2_availability_impact]
    ,[impact_v2_base_score]
)

OUTPUT $ACTION, INSERTED.nvd_db_id, INSERTED.item_cve_data_meta_id;
GO

DECLARE @query_truncate_2 [nvarchar](MAX) = N'TRUNCATE TABLE [$(db_name)].[$(schema_name)].[$(import_table_name)];'

EXEC sp_executesql @query_truncate_2;

DECLARE @query_modified_import nvarchar(MAX)
DECLARE @query_modified_import_part_1 nvarchar(MAX)
DECLARE @query_modified_import_part_2 nvarchar(MAX)
DECLARE @query_modified_import_part_3 nvarchar(MAX)

SET @query_modified_import_part_1 = N'INSERT INTO [$(db_name)].[$(schema_name)].[$(import_table_name)] (
    [object_filename]
    ,[object_download_datetime]
        ,[item_cve_data_type]
    ,[item_cve_data_format]
    ,[item_cve_data_version]
    ,[item_cve_data_meta_id]
    ,[item_cve_data_meta_assigner]
    ,[item_cve_problemtype]
    ,[item_cve_references]
        ,[item_cve_primary_description]
    ,[item_cve_description]
    ,[item_configurations]
    ,[item_impact]      
    ,[item_published_datetime]
    ,[item_modified_datetime]
        ,[impact_v3_exploitability_score]
    ,[impact_v3_impact_score]
    ,[impact_v3_version]
    ,[impact_v3_vector_string]
    ,[impact_v3_attack_vector]
    ,[impact_v3_attack_complexity]
    ,[impact_v3_privileges_required]
    ,[impact_v3_user_interaction]
    ,[impact_v3_scope]
    ,[impact_v3_confidentiality_impact]
    ,[impact_v3_integrity_impact]
    ,[impact_v3_availability_impact]
    ,[impact_v3_base_score]
    ,[impact_v3_base_severity]
    ,[impact_v2_severity]
    ,[impact_v2_exploitability_score]
    ,[impact_v2_impact_score]
    ,[impact_v2_ac_insuf_info]
    ,[impact_v2_obtain_all_privilege]
    ,[impact_v2_obtain_user_privilege]
    ,[impact_v2_obtain_other_privilege]
    ,[impact_v2_user_interaction_required]
    ,[impact_v2_version]
    ,[impact_v2_vector_string]
    ,[impact_v2_access_vector]
    ,[impact_v2_access_complexity]
    ,[impact_v2_authentication]
    ,[impact_v2_confidentiality_impact]
    ,[impact_v2_integrity_impact]
    ,[impact_v2_availability_impact]
    ,[impact_v2_base_score]
    )
SELECT ''$(file_name_prefix)modified.json'' as [object_filename]
    ,REPLACE(REPLACE([object_download_datetime], ''Z'', ''''), ''T'', '' '')
        ,[item_cve_data_type]
    ,[item_cve_data_format]
    ,[item_cve_data_version]
    ,[item_cve_data_meta_id]
    ,[item_cve_data_meta_assigner]
    ,[item_cve_problemtype]
    ,[item_cve_references]
        ,[item_cve_primary_description]
    ,[item_cve_description]
    ,[item_configurations]
    ,[item_impact]
    ,REPLACE(REPLACE([item_published_datetime], ''Z'', ''''), ''T'', '' '')
    ,REPLACE(REPLACE([item_modified_datetime], ''Z'', ''''), ''T'', '' '')
        ,[impact_v3_exploitability_score]
    ,[impact_v3_impact_score]
    ,[impact_v3_version]
    ,[impact_v3_vector_string]
    ,[impact_v3_attack_vector]
    ,[impact_v3_attack_complexity]
    ,[impact_v3_privileges_required]
    ,[impact_v3_user_interaction]
    ,[impact_v3_scope]
    ,[impact_v3_confidentiality_impact]
    ,[impact_v3_integrity_impact]
    ,[impact_v3_availability_impact]
    ,[impact_v3_base_score]
    ,[impact_v3_base_severity]
    ,[impact_v2_severity]
    ,[impact_v2_exploitability_score]
    ,[impact_v2_impact_score]
    ,[impact_v2_ac_insuf_info]
    ,[impact_v2_obtain_all_privilege]
    ,[impact_v2_obtain_user_privilege]
    ,[impact_v2_obtain_other_privilege] 
    '
SET @query_modified_import_part_2 = N' ,[impact_v2_user_interaction_required]
    ,[impact_v2_version]
    ,[impact_v2_vector_string]
    ,[impact_v2_access_vector]
    ,[impact_v2_access_complexity]
    ,[impact_v2_authentication]
    ,[impact_v2_confidentiality_impact]
    ,[impact_v2_integrity_impact]
    ,[impact_v2_availability_impact]
    ,[impact_v2_base_score] 
FROM OPENROWSET (BULK ''$(file_path)$(file_name_prefix)modified.json'', SINGLE_CLOB) as j
CROSS APPLY OPENJSON(BulkColumn)
WITH (
    [object_download_datetime] [nvarchar](50) ''$.CVE_data_timestamp''
    ,[cve_items] [nvarchar](MAX) ''$.CVE_Items'' AS JSON
)
OUTER APPLY OPENJSON(cve_items)
WITH (
    [item_cve_data_type] [varchar](50) ''$.cve.data_type''
    ,[item_cve_data_format] [varchar](50) ''$.cve.data_format''
    ,[item_cve_data_version] [numeric](4, 2) ''$.cve.data_version''
    ,[item_cve_data_meta_id] [varchar](50) ''$.cve.CVE_data_meta.ID''
    ,[item_cve_data_meta_assigner] [varchar](500) ''$.cve.CVE_data_meta.ASSIGNER''
    ,[item_cve_problemtype] [nvarchar](MAX) ''$.cve.problemtype'' AS JSON
    ,[item_cve_references] [nvarchar](MAX) ''$.cve.references'' AS JSON
    ,[item_cve_primary_description] varchar(MAX) ''$.cve.description.description_data[0].value''
    ,[item_cve_description] [nvarchar](MAX) ''$.cve.description'' AS JSON
    ,[item_configurations] [nvarchar](MAX) ''$.configurations'' AS JSON
    ,[item_impact] [nvarchar](MAX) ''$.impact'' AS JSON
    ,[item_published_datetime] [nvarchar](50) ''$.publishedDate''
    ,[item_modified_datetime] [nvarchar](50) ''$.lastModifiedDate''
    ,[impact_v3_exploitability_score] [numeric](4, 2) ''$.impact.baseMetricV3.exploitabilityScore''
    ,[impact_v3_impact_score] [numeric](4, 2) ''$.impact.baseMetricV3.impactScore''
    ,[impact_v3_version] [numeric](4, 2) ''$.impact.baseMetricV3.cvssV3.version''
    ,[impact_v3_vector_string] [varchar](50) ''$.impact.baseMetricV3.cvssV3.vectorString''
    ,[impact_v3_attack_vector] [varchar](50) ''$.impact.baseMetricV3.cvssV3.attackVector''
    ,[impact_v3_attack_complexity] [varchar](50) ''$.impact.baseMetricV3.cvssV3.attackComplexity''
    ,[impact_v3_privileges_required] [varchar](50) ''$.impact.baseMetricV3.cvssV3.privilegesRequired''
    ,[impact_v3_user_interaction] [varchar](50) ''$.impact.baseMetricV3.cvssV3.userInteraction''
    ,[impact_v3_scope] [varchar](50) ''$.impact.baseMetricV3.cvssV3.scope''
    ,[impact_v3_confidentiality_impact] [varchar](50) ''$.impact.baseMetricV3.cvssV3.confidentialityImpact''
    ,[impact_v3_integrity_impact] [varchar](50) ''$.impact.baseMetricV3.cvssV3.integrityImpact''
    ,[impact_v3_availability_impact] [varchar](50) ''$.impact.baseMetricV3.cvssV3.availabilityImpact''
    ,[impact_v3_base_score] [numeric](4, 2) ''$.impact.baseMetricV3.cvssV3.baseScore''
    ,[impact_v3_base_severity] [varchar](50) ''$.impact.baseMetricV3.cvssV3.baseSeverity'' '
SET @query_modified_import_part_3 = N',[impact_v2_severity] [varchar](50) ''$.impact.baseMetricV2.severity''
    ,[impact_v2_exploitability_score] [numeric](4, 2) ''$.impact.baseMetricV2.exploitabilityScore''
    ,[impact_v2_impact_score] [numeric](4, 2) ''$.impact.baseMetricV2.impactScore''
    ,[impact_v2_ac_insuf_info] [bit] ''$.impact.baseMetricV2.acInsufInfo''
    ,[impact_v2_obtain_all_privilege] [bit] ''$.impact.baseMetricV2.obtainAllPrivilege''
    ,[impact_v2_obtain_user_privilege] [bit] ''$.impact.baseMetricV2.obtainUserPrivilege''
    ,[impact_v2_obtain_other_privilege] [bit] ''$.impact.baseMetricV2.obtainOtherPrivilege''
    ,[impact_v2_user_interaction_required] [bit] ''$.impact.baseMetricV2.userInteractionRequired''
    ,[impact_v2_version] [numeric](4, 2) ''$.impact.baseMetricV2.cvssV2.version''
    ,[impact_v2_vector_string] [varchar](50) ''$.impact.baseMetricV2.cvssV2.vectorString''
    ,[impact_v2_access_vector] [varchar](50) ''$.impact.baseMetricV2.cvssV2.accessVector''
    ,[impact_v2_access_complexity] [varchar](50) ''$.impact.baseMetricV2.cvssV2.accessComplexity''
    ,[impact_v2_authentication] [varchar](50) ''$.impact.baseMetricV2.cvssV2.authentication''
    ,[impact_v2_confidentiality_impact] [varchar](50) ''$.impact.baseMetricV2.cvssV2.confidentialityImpact''
    ,[impact_v2_integrity_impact] [varchar](50) ''$.impact.baseMetricV2.cvssV2.integrityImpact''
    ,[impact_v2_availability_impact] [varchar](50) ''$.impact.baseMetricV2.cvssV2.availabilityImpact''
    ,[impact_v2_base_score] [numeric](4, 2) ''$.impact.baseMetricV2.cvssV2.baseScore''
)';
SET @query_modified_import = @query_modified_import_part_1 + @query_modified_import_part_2 + @query_modified_import_part_3
EXEC sp_executesql @query_modified_import;        

MERGE [$(db_name)].[$(schema_name)].[$(target_table_name)] AS target_table
USING [$(db_name)].[$(schema_name)].[$(import_table_name)] AS source_table
    ON target_table.item_cve_data_meta_id = source_table.item_cve_data_meta_id
WHEN MATCHED THEN 
    UPDATE SET 
    target_table.object_filename = source_table.object_filename
    ,target_table.object_download_datetime = source_table.object_download_datetime
    ,target_table.item_cve_data_type = source_table.item_cve_data_type
    ,target_table.item_cve_data_format = source_table.item_cve_data_format
    ,target_table.item_cve_data_version = source_table.item_cve_data_version
    ,target_table.item_cve_data_meta_assigner = source_table.item_cve_data_meta_assigner
    ,target_table.item_cve_problemtype = source_table.item_cve_problemtype
    ,target_table.item_cve_references = source_table.item_cve_references
    ,target_table.item_cve_primary_description = source_table.item_cve_primary_description
    ,target_table.item_cve_description = source_table.item_cve_description
    ,target_table.item_impact = source_table.item_impact
    ,target_table.item_configurations = source_table.item_configurations
    ,target_table.item_published_datetime = source_table.item_published_datetime
    ,target_table.item_modified_datetime = source_table.item_modified_datetime
    ,target_table.impact_v3_exploitability_score = source_table.impact_v3_exploitability_score
    ,target_table.impact_v3_impact_score = source_table.impact_v3_impact_score
    ,target_table.impact_v3_version = source_table.impact_v3_version
    ,target_table.impact_v3_vector_string = source_table.impact_v3_vector_string
    ,target_table.impact_v3_attack_vector = source_table.impact_v3_attack_vector
    ,target_table.impact_v3_attack_complexity = source_table.impact_v3_attack_complexity
    ,target_table.impact_v3_privileges_required = source_table.impact_v3_privileges_required
    ,target_table.impact_v3_user_interaction = source_table.impact_v3_user_interaction
    ,target_table.impact_v3_scope = source_table.impact_v3_scope
    ,target_table.impact_v3_confidentiality_impact = source_table.impact_v3_confidentiality_impact
    ,target_table.impact_v3_integrity_impact = source_table.impact_v3_integrity_impact
    ,target_table.impact_v3_availability_impact = source_table.impact_v3_availability_impact
    ,target_table.impact_v3_base_score = source_table.impact_v3_base_score
    ,target_table.impact_v3_base_severity = source_table.impact_v3_base_severity
    ,target_table.impact_v2_severity = source_table.impact_v2_severity
    ,target_table.impact_v2_exploitability_score = source_table.impact_v2_exploitability_score
    ,target_table.impact_v2_impact_score = source_table.impact_v2_impact_score
    ,target_table.impact_v2_ac_insuf_info = source_table.impact_v2_ac_insuf_info
    ,target_table.impact_v2_obtain_all_privilege = source_table.impact_v2_obtain_all_privilege
    ,target_table.impact_v2_obtain_user_privilege = source_table.impact_v2_obtain_user_privilege
    ,target_table.impact_v2_obtain_other_privilege = source_table.impact_v2_obtain_other_privilege
    ,target_table.impact_v2_user_interaction_required = source_table.impact_v2_user_interaction_required
    ,target_table.impact_v2_version = source_table.impact_v2_version
    ,target_table.impact_v2_vector_string = source_table.impact_v2_vector_string
    ,target_table.impact_v2_access_vector = source_table.impact_v2_access_vector
    ,target_table.impact_v2_access_complexity = source_table.impact_v2_access_complexity
    ,target_table.impact_v2_authentication = source_table.impact_v2_authentication
    ,target_table.impact_v2_confidentiality_impact = source_table.impact_v2_confidentiality_impact
    ,target_table.impact_v2_integrity_impact = source_table.impact_v2_integrity_impact
    ,target_table.impact_v2_availability_impact = source_table.impact_v2_availability_impact
    ,target_table.impact_v2_base_score = source_table.impact_v2_base_score
WHEN NOT MATCHED BY TARGET THEN INSERT (
    [object_filename]
    ,[object_download_datetime]
    ,[item_cve_data_type]
    ,[item_cve_data_format]
    ,[item_cve_data_version]
    ,[item_cve_data_meta_id]
    ,[item_cve_data_meta_assigner]
    ,[item_cve_problemtype]
    ,[item_cve_references]
    ,[item_cve_primary_description]
    ,[item_cve_description]
    ,[item_configurations]
    ,[item_impact]
    ,[item_published_datetime]
    ,[item_modified_datetime]
    ,[impact_v3_exploitability_score]
    ,[impact_v3_impact_score]
    ,[impact_v3_version]
    ,[impact_v3_vector_string]
    ,[impact_v3_attack_vector]
    ,[impact_v3_attack_complexity]
    ,[impact_v3_privileges_required]
    ,[impact_v3_user_interaction]
    ,[impact_v3_scope]
    ,[impact_v3_confidentiality_impact]
    ,[impact_v3_integrity_impact]
    ,[impact_v3_availability_impact]
    ,[impact_v3_base_score]
    ,[impact_v3_base_severity]
    ,[impact_v2_severity]
    ,[impact_v2_exploitability_score]
    ,[impact_v2_impact_score]
    ,[impact_v2_ac_insuf_info]
    ,[impact_v2_obtain_all_privilege]
    ,[impact_v2_obtain_user_privilege]
    ,[impact_v2_obtain_other_privilege]
    ,[impact_v2_user_interaction_required]
    ,[impact_v2_version]
    ,[impact_v2_vector_string]
    ,[impact_v2_access_vector]
    ,[impact_v2_access_complexity]
    ,[impact_v2_authentication]
    ,[impact_v2_confidentiality_impact]
    ,[impact_v2_integrity_impact]
    ,[impact_v2_availability_impact]
    ,[impact_v2_base_score]
) VALUES(
    [object_filename]
    ,[object_download_datetime]
    ,[item_cve_data_type]
    ,[item_cve_data_format]
    ,[item_cve_data_version]
    ,[item_cve_data_meta_id]
    ,[item_cve_data_meta_assigner]
    ,[item_cve_problemtype]
    ,[item_cve_references]
    ,[item_cve_primary_description]
    ,[item_cve_description]
    ,[item_configurations]
    ,[item_impact]
    ,[item_published_datetime]
    ,[item_modified_datetime]
    ,[impact_v3_exploitability_score]
    ,[impact_v3_impact_score]
    ,[impact_v3_version]
    ,[impact_v3_vector_string]
    ,[impact_v3_attack_vector]
    ,[impact_v3_attack_complexity]
    ,[impact_v3_privileges_required]
    ,[impact_v3_user_interaction]
    ,[impact_v3_scope]
    ,[impact_v3_confidentiality_impact]
    ,[impact_v3_integrity_impact]
    ,[impact_v3_availability_impact]
    ,[impact_v3_base_score]
    ,[impact_v3_base_severity]
    ,[impact_v2_severity]
    ,[impact_v2_exploitability_score]
    ,[impact_v2_impact_score]
    ,[impact_v2_ac_insuf_info]
    ,[impact_v2_obtain_all_privilege]
    ,[impact_v2_obtain_user_privilege]
    ,[impact_v2_obtain_other_privilege]
    ,[impact_v2_user_interaction_required]
    ,[impact_v2_version]
    ,[impact_v2_vector_string]
    ,[impact_v2_access_vector]
    ,[impact_v2_access_complexity]
    ,[impact_v2_authentication]
    ,[impact_v2_confidentiality_impact]
    ,[impact_v2_integrity_impact]
    ,[impact_v2_availability_impact]
    ,[impact_v2_base_score]
)

OUTPUT $ACTION, INSERTED.nvd_db_id, INSERTED.item_cve_data_meta_id;
GO

DECLARE @query_truncate_3 [nvarchar](MAX) = N'TRUNCATE TABLE [$(db_name)].[$(schema_name)].[$(import_table_name)];'

EXEC sp_executesql @query_truncate_3;
GO