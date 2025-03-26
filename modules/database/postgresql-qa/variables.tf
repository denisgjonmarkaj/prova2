### General Variables ###

variable "compartment_id" {
  description = "The OCID of the compartment where the PostgreSQL DB will be created"
  type        = string
}

variable "environment" {
  description = "The environment (dev, qa, prod)"
  type        = string
}


### Network Variables ###

variable "subnet_id" {
  description = "The OCID of the subnet where the PostgreSQL DB will be created"
  type        = string
}

variable "nsg_ids" {
  description = "List of Network Security Group OCIDs to associate with the PostgreSQL DB"
  type        = list(string)
  default     = []
}

### Database Configuration Variables ###


variable "display_name" {
  description = "Display name for the PostgreSQL DB"
  type        = string
  default     = "postgresql"
}

variable "db_version" {
  description = "The version of PostgreSQL"
  type        = string
  default     = "14"
}

variable "shape" {
  description = "The shape of the PostgreSQL DB system"
  type        = string
  default     = "PostgreSQL.VM.Standard.E5.Flex"
}

variable "cpu_core_count" {
  description = "The number of OCPUs"
  type        = number
  default     = 2
}

variable "memory_size_in_gbs" {
  description = "The amount of memory in GB"
  type        = number
  default     = 32
}

variable "instance_count" {
  description = "The number of PostgreSQL instances"
  type        = number
  default     = 1
}

### Storage variables###


variable "storage_system_type" {
  description = "The type of storage system"
  type        = string
  default     = "OCI_OPTIMIZED_STORAGE"
}

variable "is_regionally_durable" {
  description = "Whether the DB system is regionally durable"
  type        = bool
  default     = true
}

variable "availability_domain" {
  description = "The availability domain for the PostgreSQL DB (required only if is_regionally_durable = false)"
  type        = string
  default     = null
}

### Credentials ###


variable "db_admin_username" {
  description = "Username for the PostgreSQL DB admin"
  type        = string
  default     = "postgres"
}

variable "db_admin_password" {
  description = "Password for the PostgreSQL DB admin"
  type        = string
  sensitive   = true
}

### Variabili di backup ###

variable "backup_policy_kind" {
  description = "Tipo di policy di backup (NONE, DAILY, WEEKLY, MONTHLY)"
  type        = string
  default     = "WEEKLY"
}

variable "backup_start_time" {
  description = "Orario di inizio del backup in formato 24 ore (es. '00:30')"
  type        = string
  default     = "00:30"
}

variable "backup_retention_days" {
  description = "Numero di giorni di conservazione dei backup"
  type        = number
  default     = 31
}

variable "backup_days_of_week" {
  description = "Giorni della settimana per i backup (es. ['SUNDAY'])"
  type        = list(string)
  default     = ["SUNDAY"]
}

variable "backup_days_of_month" {
  description = "Giorni del mese per i backup (da 1 a 28)"
  type        = list(number)
  default     = [1]
}

