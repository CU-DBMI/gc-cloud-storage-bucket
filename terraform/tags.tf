# tf for google cloud tags
resource "google_tags_tag_key" "key" {
  parent     = "organizations/${var.project}"
  short_name = var.initiative_label
}

resource "google_tags_tag_value" "value" {
  parent     = "tagKeys/${google_tags_tag_key.key.name}"
  short_name = var.initiative_label
}

resource "google_tags_tag_binding" "binding" {
  parent    = "//cloudresourcemanager.googleapis.com/projects/${data.google_project.project.number}"
  tag_value = "tagValues/${google_tags_tag_value.value.name}"
}
