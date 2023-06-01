# This code is auto generated and any changes will be lost if it is regenerated.

# -- Copyright: Copyright (c) 2020, 2022, Oracle and/or its affiliates.
# ---- Author : Andrew Hopkinson (Oracle Cloud Solutions A-Team)

# ------ Retrieve Regional / Cloud Data
# -------- Get a list of Availability Domains
data "oci_identity_availability_domains" "AvailabilityDomains" {
    compartment_id = var.compartment_ocid
}
# -------- Get a list of Fault Domains
data "oci_identity_fault_domains" "FaultDomainsAD1" {
    availability_domain = element(data.oci_identity_availability_domains.AvailabilityDomains.availability_domains, 0)["name"]
    compartment_id = var.compartment_ocid
}
data "oci_identity_fault_domains" "FaultDomainsAD2" {
    availability_domain = element(data.oci_identity_availability_domains.AvailabilityDomains.availability_domains, 1)["name"]
    compartment_id = var.compartment_ocid
}
data "oci_identity_fault_domains" "FaultDomainsAD3" {
    availability_domain = element(data.oci_identity_availability_domains.AvailabilityDomains.availability_domains, 2)["name"]
    compartment_id = var.compartment_ocid
}
data "oci_identity_regions" "Regions" {
}
# ------ Get List Service OCIDs
data "oci_core_services" "RegionServices" {
}
# ------ Get All Service OCID
data "oci_core_services" "AllRegionServices" {
    filter {
        name = "cidr_block"
        values = ["all-*"]
        regex = true
    }
}
locals {
    all_services_id                     = data.oci_core_services.AllRegionServices.services[0].id
    all_services_destination            = data.oci_core_services.AllRegionServices.services[0].cidr_block
}
# ------ Get Object Storage Service OCID
data "oci_core_services" "ObjectStorageRegionServices" {
    filter {
        name = "cidr_block"
        values = ["\\w*objectstorage"]
        regex = true
    }
}
locals {
    objectstorage_services_id           = data.oci_core_services.ObjectStorageRegionServices.services[0].id
    objectstorage_services_destination  = data.oci_core_services.ObjectStorageRegionServices.services[0].cidr_block
}
# ------ Get List Images
data "oci_core_images" "InstanceImages" {
    compartment_id           = var.compartment_ocid
}
