# ops-sachet


Allows you to deploy sachet sms alerts for alertmanager.

Expects "DC" and "SACHET-CONFIG" env variables.

Example:

```
levant deploy -address=http://your-nomad-installation-or-cluster:4646 -var-file=vars.yaml sachet.nomad
```
