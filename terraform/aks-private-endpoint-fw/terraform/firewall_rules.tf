resource azurerm_firewall_network_rule_collection "az_network_rules" {
  name                = "network-rules"
  azure_firewall_name = azurerm_firewall.az_firewall.name
  resource_group_name = azurerm_resource_group.rg.name
  priority            = 1000
  action              = "Allow"

  rule {
    name = "allow time service"

    source_addresses = [
      azurerm_subnet.hub_subnet_1.address_prefixes[0],
      azurerm_subnet.hub_subnet_2.address_prefixes[0],
      azurerm_subnet.hub_subnet_3.address_prefixes[0],
      azurerm_subnet.spoke_subnet_1.address_prefixes[0],
    ]

    destination_ports = [
      "123",
    ]

    destination_addresses = [
      "*",
    ]

    protocols = [
      "UDP"
    ]
  }

  rule {
    name = "allow dns service"

    source_addresses = [
      azurerm_subnet.hub_subnet_1.address_prefixes[0],
      azurerm_subnet.hub_subnet_2.address_prefixes[0],
      azurerm_subnet.hub_subnet_3.address_prefixes[0],
      azurerm_subnet.spoke_subnet_1.address_prefixes[0],
    ]

    destination_ports = [
      "53",
    ]

    destination_addresses = [
      "*",
    ]

    protocols = [
      "TCP",
      "UDP"
    ]
  }

  rule {
    name = "allow tagged services"

    source_addresses = [
      azurerm_subnet.hub_subnet_1.address_prefixes[0],
      azurerm_subnet.hub_subnet_2.address_prefixes[0],
      azurerm_subnet.hub_subnet_3.address_prefixes[0],
      azurerm_subnet.spoke_subnet_1.address_prefixes[0],
    ]

    destination_ports = [
      "*",
    ]

    destination_addresses = [
      "AzureContainerRegistry",
      "MicrosoftContainerRegistry",
      "AzureActiveDirectory"
    ]

    protocols = [
      "TCP",
      "UDP"
    ]
  }
}

resource azurerm_firewall_application_rule_collection "az_application_rules" {
  name                = "application-rules"
  azure_firewall_name = azurerm_firewall.az_firewall.name
  resource_group_name = azurerm_resource_group.rg.name
  priority            = 1000
  action              = "Allow"

  rule {
    name = "allow aks services"

    source_addresses = [
      azurerm_subnet.hub_subnet_1.address_prefixes[0],
      azurerm_subnet.hub_subnet_2.address_prefixes[0],
      azurerm_subnet.hub_subnet_3.address_prefixes[0],
      azurerm_subnet.spoke_subnet_1.address_prefixes[0],
    ]

    target_fqdns = [
      "*.azmk8s.io",
      "*auth.docker.io",
      "*cloudflare.docker.io",
      "*cloudflare.docker.com",
      "*registry-1.docker.io"
    ]

    protocol {
      port = "443"
      type = "Https"
    }

    protocol {
      port = "80"
      type = "Http"
    }
  }

  rule {
    name = "allow oss services"

    source_addresses = [
      azurerm_subnet.hub_subnet_1.address_prefixes[0],
      azurerm_subnet.hub_subnet_2.address_prefixes[0],
      azurerm_subnet.hub_subnet_3.address_prefixes[0],
      azurerm_subnet.spoke_subnet_1.address_prefixes[0],
    ]

    target_fqdns = [
      "download.opensuse.org",
      "login.microsoftonline.com",
      "*.ubuntu.com",
      "dc.services.visualstudio.com",
      "*.opinsights.azure.com",
      "github.com",
      "gcr.io",
      "*.github.com",
      "raw.githubusercontent.com",
      "*.ubuntu.com",
      "api.snapcraft.io",
      "download.opensuse.org",
      "storage.googleapis.com",
      "security.ubuntu.com",
      "azure.archive.ubuntu.com",
      "changelogs.ubuntu.com"
    ]

    protocol {
      port = "443"
      type = "Https"
    }

    protocol {
      port = "80"
      type = "Http"
    }
  }

  rule {
    name = "allow azure services"

    source_addresses = [
      azurerm_subnet.hub_subnet_1.address_prefixes[0],
      azurerm_subnet.hub_subnet_2.address_prefixes[0],
      azurerm_subnet.hub_subnet_3.address_prefixes[0],
      azurerm_subnet.spoke_subnet_1.address_prefixes[0],
    ]

    target_fqdns = [
      "*azurecr.io",
      "*blob.core.windows.net",
      "*.trafficmanager.net",
      "*.azureedge.net",
      "*.microsoft.com",
      "*.core.windows.net",
      "aka.ms",
      "*.azure-automation.net",
      "*.azure.com",
      "gov-prod-policy-data.trafficmanager.net",
      "*.gk.${azurerm_resource_group.rg.location}.azmk8s.io"
      "*.monitoring.azure.com",
      "*.oms.opinsights.azure.com",
      "*.ods.opinsights.azure.com",
      "*.microsoftonline.com",
      "*.data.mcr.microsoft.com",
      "*.cdn.mscr.io",
      "mcr.microsoft.com",
      "management.azure.com",
      "login.microsoftonline.com",
      "packages.microsoft.com"
    ]

    protocol {
      port = "443"
      type = "Https"
    }

    protocol {
      port = "80"
      type = "Http"
    }
  }

  rule {
    name = "osupdates"

    source_addresses = [
      azurerm_subnet.hub_subnet_1.address_prefixes[0],
      azurerm_subnet.hub_subnet_2.address_prefixes[0],
      azurerm_subnet.hub_subnet_3.address_prefixes[0],
      azurerm_subnet.spoke_subnet_1.address_prefixes[0],
    ]

    target_fqdns = [
      "download.opensuse.org",
      "security.ubuntu.com",
      "packages.microsoft.com",
      "snapcraft.io"
    ]

    protocol {
      port = "443"
      type = "Https"
    }

    protocol {
      port = "80"
      type = "Http"
    }
  }
}
