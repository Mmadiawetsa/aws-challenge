module "glue_job_default_artifact_py" {
  source = "git::ssh://git..."
  filename = "glue_job.py"
  #Fill in the rest of the terraform template needed

  name = "glue_job"
  role_arn = var.glue_job_role_arn
  command {
    script_location = "s3://${aws_s3_bucket}/glue_job.py"
  }
}

module "glue_job_default_artifact_dependencies" {
  source       = "git::ssh://git..."
  filename     = "dependencies.zip"
  #Fill in the rest of the terraform template needed
  }


module "glue_ingest" {
  source = "git::ssh://git..."

  job_name = "ingest-glue-job"

  #Fill in the rest of the terraform template needed
  role_arn = var.glue_job_role_arn

  description            = var.glue_job_description
  default_arguments      = var.glue_job_default_arguments
  glue_version           = var.glue_job_glue_version
  max_capacity           = var.glue_job_max_capacity
  max_retries            = var.glue_job_max_retries
  timeout                = var.glue_job_timeout
  worker_type            = var.glue_job_worker_type
  number_of_workers      = var.glue_job_number_of_workers

  dynamic "command" {
    iterator = command
    for_each = var.glue_job_command
    content {
      script_location = lookup(command.value, "script_location", null)

      name           = lookup(command.value, "name", null)
      python_version = lookup(command.value, "python_version", null)
    }
  }
  dynamic "execution_property" {
    iterator = execution_property
    for_each = var.glue_job_execution_property
    content {
      max_concurrent_runs = lookup(execution_property.value, "max_concurrent_runs", 1)
    }
  }
  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }
}

