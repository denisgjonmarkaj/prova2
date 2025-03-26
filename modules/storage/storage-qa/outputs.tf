output "elasticsearch_instance_configuration_id" {
  description = "ID della configurazione dell'istanza ElasticSearch"
  value       = oci_core_instance_configuration.instance-config-elasticsearch.id
}

output "elasticsearch_instance_pool_id" {
  description = "ID del pool di istanze ElasticSearch"
  value       = oci_core_instance_pool.elasticsearch_pool.id
}

output "elasticsearch_instance_pool_size" {
  description = "Numero di istanze nel pool ElasticSearch"
  value       = oci_core_instance_pool.elasticsearch_pool.size
}

output "elasticsearch_instance_pool_state" {
  description = "Stato del pool di istanze ElasticSearch"
  value       = oci_core_instance_pool.elasticsearch_pool.state
}