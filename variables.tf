

variable "api_name" {
  description = "API NAME"
  type        = string
}

variable "stage" {
  description = "stage name"
  type        = string

}

variable "email_list" {
  description = "email list"
  type = list(string)
}



