
# ------ Create Dhcp Options
# ------- Update VCN Default DHCP Option
resource "oci_core_default_dhcp_options" "Okit_DO_1684734028588" {
    # Required
    manage_default_resource_id = local.Okit_VCN_1684734028585_default_dhcp_options_id
    options    {
        type  = "DomainNameServer"
        server_type = "VcnLocalPlusInternet"
    }
    options    {
        type  = "SearchDomain"
        search_domain_names      = ["okitvcn.oraclevcn.com"]
    }
    # Optional
    display_name   = "okit-do006-0522"
    freeform_tags  = {"okit_version": "0.50.1", "okit_model_id": "okit-model-fd3f6923-7889-49db-8924-a1450d55ad37", "okit_reference": "okit-4dae4d2d-2ad3-451d-ab3a-d9fd7069899c"}
}

locals {
    Okit_DO_1684734028588_id = oci_core_default_dhcp_options.Okit_DO_1684734028588.id
    }


# ------ Create Internet Gateway
resource "oci_core_internet_gateway" "Okit_IG_1684734309007" {
    # Required
    compartment_id = local.DeploymentCompartment_id
    vcn_id         = local.Okit_VCN_1684734028585_id
    # Optional
    enabled        = true
    display_name   = "okit-ig010-0522"
    freeform_tags  = {"okit_version": "0.50.1", "okit_model_id": "okit-model-fd3f6923-7889-49db-8924-a1450d55ad37", "okit_reference": "okit-3f379753-4a5a-4ee1-8f03-fc2153532707"}
}

locals {
    Okit_IG_1684734309007_id = oci_core_internet_gateway.Okit_IG_1684734309007.id
}


# ------ Create Route Table
# ------- Update VCN Default Route Table
resource "oci_core_default_route_table" "Okit_RT_1684734028586" {
    # Required
    manage_default_resource_id = local.Okit_VCN_1684734028585_default_route_table_id
    route_rules    {
        destination_type  = "CIDR_BLOCK"
        destination       = "0.0.0.0/0"
        network_entity_id = local.Okit_IG_1684734309007_id
    }
    # Optional
    display_name   = "okit-rt004-0522"
    freeform_tags  = {"okit_version": "0.50.1", "okit_model_id": "okit-model-fd3f6923-7889-49db-8924-a1450d55ad37", "okit_reference": "okit-f36974c7-3e88-4924-9d8e-c05b17c09cba"}
}

locals {
    Okit_RT_1684734028586_id = oci_core_default_route_table.Okit_RT_1684734028586.id
    }


# ------ Create Security List
# ------- Update VCN Default Security List
resource "oci_core_default_security_list" "Okit_SL_1684734028587" {
    # Required
    manage_default_resource_id = local.Okit_VCN_1684734028585_default_security_list_id
    egress_security_rules {
        # Required
        protocol    = "all"
        destination = "0.0.0.0/0"
        # Optional
        destination_type  = "CIDR_BLOCK"
    }
    ingress_security_rules {
        # Required
        protocol    = "6"
        source      = "0.0.0.0/0"
        # Optional
        source_type  = "CIDR_BLOCK"
        tcp_options {
            min = "22"
            max = "22"
        }
    }
    ingress_security_rules {
        # Required
        protocol    = "1"
        source      = "0.0.0.0/0"
        # Optional
        source_type  = "CIDR_BLOCK"
        icmp_options {
            type = "3"
            code = "4"
        }
    }
    ingress_security_rules {
        # Required
        protocol    = "1"
        source      = "10.0.0.0/16"
        # Optional
        source_type  = "CIDR_BLOCK"
        icmp_options {
            type = "3"
        }
    }
    # Optional
    display_name   = "okit-sl005-0522"
    freeform_tags  = {"okit_version": "0.50.1", "okit_model_id": "okit-model-fd3f6923-7889-49db-8924-a1450d55ad37", "okit_reference": "okit-645fc231-479d-49a9-ae7a-0482c6beed45"}
}

locals {
    Okit_SL_1684734028587_id = oci_core_default_security_list.Okit_SL_1684734028587.id
}


# ------ Create Subnet
# ---- Create Public Subnet
resource "oci_core_subnet" "Okit_S_1684734033775" {
    # Required
    compartment_id             = local.DeploymentCompartment_id
    vcn_id                     = local.Okit_VCN_1684734028585_id
    cidr_block                 = "10.0.0.0/24"
    # Optional
    display_name               = "okit-sn007-0522"
    dns_label                  = "okitsn"
    security_list_ids          = [local.Okit_SL_1684734028587_id]
    route_table_id             = local.Okit_RT_1684734028586_id
    dhcp_options_id            = local.Okit_DO_1684734028588_id
    prohibit_public_ip_on_vnic = false
    freeform_tags              = {"okit_version": "0.50.1", "okit_model_id": "okit-model-fd3f6923-7889-49db-8924-a1450d55ad37", "okit_reference": "okit-fada286f-6d24-4c58-ac89-95ff4ad871c7"}
}

locals {
    Okit_S_1684734033775_id              = oci_core_subnet.Okit_S_1684734033775.id
    Okit_S_1684734033775_domain_name     = oci_core_subnet.Okit_S_1684734033775.subnet_domain_name
    Okit_S_1684734033775_netmask         = substr(oci_core_subnet.Okit_S_1684734033775.cidr_block, -2, -1)
    Okit_S_1684734033775_cidr_block      = "10.0.0.0/24"
}


# ------ Create Virtual Cloud Network
resource "oci_core_vcn" "Okit_VCN_1684734028585" {
    # Required
    compartment_id = local.DeploymentCompartment_id
    cidr_blocks    = ["10.0.0.0/16"]
    # Optional
    dns_label      = "okitvcn0522"
    display_name   = "okit-vcn-0522-01"
    freeform_tags  = {"okit_version": "0.50.1", "okit_model_id": "okit-model-fd3f6923-7889-49db-8924-a1450d55ad37", "okit_reference": "okit-0056496a-151a-4d0d-834a-1973cb570b02"}
    is_ipv6enabled  = false
}

locals {
    Okit_VCN_1684734028585_id                       = oci_core_vcn.Okit_VCN_1684734028585.id
    Okit_VCN_1684734028585_dhcp_options_id          = oci_core_vcn.Okit_VCN_1684734028585.default_dhcp_options_id
    Okit_VCN_1684734028585_domain_name              = oci_core_vcn.Okit_VCN_1684734028585.vcn_domain_name
    Okit_VCN_1684734028585_default_dhcp_options_id  = oci_core_vcn.Okit_VCN_1684734028585.default_dhcp_options_id
    Okit_VCN_1684734028585_default_security_list_id = oci_core_vcn.Okit_VCN_1684734028585.default_security_list_id
    Okit_VCN_1684734028585_default_route_table_id   = oci_core_vcn.Okit_VCN_1684734028585.default_route_table_id
}

