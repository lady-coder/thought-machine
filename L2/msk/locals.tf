locals {
  dashed_version = replace(var.kafka_version, ".", "-")

  msk_brokers_log_group_name    = "${var.log_group_prefix}/${var.cluster_name}/broker-logs"
  msk_connectors_log_group_name = "${var.log_group_prefix}/${var.cluster_name}/connectors"
  apps_properties               = <<-EOT
    ${var.deploy_msk_in_public ? "allow.everyone.if.no.acl.found=false" : ""}
    ${var.enable_msk_configuration_for_tm ? "log.message.timestamp.type=CreateTime" : ""}
    auto.create.topics.enable=false
    message.max.bytes=4194304
    replica.fetch.max.bytes=5242880
    unclean.leader.election.enable=false
    min.insync.replicas=2
    offsets.retention.minutes=20160
  EOT
}
