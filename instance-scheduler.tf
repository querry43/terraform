# Manually launch the instance-scheduler cloud formation stack.
# https://aws.amazon.com/answers/infrastructure-management/instance-scheduler/
#   name        = instance-scheduler
#   StartedTags = "ScheduleMessage=Started by {scheduler} on {year}-{month}-{day}T{hour}:{minute}"
#   StoppedTags = "ScheduleMessage=Stopped by {scheduler} on {year}-{month}-{day}T{hour}:{minute}"

data aws_cloudformation_stack instance_scheduler {
  name = "instance-scheduler"
}

data aws_dynamodb_table instance_scheduler {
  name = data.aws_cloudformation_stack.instance_scheduler.outputs.ConfigurationTable
}

resource aws_dynamodb_table_item instance_scheduler_daytime_period {
  table_name = data.aws_dynamodb_table.instance_scheduler.name
  hash_key   = data.aws_dynamodb_table.instance_scheduler.hash_key
  range_key  = data.aws_dynamodb_table.instance_scheduler.range_key

  item = jsonencode({
    type        = { S = "period" }
    name        = { S = "daytime" }
    description = { S = "Daytime hours" }
    begintime   = { S = "09:00" }
    endtime     = { S = "23:00" }
  })
}

resource aws_dynamodb_table_item instance_scheduler_daytime_schedule {
  table_name = data.aws_dynamodb_table.instance_scheduler.name
  hash_key   = data.aws_dynamodb_table.instance_scheduler.hash_key
  range_key  = data.aws_dynamodb_table.instance_scheduler.range_key

  item = jsonencode({
    type        = { S = "schedule" }
    name        = { S = "daytime" }
    description = { S = "Daytime hours" }
    periods     = { SS = ["daytime"] }
    timezone    = { S = "America/Los_Angeles" }
  })
}
