# Create the cluster with the "smallest" amount of resources allowed.
data "databricks_node_type" "smallest" {
  local_disk = true
}

# Latest LTS ML Runtime
data "databricks_spark_version" "ml" {
  ml                = true
  latest            = true
  long_term_support = true
}

resource "databricks_cluster" "this" {
  cluster_name            = var.cluster_name
  node_type_id            = data.databricks_node_type.smallest.id
  spark_version           = data.databricks_spark_version.ml.id
  autotermination_minutes = var.cluster_autotermination_minutes
  num_workers             = var.cluster_num_workers
  # spark_env_vars = {"name" = "value"}
  # spark_conf = {"name" = "value"}
  aws_attributes {

  }
}

output "cluster_url" {
  value = databricks_cluster.this.url
}
