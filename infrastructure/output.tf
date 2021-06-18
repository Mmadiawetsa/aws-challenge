#Add/remove outputs according to infrastructure specified in main (e.g. if a stepfunction is removed, the output for it should also be removed).
output "state_machine_id" {
  description = "The id of the State Machine"
  value       = element(concat(module.step_1_parallelism.*.id, [""]), 0)
}

output "state_machine_arn" {
  description = "The ARN of the State Machine"
  value       = element(concat(module.step_1_parallelism.*.arn, [""]), 0)
}

output "state_machine_status" {
  description = "The current status of the State Machine"
  value       = element(concat(module.step_1_parallelism.*.status, [""]), 0)
}

output "glue_crawler_id" {
  description = "Crawler id"
  value       = element(concat(module.glue_ingest_default_job.*.id, [""]), 0)
}

output "glue_crawler_arn" {
  description = "The ARN of the crawler"
  value       = element(concat(module.glue_ingest_default_job.*.arn, [""]), 0)
}