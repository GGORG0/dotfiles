# Sudo

There is 1 config option in the zsh's `exportrc` file. The rest of my config is in `/etc/sudoers`:

```
Defaults passprompt="[sudo] password for %p: "
Defaults passwd_tries=5
Defaults passwd_timeout=0
Defaults timestamp_timeout=10
```
