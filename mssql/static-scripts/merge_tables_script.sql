-- REPLACE <db_name> WITH EXISTING DATABASE NAME
DECLARE @db_name nvarchar(MAX) = '<db_name>';
-- REPLACE <schema_name> WITH EXISTING OWNER NAME
DECLARE @schema_name nvarchar(MAX) = '<schema_name>';
-- REPLACE <target_table_name> WITH EXISTING TARGET TABLE NAME
DECLARE @target_table_name nvarchar(MAX) = '<table_name>'
-- REPLACE <import_table_name> WITH EXISTING IMPORT TABLE NAME
DECLARE @import_table_name nvarchar(MAX) = '<table_name>'

DECLARE @query_part_1 nvarchar(MAX) = N'MERGE [' + @db_name + '].[' + @schema_name + '].[' + @target_table_name + '] AS target_table
USING [' + @db_name + '].[' + @schema_name + '].[' + @import_table_name + '] AS source_table
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
	,target_table.impact_v2_base_score = source_table.impact_v2_base_score '
DECLARE @query_part_2 nvarchar(MAX) = N'
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
      ,[impact_v3_ac_insuf_info]
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

OUTPUT $ACTION, INSERTED.nvd_db_id, INSERTED.item_cve_data_meta_id;';

DECLARE @query nvarchar(MAX) = @query_part_1 + @query_part_2

PRINT(@query)
EXEC sp_executesql @query;