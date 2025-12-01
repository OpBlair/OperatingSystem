# 📚 OS Learning Sandbox & Systems Trials

## 🌟 Project Overview

This repository is my dedicated workspace for mastering Operating System fundamentals, exploring various kernel configurations, and conducting systems-level programming trials.

My primary focus is the **exploration of general OS concepts** (memory management, scheduling, I/O) through practical experiments on different systems, including my daily **Arch Linux** environment and various test beds like NixOS and VMs.

## 🎯 Goals & Scope

The purpose of this project is to create a comprehensive log of my learning journey:

* **Understanding Core Concepts:** Deep dives into architecture, boot processes, and kernel design patterns common across Linux and other OSes.
* **Configuration Exploration:** Documenting and testing system configurations using declarative (NixOS) and imperative (Arch) approaches.
* **Hands-on Trials:** Running small, isolated code experiments (C, Assembly) to test specific OS concepts at the low level.
* **Foundation Building:** Gathering the necessary knowledge and code infrastructure for launching a future custom OS or kernel project.

## 📂 Repository Structure

| Directory | Purpose | Key Contents |
| :--- | :--- | :--- |
| `Linux-Configs/` | **System Configuration Files** | Various configuration files for Linux-based testing environments, including Arch packages, dotfiles, and VM setups. |
| `Linux-Configs/NixOS-Trial/` | **NixOS Experiment** | Contains the configuration files (like `configuration.nix`) for my declarative NixOS test bed environment. |
| `Learning-Notes/` | **Research & Theory** | Markdown files detailing theoretical learning, notes on OS concepts, and comparisons between different kernel types. |
| `Trials-Experiments/` | **Code Sandbox** | Small, isolated code snippets and programs used to test concepts (C, Assembly, bash scripting). |
| `Resources.md` | **Learning Path** | A comprehensive list of books, courses, and online documentation I am currently following. |

## 💻 Current Learning Focus

My focus is currently on:

1.  **Bootloaders:** Comparing GRUB configuration with systemd-boot to understand the stages of system startup.
2.  **Filesystems:** Exploring ext4 and Btrfs and their performance/reliability features.
3.  **Basic Systems Programming:** Implementing simple device simulations in C to prepare for kernel module development.

## 📁 NixOS Trial Configuration

The file located at `Linux-Configs/NixOS-Trial/configuration.nix` is an initial setup used to explore the **declarative configuration** paradigm in a controlled VMware environment.

*This file serves as a dedicated experiment in system reproducibility and service management, distinct from my main Arch setup.*

<!-- 
/
├── README.md                 <-- Overview of the project, goals, and current focus.
|
├── LICENSE                   <-- Choose a license (e.g., MIT, GPL).
|
├── NixOS-Config/             <-- Dedicated folder for your NixOS base system.
│   ├── configuration.nix     <-- **YOUR FILE GOES HERE!** The main system config.
│   ├── hardware-configuration.nix <-- NixOS's auto-generated hardware file.
│   └── profiles/             <-- (Optional) For specialized configs, e.g., 'desktop.nix'.
|
├── Learning-Notes/           <-- General OS learning and research.
│   ├── Memory-Management.md  <-- Markdown file for notes on that topic.
│   ├── Boot-Process.md       <-- Notes on GRUB, bootloaders, etc.
│   └── Resources.md          <-- List of links, books, and courses you are using.
|
└── Trials-Experiments/       <-- Small, non-NixOS-specific code trials.
    ├── C-Hello-World/        <-- Simple C programs to test compilation.
    ├── Assembly-Tests/       <-- Low-level assembly experiments.
    └── Kernel-Hacks/         <-- Small code changes to existing kernels (if you get there).
-->
