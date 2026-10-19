# Lab: Network Diagnostics and System Logs

## Objective

Practice basic network troubleshooting and learn where to look for system events on Linux.

## Environment

- Ubuntu 24.04 running under WSL2 on Windows
- Shell: Bash
- Scope: the user's own local Linux environment
- Commands in this lab are intended for inspection and do not change network or service configuration.

## Commands practiced

### 1. Inspect network interfaces

```bash
ip -br addr
```

Shows interfaces and their assigned addresses in a compact format.

### 2. Inspect routing

```bash
ip route
```

Shows the routing table, including the route used for traffic to destinations outside the local subnet.

### 3. Test DNS resolution

```bash
getent hosts example.com
```

Checks whether the system can resolve a hostname to an address using the system's configured name-service setup.

### 4. Test IP connectivity

```bash
ping -c 4 1.1.1.1
ping -c 10 1.1.1.1
```

Sends a limited number of ICMP echo requests and reports replies, round-trip times, and packet loss when available.

### 5. Inspect recent system journal entries

```bash
sudo journalctl -n 30 --no-pager
```

Displays the latest journal entries without opening an interactive pager.

### 6. Filter errors from the current boot

```bash
sudo journalctl -p err -b --no-pager
```

Shows journal entries at error priority or more severe for the current boot. An error entry is not automatically evidence of an attack; interpret it in context.

### 7. Inspect login history

```bash
last
```

Displays available login-history records. The amount of information available depends on the system and its logging configuration.

### 8. Look for failed-authentication messages in auth.log

```bash
sudo grep -i "failed" /var/log/auth.log 2>/dev/null | tail -n 20
```

Searches the standard authentication log file, if present. On some systems—including some WSL setups—this file may not exist or authentication events may be stored elsewhere. Empty output alone does not prove that no failed logins occurred.

## Observations

- The learner reported that the ping test to `1.1.1.1` received replies.
- The network-diagnostic and log-inspection commands were run during the exercise.
- Detailed command output was not included in this report, so no specific routing, DNS, error-log, or failed-login findings are claimed here.

## Lessons learned

- An IP ping can confirm reachability to that destination at that moment, but it does not prove that DNS or every internet service works.
- `ip addr` and `ip route` answer different questions: interface addressing versus packet routing.
- `getent hosts` checks hostname resolution through the configured name-service system.
- `journalctl` is useful for investigating system events, but log messages need context.
- Listening ports, errors, or failed-login strings should be investigated rather than automatically treated as vulnerabilities or attacks.
- WSL differs from a conventional Linux installation, so some services and log files may be absent or behave differently.

## Next steps

- Save selected output from each command after removing information you do not want to publish.
- Compare DNS resolution with IP connectivity if hostname lookups fail.
- Investigate an individual journal message by checking its service, timestamp, and surrounding entries.

## Safety

Only inspect systems you own or are authorized to administer. Do not publish passwords, tokens, or other secrets.
