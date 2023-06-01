
# ------ Create Autonomous Database
resource "oci_database_autonomous_database" "Okit_AD_1684734039848" {
    #Required
    admin_password           = "Admin#112233"
    compartment_id           = local.DeploymentCompartment_id
    cpu_core_count           = "1"
    data_storage_size_in_tbs = "1"
    db_name                  = "okitad009"

    #Optional
    display_name             = "okit-ad009"
    subnet_id                = local.Okit_S_1684734033775_id
    db_workload              = "OLTP"
    is_auto_scaling_enabled  = true
    is_free_tier             = false
#    is_preview_version_with_service_terms_accepted = 
    license_model            = "LICENSE_INCLUDED"
    private_endpoint_label    = "okit-ad009"
    freeform_tags            = {"okit_version": "0.50.1", "okit_model_id": "okit-model-fd3f6923-7889-49db-8924-a1450d55ad37", "okit_reference": "okit-108f9fe4-94c4-4d7b-9727-7f4fe321a9b5"}
}

