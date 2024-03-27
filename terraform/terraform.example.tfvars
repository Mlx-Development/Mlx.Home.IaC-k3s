xoa-pool=""
xoa-template=""
xoa-sr=""
xoa-network=""

linux-username = ""
linux-sshkeys = []

k3s-srvr-macs = []
k3s-srvr-memory = 4
k3s-srvr-cores = 2
k3s-srvr-storage = 50
k3s-srvr-basedescription = "k3s Server Node"
k3s-srvr-namelabel = "k3s Server"
k3s-srvr-tags = []
k3s-srvr-basehostname = "k3s-Srvr"
k3s-srvr-disklabel = "k3s-Srvr"

k3s-wrkr-macs = []
k3s-wrkr-memory = 8
k3s-wrkr-cores = 4
k3s-wrkr-storage = 250
k3s-wrkr-basedescription = "k3s Worker Node"
k3s-wrkr-namelabel = "k3s Worker"
k3s-wrkr-tags = []
k3s-wrkr-basehostname = "k3s-Wrkr"
k3s-wrkr-disklabel = "k3s-Wrkr"

k3s-ansb-sshkey = "/home/{{username}}/.ssh/k3s-ansb"
k3s-ansb-hostslocation = "../ansible/inventory/my-cluster/hosts.ini"
