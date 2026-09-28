# Creating an Oracle password file

How to create the password file that allows remote SYSDBA connections.

> **Warning:** `orapwd` overwrites an existing password file. Keep the file readable only by the Oracle owner and never commit one to a repository.

```bash
orapwd file=$ORACLE_HOME/dbs/orapwhomo5 entries=5 (case sensetive)
```

---

*Copyright (c) 2026 Mohamed Dawood. MIT Licence; see LICENSE.*
