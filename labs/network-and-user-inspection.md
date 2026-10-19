# Network and User Inspection — Ubuntu on WSL2

## Goal
Practice inspecting the current Linux user, group memberships, network interfaces, and listening sockets using standard Linux commands.

## Environment
- User: `matteo`
- Distribution: Ubuntu 24.04.5 LTS under WSL2
- Commands used: `whoami`, `id`, `ip addr`, `ss -tuln`

## Observations

### User and groups
- `whoami` returned `matteo`.
- `id` reported UID 1000 and primary GID 1000, both named `matteo`.
- The account belongs to the `sudo` group, along with `adm`, `cdrom`, `dip`, `plugdev`, and `users`.

Group membership indicates potential permissions, not that every command runs with administrator privileges. Use elevated privileges only when needed.

### Network interfaces
- `lo` is the loopback interface and has IPv4 address `127.0.0.1/8`; the output also showed `10.255.255.254/32` on this interface.
- `eth0` was UP and had IPv4 address `172.29.130.108/20`.
- The environment is WSL2, so its virtual network view may differ from the Windows host's network configuration.

### Listening sockets
The `ss -tuln` output showed DNS-related TCP/UDP listeners on local addresses and port 53, including `127.0.0.53`, `127.0.0.54`, and `10.255.255.254`. It also showed UDP port 323 bound to loopback addresses.

These entries alone do not establish a vulnerability. Port 53 is commonly used for DNS; the exact service and exposure should be confirmed before drawing conclusions. The displayed addresses are local/virtual environment addresses, and this command does not show every possible aspect of Windows-host networking.

## Commands to reproduce

```bash
whoami
id
ip addr
ss -tuln
```

## Lessons learned
- `whoami` identifies the current user; `id` adds UID, GID, and group memberships.
- `ip addr` shows network interfaces and assigned addresses.
- `ss -tuln` lists listening TCP/UDP sockets numerically without resolving service names.
- A listening socket is not automatically a security issue. Interpretation depends on the owning service, the bind address, firewall and forwarding rules, and the environment.

## Scope and limitations
This is a basic inspection exercise, not a penetration test or full security assessment. Results are a snapshot from one Ubuntu WSL2 environment and can change over time.
