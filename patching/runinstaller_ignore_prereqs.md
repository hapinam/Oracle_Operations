# Running the installer without prerequisite checks

How to start the Oracle installer when a prerequisite check fails on an unsupported but known good platform.

> **Warning:** Skipping prerequisite checks means installing on a configuration Oracle has not certified. Only do it when Oracle Support tells you to, and record why.

```bash
./runInstaller -ignoreSysPrereqs
```

---

*Copyright (c) 2026 Mohamed Dawood. MIT Licence; see LICENSE.*
