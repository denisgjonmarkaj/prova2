output "cluster_id" {
  value = oci_containerengine_cluster.oke_prd.id
}

output "nodepool_id" {
  value = oci_containerengine_node_pool.node_prd.id
}