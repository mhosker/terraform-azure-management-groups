# *********************************************************
# VARIABLES
# *********************************************************

# ---------------------------------------------------------
# Management Groups
# ---------------------------------------------------------

variable "management_groups" {
    type = map(object({ # Level 1
      name = string
      children = optional(map(object({ # Level 2
        name = string
        children = optional(map(object({ # Level 3
          name = string
          children = optional(map(object({ # Level 4
            name = string
            children = optional(map(object({ # Level 5
              name = string
              children = optional(map(object({ # Level 6
                name = string
              })))
            })))
          })))
        })))
      })))
    }))
    description = "Management groups."
    nullable    = false
}