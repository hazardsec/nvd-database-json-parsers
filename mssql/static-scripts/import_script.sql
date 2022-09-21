-- REPLACE <db_name> WITH EXISTING DATABASE NAME
DECLARE @db_name varchar(100) = '<db_name>';
-- REPLACE <db_owner> WITH EXISTING OWNER NAME
DECLARE @db_owner varchar(100) = '<db_owner>';
-- REPLACE <table_name> WITH EXISTING TABLE NAME
DECLARE @table_name varchar(100) = '<table_name>'
-- REPLACE <file_name> WITH EXISTING NVD JSON FILE FILENAME (e.g. nvdcve-1.1-2002.json)
DECLARE @file_name [varchar](500) = '<file_name>';
-- REPLACE <file_path> WITH FILE PATH TO JSON FILE ABOVE (e.g. C:\Users\Username\Downloads\nvdcve-1.1-2002\)
DECLARE @file_path [varchar](MAX) = '<file_path>';
DECLARE @query [nvarchar](MAX) = N'INSERT INTO [' + @db_name + '].[' + @db_owner + '].[' + @table_name + '] (
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
  SELECT ''' + @file_name + ''' as [object_filename]
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
 FROM OPENROWSET (BULK ''' + @file_path + @file_name + ''', SINGLE_CLOB) as j
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
	 ,[impact_v3_base_severity] [varchar](50) ''$.impact.baseMetricV3.cvssV3.baseSeverity''
	 ,[impact_v2_severity] [varchar](50) ''$.impact.baseMetricV2.severity''
	 ,[impact_v2_exploitability_score] [numeric](4, 2) ''$.impact.baseMetricV2.exploitabilityScore''
	 ,[impact_v2_impact_score] [numeric](4, 2) ''$.impact.baseMetricV2.impactScore''
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
EXEC sp_executesql @query;