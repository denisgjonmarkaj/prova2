output "db_system_id" {
  description = "The OCID of the PostgreSQL DB system"
  value       = oci_psql_db_system.postgresql_db.id
}

output "state" {
  description = "The current state of the PostgreSQL DB system"
  value       = oci_psql_db_system.postgresql_db.state
}

output "port" {
  description = "The port number for the PostgreSQL DB"
  value       = 5432
}

output "admin_username" {
  description = "The PostgreSQL database administrator username"
  value       = var.db_admin_username
}

output "connection_string" {
  description = "The connection string for the PostgreSQL database"
  value       = "postgresql://${var.db_admin_username}@${oci_psql_db_system.postgresql_db.id}:5432/"
}