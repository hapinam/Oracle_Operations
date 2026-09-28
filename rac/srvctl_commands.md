# srvctl commands

Common `srvctl` commands for starting, stopping and inspecting clustered databases, listeners and VIPs.

> **Warning:** `srvctl stop database` shuts down every instance of the cluster database.

```bash
srvctl stop database -d ORCLCDB
srvctl start database -d ORCLCDB
srvctl stop listener

srvctl config vip -n node1
srvctl config database -v
```

---

*Copyright (c) 2026 Mohamed Dawood. MIT Licence; see LICENSE.*
