output "aws_region" {
  value = data.terraform_remote_state.network.outputs.aws_region
}