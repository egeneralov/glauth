# glauth helm chart

Deploy [glauth](https://github.com/glauth/glauth) into kubernetes.

### checks

`livenessProbe` working on tcp port check. Also, if user with plaintext password is present - `readinessProbe` will be generated.

### Values

- **replicas**: `2`
- **image**: `registry.gitlab.com/egeneralov/glauth:master-1ce6755f17ae5462f03aea9fc0c4def23275fde8`
- **config**:
  - **debug**: `false`, boolean
  - **api**:
    - **enabled**: `false`, boolean
  
  - **ldap**:
    - **enabled**: `true`, boolean
  
  - **backend**:
    - **datastore**: `"config"`, only `config` now supported
    - **baseDN**: `"dc=example,dc=com"`
  
  - **ldaps**:
    - **enabled**: `false`, boolean
    - **cert**: `""`, path inside container
    - **key**: `""`, path inside container
  
  - **groups**:
    - **unixid**: `6001`
    - **name**: `"admins"`, group name
    - **includegroups**: `[]`, list of group ints

  - **users**: per user will be created group with same id. keep unixid == primarygroup.
    - **unixid**: `5001`
    - **primarygroup**: `5001`
    - **name**: `"glauth"`
    - **givenname**: `"glauth"`
    - **sn**: `"glauth"`
    - **mail**: `"glauth@glauth.glauth"`
    - **homeDir**: `"/home/glauth"`
    - **loginShell**: `"/bin/bash"`
    - **passsha256**: `""`, generate digest via `echo -n "password" | openssl dgst -sha256`. `password` field will be ignored, if current present.
    - **password**: `"glauth"`, or use plain-text password. (W: one user with plain-text password are required for readinessProbe to be present)
    - **otpsecret**: `""`, optional
    - **otherGroups**: `[]`, optional, []int
    - **sshPublicKey**: `[]`, optional, []string
