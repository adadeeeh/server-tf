# server-tf

## Description

This terraform configuration is used to create server on top of [this network](https://github.com/adadeeeh/network-tf).

## Configuration

1. Use Terraform Cloud as the backend
2. Create new workspace and connect this repository.
3. Create terraform variable with key `tfc_org_name` and set the value to the name of your Terraform Cloud organization.
4. Create variable set or create environment variables to store `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`.
5. Configure run trigger by navigating to "Settings" page, under "Run Triggers" tab. Add run trigger by selecting the network worskpace and click "Add workspace".
