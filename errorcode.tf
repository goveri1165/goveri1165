resource "google_storage_bucket" "sample_bucket1165" {
   name          = "poc-gcs-prisma-policy-test-2"
   project       = var.project_id
   location      = var.region
   force_destroy = true
   versioning {
      enabled = false
   }
}

resource "random_id" "db_name_suffix" {
  byte_length = 4
}

resource "google_sql_database_instance" "main" {
  name             = "main-instance-${random_id.db_name_suffix.hex}"
  database_version = "MYSQL_5_7"

  settings {
    tier = "db-f1-micro"
  }
}

resource "google_sql_user" "users" {
  name     = "me"
  instance = google_sql_database_instance.main.name
  host     = "me.com"
  password = "changeme"
}
