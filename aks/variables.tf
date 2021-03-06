variable "client_id" {}
variable "client_secret" {}

variable "agent_count" {
    default = 1
    #claster from 1 node
}

variable "dns_prefix" {
    default = "k8stest"
}

variable cluster_name {
    default = "k8stest"
}

variable resource_group_name {
    default = "azure-k8stest"
}

variable location {
    default = "Germany Central (Sovereign)"
}

