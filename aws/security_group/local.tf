locals {
    due = formatdate("YYYYMMDD", time_static.date.rfc3339)

    allowedHosts = {
        host1: {
            "cidr_block" = "18.176.45.101/32",
            "description" = "JP Data Center"
        },
        host2: {
            "cidr_block" = "3.66.45.94/32",
            "description" = "EU Data Center"
        },
        host3: {
            "cidr_block" = "13.215.42.244/32",
            "description" = "SG Data Center"
        },        
        host4: {
            "cidr_block" = "34.226.132.221/32",
            "description" = "US Data Center"
        },
        host5: {
            "cidr_block" = "3.65.225.246/32",
            "description" = "EU Data Center"
        },                
        host6: {
            "cidr_block" = "13.236.115.248/32",
            "description" = "AU Data Center"
        },
        host7: {
            "cidr_block" = "34.196.38.33/32",
            "description" = "AWS VPN Client"
        },                           
        host8: {
            "cidr_block" = "13.113.30.44/32",
            "description" = "JP Data Center"
        },
        host9: {
            "cidr_block" = "52.74.226.121/32",
            "description" = "SG Data Center"
        },
        host10: {
            "cidr_block" = "18.141.131.114/32",
            "description" = "SG Data Center"
        },                
        host11: {
            "cidr_block" = "52.193.168.95/32",
            "description" = "JP Data Center"
        },
        host12: {
            "cidr_block" = "18.198.249.58/32",
            "description" = "EU Data Center"
        },                
        host13: {
            "cidr_block" = "54.253.214.156/32",
            "description" = "AU Data Center"
        },
        host14: {
            "cidr_block" = "52.5.142.59/32",
            "description" = "US Data Center"
        },                           
        host15: {
            "cidr_block" = "13.238.90.15/32",
            "description" = "AU Data Center"
        },
        host17: {
            "cidr_block" = "52.54.43.157/32",
            "description" = "US Data Center"
        }
    }
}
