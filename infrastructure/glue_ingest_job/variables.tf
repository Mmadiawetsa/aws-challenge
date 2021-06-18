variable "aws_region" {
  type        = string
  description = "AWS region"
  #define here the region where GLUE will be deployed
  default = "eu-west-1"
}

variable "glue_job_name" {
  description = "The name you assign to this job. It must be unique in your account."
  default     = ""
}

variable "glue_job_role_arn" {
  description = "The ARN of the IAM role associated with this job."
  default     = null
}

variable "glue_job_description" {
  description = "Description of the job."
  default     = null
}

variable "glue_job_default_arguments" {
  description = "The map of default arguments for this job. You can specify arguments here that your own job-execution script consumes, as well as arguments that AWS Glue itself consumes. For information about how to specify and consume your own Job arguments, see the Calling AWS Glue APIs in Python topic in the developer guide. For information about the key-value pairs that AWS Glue consumes to set up your job, see the Special Parameters Used by AWS Glue topic in the developer guide."
  default = {
    "--job-language" = "python"
  }
}

variable "glue_job_command" {
  description = "(Required) The command of the job."
  default     = []
}

variable "glue_job_execution_property" {
  description = "(Optional) Execution property of the job."
  default     = []
}

variable "glue_job_glue_version" {
  description = "(Optional) The version of glue to use, for example '1.0'. For information about available versions, see the AWS Glue Release Notes."
  default     = null
}

variable "glue_job_max_capacity" {
  description = "(Optional) The maximum number of AWS Glue data processing units (DPUs) that can be allocated when this job runs. Required when pythonshell is set, accept either 0.0625 or 1.0."
  default     = null
}

variable "glue_job_max_retries" {
  description = "(Optional) The maximum number of times to retry this job if it fails."
  default     = null
}

variable "glue_job_timeout" {
  description = "(Optional) The job timeout in minutes. The default is 2880 minutes (48 hours)."
  default     = 2880
}

variable "glue_job_worker_type" {
  description = "(Optional) The type of predefined worker that is allocated when a job runs. Accepts a value of Standard, G.1X, or G.2X."
  default     = null
}

variable "glue_job_number_of_workers" {
  description = "(Optional) The number of workers of a defined workerType that are allocated when a job runs."
  default     = null
}