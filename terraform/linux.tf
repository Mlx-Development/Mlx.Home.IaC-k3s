variable "linux-username"{
  type = string
  description = "Linux - Admin Username for later ssh"
}

variable "linux-sshkeys"{
  type = list(string)
  description = "Linux - SSH Keys for Auth on Admin Username"
}
