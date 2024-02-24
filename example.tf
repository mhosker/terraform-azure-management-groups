module "management-groups" {
  source = "../_management-groups"

  # ---------------------------------------------------------
  # Management Groups
  # ---------------------------------------------------------

  management_groups = {
    "MH" = {
      name = "Mike Hosker"
      children = {
        "MH-Prod" = {
          name = "Production"
          children = {
            "level-3" = {
              name = "Level 3"
              children = {
                "level-4" = {
                  name = "Level 4"
                  children = {
                    "level-5" = {
                      name = "Level 5"
                      children = {
                        "level-6" = {
                          name = "Level 6"
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
        "MH-Dev" = {
          name = "Development"
        }
        "MH-Test" = {
          name = "Test"
        }
      }
    }
  }
}