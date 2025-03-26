environment   = "staging" 
region             = "eu-frankfurt-1"
tenancy_ocid       = "ocid1.tenancy.oc1..aaaaaaaaz36a6ptgcaqnnhxfretqhvwf7vacbottvbr2mpkp7ganclz5ss6q"
admin_user_pk      = "ocid1.vaultsecret.oc1.eu-frankfurt-1.amaaaaaarhmdlkaa342vyrs3kxcbb6e7pkpn3qzmcsox3qb4yttlszr73jia"
admin_user_fingerprint = "46:f9:f3:d9:b8:8e:d0:40:e1:5e:4a:70:61:c7:4e:d2"
admin_user_ocid    = "ocid1.user.oc1..aaaaaaaabtt7xqqj5e7ja3br6bfjlpz7zjt5kq2b54bbclvgvyszfdiuyzda"

# compartment_ocid   = "ocid1.compartment.oc1..aaaaaaaa242igehzmabfkw7eyh2werc7wp73zqgecdlyeuk3t2qkkyjuz5ga"
# vcn_cidr           = "10.253.50.0/24"
# net_cidr_private   = "10.253.50.0/26"
# net_cidr_private_lb = "10.253.50.64/26"
# net_cidr_public    = "10.253.50.128/26"
# net_cidr_public_lb = "10.253.50.192/26"

# Variables PostgreSQL
postgresql_display_name = "postgresql-staging"
postgresql_db_version = "14"
postgresql_shape = "PostgreSQL.VM.Standard.E5.Flex"
postgresql_cpu_core_count = 2
postgresql_memory_size_in_gbs = 32
postgresql_instance_count = 1
postgresql_admin_username = "postgres"
postgresql_admin_password = "Passw0rd!" 
postgresql_is_regionally_durable = false
postgresql_availability_domain = "ibtU:EU-FRANKFURT-1-AD-3"

# Configuration backup
postgresql_backup_policy_kind = "WEEKLY"
postgresql_backup_start_time = "00:30"
postgresql_backup_retention_days = 31
postgresql_backup_days_of_week = ["SUNDAY"]

# ElasticSearch
elasticsearch_instance_ocpus = 4
elasticsearch_instance_memory = 32
elasticsearch_block_volume_size_gb = 100
elasticsearch_boot_volume_size_gb = 100
elasticsearch_instance_pool_size = 3
elasticsearch_block_volume_vpus = 10
elasticsearch_fault_domain = "FAULT-DOMAIN-3"
elasticsearch_availability_domain = "ibtU:EU-FRANKFURT-1-AD-1"



