terraform {
  cloud {
    organization = "Essity"
    workspaces {
      name = "resource-group-action"
    }
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.0.1"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features {}
}



variable "azurerm_resource_group" {
  description = "value for the resource group"
  type        = strings
}

variable "environment" {
  description = "value for the environment"
  type        = string
  default     = "dev"
}

variable "location" {
  description = "value for the location"
  type        = string
  default     = "westeurope"
}

variable "owner" {
  description = "value for the owner"
  type        = string
}

variable "solution_id" {
  description = "value for the solution id"
  type        = string
}

variable "business_justification" {
  description = "value for the business justification"
  type        = string
  default     = ""
}

resource "azurerm_resource_group" "resource_group" {
  name     = "rg-var.resource_group_name-var.environment"
  location = var.location
  tags = {
    environment            = var.environment
    owner                  = var.owner
    solution-id            = var.solution_id
    created-by             = var.owner
    created-on             = timestamp()
    business-justification = var.business_justification
  }

  lifecycle {
    ignore_changes = ["tags"]
  }
}


output "resource_group_id" {
  value = azurerm_resource_group.resource_group.id
}

output "resource_group_name" {
  value = azurerm_resource_group.resource_group.name
}
