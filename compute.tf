
# image_source 
# ------ Get List Images
data "oci_core_images" "Okit_I_1684734036727Images" {
    compartment_id           = var.compartment_ocid
    operating_system         = "Oracle Linux"
    operating_system_version = "8"
    shape                    = "VM.Standard.E4.Flex"
}
locals {
    Okit_I_1684734036727_image_id = data.oci_core_images.Okit_I_1684734036727Images.images[0]["id"]
}

# ------ Create Instance
resource "oci_core_instance" "Okit_I_1684734036727" {
    # Required
    compartment_id      = local.DeploymentCompartment_id
    shape               = "VM.Standard.E4.Flex"
    # Optional
    display_name        = "okit-in008"
    availability_domain = data.oci_identity_availability_domains.AvailabilityDomains.availability_domains["1" - 1]["name"]
    create_vnic_details {
        # Required
        subnet_id        = local.Okit_S_1684734033775_id
        # Optional
        assign_public_ip = true
        display_name     = "okit-in008 Vnic"
        hostname_label   = "okitin0080522"
        skip_source_dest_check = false
        freeform_tags    = {"okit_version": "0.50.1", "okit_model_id": "okit-model-fd3f6923-7889-49db-8924-a1450d55ad37", "okit_reference": "okit-ba5e9f5c-292d-47e7-9b16-dc558f33fc01"}
    }
    fault_domain = "FAULT-DOMAIN-1"
    metadata = {
        ssh_authorized_keys = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCaskZHxHWm/fYfGw+cBC4Ng4uj/ZBv6tHTnOADnfcEyQENEYHjt1jj0aXw7qag/tWBOOKh7/rmYQhfxSWJnXnp+c78wGP9SwvLMiCqr02MAvBT+aT0F7YwL7DB/hC2f5CSoIStQWrh/WM5wUwNIE0IjZasnY6IcY/tldbLaqdrj9N5hUCOuVS6i7KPDl3shwuauILgxUYjwBW0lUTTKTZYWmVhYPGCRTDDRrfL49T0zGz3yy01PSMkYSs075sUDkTRS6C/n0g/8aJ9zxTy2ymahiNYELYFaAxkzFHYdFgfcrXytk7eRLAgB0WPgfS4pruwZlMKtvxTmoNrDZYwf7dZ ssh-key-2023-04-13"
    }
    shape_config {
        #Optional
        memory_in_gbs = "8"
        ocpus = "1"
    }
    source_details {
        # Required
        source_id               = local.Okit_I_1684734036727_image_id
        source_type             = "image"
        # Optional
        boot_volume_size_in_gbs = "50"
#        kms_key_id              = 
    }
    preserve_boot_volume = false
    freeform_tags              = {"okit_version": "0.50.1", "okit_model_id": "okit-model-fd3f6923-7889-49db-8924-a1450d55ad37", "okit_reference": "okit-ba5e9f5c-292d-47e7-9b16-dc558f33fc01"}
}

data "oci_core_private_ips" "Okit_I_1684734036727_private_ip" {
    #Optional
    ip_address = oci_core_instance.Okit_I_1684734036727.private_ip
    subnet_id = local.Okit_S_1684734033775_id
}

locals {
    Okit_I_1684734036727_id               = oci_core_instance.Okit_I_1684734036727.id
    Okit_I_1684734036727_public_ip        = oci_core_instance.Okit_I_1684734036727.public_ip
    Okit_I_1684734036727_private_ip       = oci_core_instance.Okit_I_1684734036727.private_ip
    Okit_I_1684734036727_display_name     = oci_core_instance.Okit_I_1684734036727.display_name
    Okit_I_1684734036727_compartment_id   = oci_core_instance.Okit_I_1684734036727.compartment_id
    Okit_I_1684734036727_hostname         = "okitin0080522"
    Okit_I_1684734036727_primary_vnic_id  = data.oci_core_private_ips.Okit_I_1684734036727_private_ip.private_ips[0].vnic_id
}

output "Okit_I_1684734036727PublicIP" {
    value = [local.Okit_I_1684734036727_display_name, local.Okit_I_1684734036727_public_ip]
}

output "Okit_I_1684734036727PrivateIP" {
    value = [local.Okit_I_1684734036727_display_name, local.Okit_I_1684734036727_private_ip]
}

# ------ Create Block Storage Attachments

# ------ Create VNic Attachments
resource "oci_core_vnic_attachment" "Okit_I_1684734036727VnicAttachment2" {
    #Required
    create_vnic_details {
        #Required
        subnet_id        = local.Okit_S_1684734033775_id
        #Optional
        display_name     = "okit-in008 Vnic"
        assign_public_ip = false
        freeform_tags    = {"okit_version": "0.50.1", "okit_model_id": "okit-model-fd3f6923-7889-49db-8924-a1450d55ad37", "okit_reference": "okit-ba5e9f5c-292d-47e7-9b16-dc558f33fc01"}
        hostname_label   = "okitin0080522"
        skip_source_dest_check = false
    }
    instance_id = local.Okit_I_1684734036727_id

    #Optional
    display_name = "okit-in008 Vnic"
}

