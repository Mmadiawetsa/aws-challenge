#Mandatory parameters
variable "aws_region" {
  type        = string
  description = "AWS region"
  #define here the region where DAPFW will be deployed
  default = "eu-west-1"
}

variable "vpc_name" {
  type        = string
  description = "Name of the VPC to be used for the glue jobs"
  #define here the name of the VPC to be used by the glue jobs
  default = "private-dev-aftersales"
}

variable "sfn_name" {
  description = "The name of the Step Function"
  type        = string
  default     = "sfn_state_machine"
}

variable "definition" {
  description = "The Amazon States Language definition of the Step Function"
  type        = string
  default     = ""
}

variable "sfn_role_arn" {
  description = "The Amazon Resource Name (ARN) of the IAM role to use for this Step Function"
  type        = string
  default     = ""
}

variable "type" {
  description = "Determines whether a Standard or Express state machine is created. The default is STANDARD. Valid Values: STANDARD | EXPRESS"
  type        = string
  default     = "STANDARD"

  validation {
    condition     = contains(["STANDARD", "EXPRESS"], upper(var.type))
    error_message = "Step Function type must be one of the following (STANDARD | EXPRESS)."
  }
}

variable "service_integrations" {
  description = "Map of AWS service integrations to allow in IAM role policy"
  type        = any
  default     = {}
}

variable "tags" {
  description = "Maps of tags to assign to the Step Function"
  type        = map(string)
  default     = {}
}

############################### Glue Crawler ###############################

variable "glue_crawler_name" {
  description = "Name of the crawler."
  default     = ""
}

variable "glue_crawler_database_name" {
  description = "Glue database where results are written."
  default     = ""
}


variable "glue_crawler_role" {
  description = "(Required) The IAM role friendly name (including path without leading slash), or ARN of an IAM role, used by the crawler to access other resources."
  default     = ""
}

variable "glue_crawler_description" {
  description = "(Optional) Description of the crawler."
  default     = null
}

variable "glue_crawler_classifiers" {
  description = "(Optional) List of custom classifiers. By default, all AWS classifiers are included in a crawl, but these custom classifiers always override the default classifiers for a given classification."
  default     = null
}

variable "glue_crawler_configuration" {
  description = "(Optional) JSON string of configuration information."
  default     = null
}

variable "glue_crawler_schedule" {
  description = "(Optional) A cron expression used to specify the schedule. For more information, see Time-Based Schedules for Jobs and Crawlers. For example, to run something every day at 12:15 UTC, you would specify: cron(15 12 * * ? *)."
  default     = null
}

variable "glue_crawler_table_prefix" {
  description = "(Optional) The table prefix used for catalog tables that are created."
  default     = null
}

variable "glue_crawler_dynamodb_target" {
  description = "(Optional) List of nested DynamoDB target arguments."
  default     = []
}

variable "glue_crawler_s3_target" {
  description = "(Optional) List nested Amazon S3 target arguments."
  default     = []
}


