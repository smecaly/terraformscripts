variable "profile" {
  default = "default"
  description = "AWS profile for credentials"
}

variable "region" {
  default = "us-east-2"
  description = "AWS region"
}

variable "domain_name" {
  default     = "weldsaws"
  description = "name of Elasticsearch Domain"
}

variable "elasticsearch_version" {
  default     = "6.5"
  description = "Version of Elasticsearch to deploy"
}

variable "instance_type" {
  default     = "t2.small.elasticsearch"
  description = "Elasticsearch instance type for data nodes in the cluster"
}

variable "instance_count" {
  description = "Number of data nodes in the cluster"
  default     = 2
}

variable "zone_awareness_enabled" {
  default     = true
  description = "Enable zone awareness for Elasticsearch cluster"
}

variable "availability_zone_count" {
  default     = 2
  description = "Number of Availability Zones for the domain to use."
}

variable "ebs_volume_size" {
  default     = 20
  description = "EBS volumes for data storage in GB"
}

variable "ebs_volume_type" {
  default     = "gp2"
  description = "Storage type of EBS volumes"
}

variable "ebs_iops" {
  default     = 0
  description = "The baseline input/output (I/O) performance of EBS volumes attached to data nodes. Applicable only for the Provisioned IOPS EBS volume type"
}

variable "encrypt_at_rest_enabled" {
  default     = false
  description = "Whether to enable encryption at rest or not"
}

variable "encrypt_at_rest_kms_key_id" {
  default     = ""
  description = "The KMS key ID to encrypt the Elasticsearch domain with. If not specified, then it defaults to using the AWS/Elasticsearch service KMS key"
}

variable "log_publishing_index_enabled" {
  default     = false
  description = "Specifies whether log publishing option for INDEX_SLOW_LOGS is enabled or not"
}

variable "log_publishing_search_enabled" {
  default     = false
  description = "Specifies whether log publishing option for SEARCH_SLOW_LOGS is enabled or not"
}

variable "log_publishing_application_enabled" {
  default     = false
  description = "Specifies whether log publishing option for ES_APPLICATION_LOGS is enabled or not"
}

variable "log_publishing_index_cloudwatch_log_group_arn" {
  default     = ""
  description = "ARN of the CloudWatch log group to which log for INDEX_SLOW_LOGS needs to be published"
}

variable "log_publishing_search_cloudwatch_log_group_arn" {
  default     = ""
  description = "ARN of the CloudWatch log group to which log for SEARCH_SLOW_LOGS needs to be published"
}

variable "log_publishing_application_cloudwatch_log_group_arn" {
  default     = ""
  description = "ARN of the CloudWatch log group to which log for ES_APPLICATION_LOGS needs to be published"
}

variable "automated_snapshot_start_hour" {
  default     = 0
  description = "Hour at which automated snapshots are taken, in UTC"
}

variable "dedicated_master_enabled" {
  default     = false
  description = "Indicates whether dedicated master nodes are enabled for the cluster"
}

variable "dedicated_master_count" {
  default     = 0
  description = "Number of dedicated master nodes in the cluster"
}

variable "dedicated_master_type" {
  default     = "t2.small.elasticsearch"
  description = "Instance type of the dedicated master nodes in the cluster"
}

variable "advanced_options" {
  default     = {}
  description = "Key-value string pairs to specify advanced configuration options"
}


variable "node_to_node_encryption_enabled" {
  default     = false
  description = "Whether to enable node-to-node encryption"
}
