# terraform-azure-management-groups
An efficient way to create Azure management groups based off a Terraform map.

## Notes

- Azure management groups can only be nested down to level 6.

## Instructions
Copy the `_management-groups` module directory to your Terraform project and then use the example found in `example.tf` to include the module with the required parameters.

As with any code, I strongly recommend reading and understanding all files thoroughly before deploying.

## Further Reading
For more info on this project see the associated blog post at - https://mikehosker.net/efficiently-creating-azure-management-groups-in-terraform/