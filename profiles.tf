data aws_iam_policy_document administrator_role {
  statement {
    actions = [ "sts:AssumeRole" ]

    principals {
      type        = "Service"
      identifiers = [ "ec2.amazonaws.com" ]
    }
  }
}

resource aws_iam_role administrator_role {
  name               = "administrator-role"
  assume_role_policy = data.aws_iam_policy_document.administrator_role.json
}

data aws_iam_policy AdminstratorAccess {
  arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource aws_iam_role_policy_attachment administrator_role {
  role       = aws_iam_role.administrator_role.name
  policy_arn = data.aws_iam_policy.AdminstratorAccess.arn
}

resource aws_iam_instance_profile administrator_profile {
  name = "administrator-profile"
  role = aws_iam_role.administrator_role.name
}
