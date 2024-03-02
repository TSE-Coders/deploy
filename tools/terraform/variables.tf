variable "datadog_api_key" {
  description = "Datadog API Key"
  type        = string
}

variable "hostname" {
  description = "The hostname you want the server to have"
  type        = string
}

variable "frontend" {
  description = "The project that should be used for running the frontend service"
  type        = string
  default     = "https://github.com/TSE-Coders/pd-client-service.git"
}

variable "backend" {
  description = "The project that should be used for running the backend service"
  type        = string
  default     = "https://github.com/TSE-Coders/pd-users-api.git"
}

variable "zendesk" {
  description = "The project that should be used for running the zendesk service"
  type        = string
  default     = "https://github.com/TSE-Coders/ZD.git"
}
