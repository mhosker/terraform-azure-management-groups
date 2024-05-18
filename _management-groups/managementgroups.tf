# *********************************************************
# MANAGEMENT GROUPS
# *********************************************************

locals{
    tenant_root_mgmt_group = "/providers/Microsoft.Management/managementGroups/${data.azurerm_client_config.current.tenant_id}"
}

# ---------------------------------------------------------
# Level 1
# ---------------------------------------------------------

resource "azurerm_management_group" "level_1" {
    for_each = var.management_groups

    name                       = each.key
    display_name               = each.value.name
    parent_management_group_id = local.tenant_root_mgmt_group
}

# ---------------------------------------------------------
# Level 2
# ---------------------------------------------------------

locals {
  level_2 = zipmap(
    flatten([for key, value in var.management_groups : formatlist("${key}/%s", keys(value.children)) if value.children != null]),
    flatten([for value in var.management_groups : values(value.children) if value.children != null])
  )
}

resource "azurerm_management_group" "level_2" {
    for_each = local.level_2

    name                       = basename(each.key)
    display_name               = each.value.name
    parent_management_group_id = azurerm_management_group.level_1[trimsuffix(each.key, "/${basename(each.key)}")].id

    depends_on = [azurerm_management_group.level_1]
}

# ---------------------------------------------------------
# Level 3
# ---------------------------------------------------------

locals {
  level_3 = zipmap(
    flatten([for key, value in local.level_2 : formatlist("${key}/%s", keys(value.children)) if value.children != null]),
    flatten([for value in local.level_2 : values(value.children) if value.children != null])
  )
}

resource "azurerm_management_group" "level_3" {
    for_each = local.level_3

    name                       = basename(each.key)
    display_name               = each.value.name
    parent_management_group_id = azurerm_management_group.level_2[trimsuffix(each.key, "/${basename(each.key)}")].id

    depends_on = [azurerm_management_group.level_2]
}

# ---------------------------------------------------------
# Level 4
# ---------------------------------------------------------

locals {
  level_4 = zipmap(
    flatten([for key, value in local.level_3 : formatlist("${key}/%s", keys(value.children)) if value.children != null]),
    flatten([for value in local.level_3 : values(value.children) if value.children != null])
  )
}

resource "azurerm_management_group" "level_4" {
    for_each = local.level_4

    name                       = basename(each.key)
    display_name               = each.value.name
    parent_management_group_id = azurerm_management_group.level_3[trimsuffix(each.key, "/${basename(each.key)}")].id

    depends_on = [azurerm_management_group.level_3]
}

# ---------------------------------------------------------
# Level 5
# ---------------------------------------------------------

locals {
  level_5 = zipmap(
    flatten([for key, value in local.level_4 : formatlist("${key}/%s", keys(value.children)) if value.children != null]),
    flatten([for value in local.level_4 : values(value.children) if value.children != null])
  )
}

resource "azurerm_management_group" "level_5" {
    for_each = local.level_5

    name                       = basename(each.key)
    display_name               = each.value.name
    parent_management_group_id = azurerm_management_group.level_4[trimsuffix(each.key, "/${basename(each.key)}")].id

    depends_on = [azurerm_management_group.level_4]
}

# ---------------------------------------------------------
# Level 6
# ---------------------------------------------------------

locals {
  level_6 = zipmap(
    flatten([for key, value in local.level_5 : formatlist("${key}/%s", keys(value.children)) if value.children != null]),
    flatten([for value in local.level_5 : values(value.children) if value.children != null])
  )
}

resource "azurerm_management_group" "level_6" {
    for_each = local.level_6

    name                       = basename(each.key)
    display_name               = each.value.name
    parent_management_group_id = azurerm_management_group.level_5[trimsuffix(each.key, "/${basename(each.key)}")].id

    depends_on = [azurerm_management_group.level_5]
}