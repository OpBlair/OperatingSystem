# Docker Disaster Recovery (DR) & Failover Simulation

A simple Disaster Recovery (DR) and failover simulation built using Docker Compose and Nginx.

## Overview

This project demonstrates a basic active-passive disaster recovery setup.

The architecture consists of:

- Primary Data Center
- Secondary (Backup) Data Center
- Nginx Load Balancer

When the primary data center becomes unavailable, Nginx automatically redirects incoming requests to the backup server.

---

## Architecture

```

            Client
               |
               |
        Nginx Load Balancer
               |
      -----------------------
      |                     |
      |                     |
Primary Data Center   Secondary Data Center
     (Active)             (Backup)

```

---

## Technologies

- Docker Compose
- Nginx
- HTML

---

## Project Structure

```

.
├── docker-compose.yml
├── nginx.conf
├── primary.html
├── secondary.html
└── README.md

```

---

## Getting Started

Clone the repository:

```bash
git clone https://github.com/OpBlair/OperatingSystem.git
```

Navigate to the project:

```bash
cd OperatingSystem/Disaster_Recovery_Simulation
```

Start the containers

```bash
docker compose up -d
```

Open

```
http://localhost:8080
```

You should see the Primary Data Center page.

---

## Simulating Disaster Recovery

Stop the primary server.

```bash
docker compose stop primary_dc
```

Refresh the browser.

Nginx will detect that the primary server is unavailable and automatically route requests to the backup data center.

To restore the primary:

```bash
docker compose start primary_dc
```

---

## Future Improvements

- Database replication
- Automatic health monitoring
- Stateful applications
- Transaction simulation
- Split-brain simulation
- Keepalived / VRRP
- Kubernetes implementation
- Multi-region deployment

---

## Learning Objectives

This project helped me understand:

- Disaster Recovery (DR)
- High Availability (HA)
- Active-Passive Failover
- Reverse Proxying
- Docker Networking
- Nginx Upstreams
- Health Checks
- Traffic Routing

---

## Disclaimer

This is an educational project intended to demonstrate DR and failover concepts using Docker and Nginx. It is not a production-ready disaster recovery solution.
