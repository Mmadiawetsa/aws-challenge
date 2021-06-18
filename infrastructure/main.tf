# main.tf 2 modules for 1 for a step function and 1 for the actual glue job

module "step_1_parallelism" {
    source = "../../"
    name       = var.sfn_name
    definition = var.definition
    role_arn   = var.sfn_role_arn
    type       = var.type

    service_integrations = {

        s3bucket = {
            s3bucket = [""arn:aws:s3bucket:region:account:table/write"]
        }

        athena_StartQueryExecution_Sync = {
            athena        = ["arn:aws:athena:region:account:something1:athena_role"]
            glue          = ["arn:aws:glue:region:account:something2:glue_role"]
            s3            = true 
            lakeformation = ["arn:aws:lakeformation:region:account:something3:write"]
        }

        lambda = {
            lambda = ["arn:aws:lambda:region:account:function:read", "arn:aws:lambda:region:account:function:write"]
            }
    }

    tags = var.tags
}




module "glue_ingest_default_job" {
    source = "../../"
    name          = var.glue_crawler_name
    database_name = var.glue_crawler_database_name
    role          = var.glue_crawler_role

    description            = var.glue_crawler_description
    classifiers            = var.glue_crawler_classifiers
    configuration          = var.glue_crawler_configuration
    schedule               = var.glue_crawler_schedule
    table_prefix           = var.glue_crawler_table_prefix

    dynamic "dynamodb_target" {
        iterator = dynamodb_target
        for_each = var.glue_crawler_dynamodb_target
        content {
            path = lookup(dynamodb_target.value, "path", null)
            }
        }

        dynamic "s3_target" {
        iterator = s3_target
        for_each = var.glue_crawler_s3_target
        content {
            path       = lookup(s3_target.value, "path", null)
            exclusions = lookup(s3_target.value, "exclusions", null)
            }
        }

        tags = var.tags

    }
}
