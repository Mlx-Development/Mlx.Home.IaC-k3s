xoa-pool="xcp-ng"
xoa-template="Debian 12 Cloud-init (Hub)"
xoa-sr="zfs-main"
xoa-network="VLAN 1017"

linux-username = "lemonsml"
linux-sshkeys = [
  "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCvojJgPzT2tEmJ07nqZS/rVSmifZU4H7TFE3F961zq1mJqpHDw8ucaVcXRnc8RYGmCu1/C5xY04qJRZLOBHJtK4AYovMNNe/0ROG11j0LoqsGSGtyKg2i7jjGJCRL1X4tX70+q3onqLCmm2kdHdSozZLL4sMweDixC9mlqeBxxYY0x1os0pzfxJigcVw+UI3aCRpgaoJVViVhy0ECWTMbjA+IWUwvB+9dXqQ2BsBphbXxWM3H9TRwf/KC2rBonM6kk2YmqrkBIKdPgBnWFDi8CruvfYm/Bt6ZVijeF1/OvM8CnIewBT57Zf+5HmIGcwAwaLIS9W7mGKdbw6n79SCnVzO8KCcZJFPGUEW8m0xjAzLT6vRFJY0P3C1rs0UceJe6e3tDCnVnxsWWnC5msVdVuVSBJcQPWIdLJTeLO5fzH9G1LeubVyzm4N8H8K7nTF8v1mmgRnLcK/JJ536pyXDEQ6cPZxWzGtDeykAPNEfcgh2vaOfLgsaY5rgerca7mNbE= mlxhome\\lemonsml@MLX-LEMONSML-00"  , "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDMHzrVvMNsUdvK5OPOcQKKuVtOFQ9qcYAn2aPa1f/TVozN93nt41HLa/nVoRddvfIN+Cr2U4DVGqV1GA0ArMWlkYsQZ7Et2p5NFjWG01qQBN6xj2TXv5qR5fIqDJ/kteyQIkaxb06YIZlG19tmbGveOajwNohvM8TwFh9/cymwIlZwC7pqpNPYuC0AxUdw+5T9+8KdMnhYRUOazBMiufiqOGWPkL/Kfcp8+maTFSENpRODJIIdCOJrzeFmKe8j2WXYy3+eo89uAMZGxlV9ZSF5wys6ZcGtGcEB8Slz8c9H/0qOjs5VTxWnfl1oDBX3AHS33Nh5Jot6ju9f+dtMHaHI51ffDtXBjz22d1Z37wEfStamd+J+3XKsI0e928YbnN6qMEZhh7/gxWj4oXVkRaBO3njxD1FVLE+ZCtWRuPMS9sFwzwilWbCACajj83A3/YU/xfnS9mP2DZt33cJ0mR2KU6QNnZo4Ido+JfBIg2Flx4M9FkqPs0S8vOlFo30IINc= ubuntu@MLX-UBNT20-Dev"]

k3s-srvr-macs = [ "c0:71:7b:ce:ef:b0", "ac:ea:9f:15:24:a3", "d6:e7:30:91:af:e7"]
k3s-srvr-memory = 4
k3s-srvr-cores = 2
k3s-srvr-storage = 50
k3s-srvr-basedescription = "k3s Server Node"
k3s-srvr-namelabel = "MLX-DEB12-k3s-Srvr"
k3s-srvr-tags = ["MlxKube", "Deb12", "KubeSrvr"]
k3s-srvr-basehostname = "MLX-DEB12-k3s-Srvr"
k3s-srvr-disklabel = "MLX-DEB12-k3s-Srvr"

k3s-wrkr-macs = ["48:d1:44:c4:7a:84", "60:aa:ed:35:d9:6e", "8c:4d:39:ab:54:8f", "78:59:f8:6c:ab:1a", "e2:4f:32:0c:e7:2a"]
k3s-wrkr-memory = 8
k3s-wrkr-cores = 4
k3s-wrkr-storage = 250
k3s-wrkr-basedescription = "k3s Worker Node"
k3s-wrkr-namelabel = "MLX-DEB12-k3s-Wrkr"
k3s-wrkr-tags = ["MlxKube", "Deb12", "KubeWrkr"]
k3s-wrkr-basehostname = "MLX-DEB12-k3s-Wrkr"
k3s-wrkr-disklabel = "MLX-DEB12-k3s-Wrkr"

k3s-ansb-sshkey = "/home/lemonsml/.ssh/k3s-ansb"
k3s-ansb-hostslocation = "../ansible/inventory/my-cluster/hosts.ini"
