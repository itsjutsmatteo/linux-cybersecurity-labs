# Services and Listening Sockets — Ubuntu on WSL2

## Goal
Compare listening TCP/UDP sockets with the running services reported by systemd.

## Environment
- Ubuntu running under WSL2
- Commands used: `ss -tulp` and `systemctl --type=service --state=running`

## Observations

### Listening sockets
The socket listing showed:
- DNS-related listeners displayed as `domain` on port 53, bound to local/virtual addresses including `127.0.0.53`, `127.0.0.54`, and `10.255.255.254`.
- UDP sockets on port 323 bound to loopback addresses `127.0.0.1` and `::1`.
- TCP sockets in `LISTEN` state on port 53.

The name `domain` is the service-name label for port 53; it is not itself proof of which process owns the socket.

### Running services
The running service list included:
- `chrony.service` — time synchronization service/client-server.
- `cron.service` — scheduled task daemon.
- `dbus.service` — system message bus.
- `rsyslog.service` and `systemd-journald.service` — logging.
- `systemd-resolved.service` — network name resolution.
- `unattended-upgrades.service` — automatic installation of certain updates.
- Other system/session services such as `systemd-logind`, `systemd-udevd`, and `user@1000.service`.

The presence of `chrony` alongside UDP port 323 is consistent with chrony commonly using that port for its command interface, but the socket listing alone did not show process ownership. Confirm ownership before making a definitive attribution.

## Lessons learned
- A running service is a program managed by the service manager; it may or may not listen on a network port.
- A listening socket is an endpoint bound to an address and port; it does not automatically indicate a vulnerability.
- Port 53 is commonly used for DNS. The output's `domain` label corresponds to that port.
- Loopback-bound sockets are intended for local communication, while sockets bound to other addresses may have different exposure depending on routing, firewall, and WSL networking.

## Reproduce
```bash
ss -tulp
systemctl --type=service --state=running
```

## Scope and limitations
This is basic service and socket enumeration, not a full security audit. The results are a snapshot from this WSL2 environment. Confirm process ownership and network reachability before drawing security conclusions.
