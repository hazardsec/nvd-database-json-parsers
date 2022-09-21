-- REPLACE <db_name> WITH EXISTING DATABASE NAME
USE [<db_name>]
GO

-- REPLACE <schema_name> WITH OWNER NAME
-- REPLACE <history_table_name> WITH TARGET HISTORY TABLE NAME
-- !!!! SEE MORE REPLACEMENTS BELOW INSERT !!!!
INSERT INTO [<schema_name>].[<history_table_name>]
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
     -- REPLACE <target_table_name> WITH TARGET TABLE NAME           
     SELECT * FROM [<target_table_name>];
GO


