```markdown
# WireGuard Full-Tunnel VPN Setup

This repository contains the configuration guides, implementation notes, and production-ready templates for deploying a high-performance, full-tunnel VPN utilizing WireGuard.

## 📁 Repository Structure

```text
wireguard-vpn/
├── README.md
└── configs/
    ├── server.conf.template
    └── client.conf.template

```

---

## Architectural Overview

* **Server:** Virtual Private Server (VPS) acting as the VPN Gateway.
* **Client:** Local Workstation routing all WAN traffic through the encrypted tunnel.
* **Routing Type:** **Full-Tunnel** (`0.0.0.0/0`), where all client traffic is encapsulated, sent to the server, masqueraded (NAT), and egressed out of the server's public IP interface.

---

## 1. Server-Side Deployment

### Installation & Key Generation

Update your package index, install the WireGuard tools, and generate the server-side cryptographic keypair:

```bash
sudo apt update && sudo apt install wireguard -y

# Generate key pair
wg genkey | sudo tee /etc/wireguard/server_private.key | wg pubkey | sudo tee /etc/wireguard/server_public.key
sudo chmod 600 /etc/wireguard/server_private.key

```

### Manual Interface Initialization

To quickly test and initialize the network interface manually:

```bash
# Create the virtual network interface
sudo ip link add dev wg0 type wireguard

# Assign the private network subnet IP
sudo ip addr add 10.10.10.1/28 dev wg0

# Bind the generated private key to the interface
sudo wg set wg0 private-key /etc/wireguard/server_private.key listen-port 41129

# Register the client peer (Replace <CLIENT_PUBLIC_KEY> with actual key)
sudo wg set wg0 peer <CLIENT_PUBLIC_KEY> allowed-ips 10.10.10.2/32

# Bring the interface up
sudo ip link set dev wg0 up

```

### Kernel Routing & NAT Configuration (Critical)

For the server to forward packets from the private WireGuard subnet out to the public internet, IP forwarding and Network Address Translation (NAT) must be enabled:

```bash
# Enable IPv4 Forwarding persistently
echo "net.ipv4.ip_forward=1" | sudo tee -a /etc/sysctl.conf
sudo sysctl -p

# Apply NAT rules via iptables (Assuming eth0 is the WAN interface)
sudo iptables -t nat -A POSTROUTING -s 10.10.10.0/28 -o eth0 -j MASQUERADE

# Persist iptables rules across reboots
sudo apt install iptables-persistent -y
sudo netfilter-persistent save

```

### Firewall & UFW Configuration

If utilizing UFW, ensure forwarding policies are explicitly permitted:

1. Open `/etc/default/ufw` and adjust the policy:

```text
DEFAULT_FORWARD_POLICY="ACCEPT"

```

2. Open the WireGuard communication port and reload:

```bash
sudo ufw allow 41129/udp
sudo ufw route allow in on wg0 out on eth0
sudo ufw reload

```

> [!IMPORTANT]
> **Cloud Provider Firewall:** You must also navigate to your Cloud Provider Firewall dashboard and allow **Inbound UDP Traffic on Port 41129** from any source (`0.0.0.0/0`).

---

## 2. Client-Side Deployment

### Installation & Key Generation

```bash
sudo dnf install wireguard-tools -y

# Generate client-side cryptographic keypair
wg genkey | tee wgclientprivate | wg pubkey > wgclientpublic
chmod 600 wgclientprivate

```

### Configuration File

Create a profile configuration file at `~/wg0-client.conf` (or directly within `/etc/wireguard/wg0.conf`):

```ini
[Interface]
PrivateKey = <YOUR_CLIENT_PRIVATE_KEY_STRING>
Address = 10.10.10.2/28
DNS = 1.1.1.1

[Peer]
PublicKey = <YOUR_SERVER_PUBLIC_KEY_STRING>
Endpoint = <SERVER_PUBLIC_IP>:41129
AllowedIPs = 0.0.0.0/0
PersistentKeepalive = 25

```

### Establish the Connection

Use the `wg-quick` utility wrapper to parse the profile and configure your client routing tables automatically:

```bash
sudo wg-quick up ~/wg0-client.conf

```

---

## 3. Verification & Troubleshooting

### Validating the Connection Status

Execute the `wg` utility to inspect your active tunnels, looking closely for data transfer counters and recent handshake timestamps:

```bash
sudo wg

```

### Output Matrix & Troubleshooting Indicators

| Symptom | Probable Root Cause | Resolution Metric |
| --- | --- | --- |
| **No Handshake** | Cloud Firewall dropping packets. | Verify Cloud Firewall dashboard inbound UDP 41129 rules. |
| **0 Bytes Received** | Handshake failed / Misconfigured endpoint. | Confirm public IP and port accuracy in Client Config. |
| **Ping works, WAN fails** | Missing NAT / Kernel IP forwarding disabled. | Ensure `ip_forward=1` is active and `iptables` rules match WAN interface. |
| **Curl command hangs** | MTU mismatch / Packet fragmentation. | Append `MTU = 1360` inside the `[Interface]` section of client configuration. |

### Verify Public Egress IP

Run a public IP check on the client machine to ensure traffic is exiting via the VPS gateway:

```bash
curl ifconfig.me
# Expected Output: <SERVER_PUBLIC_IP>

```

---

## 4. Repository Deployment Templates

To deploy using automated infrastructure configurations rather than manual interface routing commands, utilize the following raw templates located within the `configs/` directory.

### `configs/server.conf.template`

server[/configs/server.conf.template]
```

### `configs/client.conf.template`

client[/configs/client.conf.template]