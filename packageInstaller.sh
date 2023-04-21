#!/bin/bash

# Check if the script is being run with superuser privileges
if [[ $(id -u) != 0 ]]; then
  echo "This script needs to be run with superuser privileges."
  exit 1
fi

# Detect package manager
if command -v apt-get &> /dev/null; then
  PACKAGE_MANAGER="apt-get"
elif command -v yum &> /dev/null; then
  PACKAGE_MANAGER="yum"
elif command -v dnf &> /dev/null; then
  PACKAGE_MANAGER="dnf"
elif command -v zypper &> /dev/null; then
  PACKAGE_MANAGER="zypper"
elif command -v pacman &> /dev/null; then
  PACKAGE_MANAGER="pacman"
elif command -v apk &> /dev/null; then
  PACKAGE_MANAGER="apk"
elif command -v eopkg &> /dev/null; then
  PACKAGE_MANAGER="eopkg"
elif command -v emerge &> /dev/null; then
  PACKAGE_MANAGER="emerge"
elif command -v xbps-install &> /dev/null; then
  PACKAGE_MANAGER="xbps-install"
elif command -v pkg &> /dev/null; then
  PACKAGE_MANAGER="pkg"
else
  echo "Unsupported package manager. Exiting..."
  exit 1
fi

# Function to install packages using APT
install_packages_with_apt() {
  echo "Installing packages with APT..."
  apt-get update
  apt-get -y install "$@"
}

# Function to install packages using YUM
install_packages_with_yum() {
  echo "Installing packages with YUM..."
  yum -y install "$@"
}

# Function to install packages using DNF
install_packages_with_dnf() {
  echo "Installing packages with DNF..."
  dnf -y install "$@"
}

# Function to install packages using Zypper
install_packages_with_zypper() {
  echo "Installing packages with Zypper..."
  zypper -n install "$@"
}

# Function to install packages using Pacman
install_packages_with_pacman() {
  echo "Installing packages with Pacman..."
  pacman -Syu --noconfirm "$@"
}

# Function to install packages using APK
install_packages_with_apk() {
  echo "Installing packages with APK..."
  apk update
  apk add --no-cache "$@"
}

# Function to install packages using eopkg
install_packages_with_eopkg() {
  echo "Installing packages with eopkg..."
  eopkg update-repo
  eopkg -y install "$@"
}

# Function to install packages using emerge
install_packages_with_emerge() {
  echo "Installing packages with emerge..."
  emerge --sync
  emerge -a "$@"
}

# Function to install packages using xbps-install
install_packages_with_xbps() {
  echo "Installing packages with xbps-install..."
  xbps-install -Syu
  xbps-install -y "$@"
}

# Function to install packages using pkg
install_packages_with_pkg() {
  echo "Installing packages with pkg..."
  pkg update
  pkg install -y "$@"
}

# Main script
if [[ $# -eq 0 ]]; then
  echo "No packages specified. Exiting..."
  exit 1
else
  echo "Resolving packages with $PACKAGE_MANAGER..."
  case $PACKAGE_MANAGER in
    "apt-get")
      install_packages_with_apt "$@"
      ;;
    "yum")
      install_packages_with_yum "$@"
      ;;
    "dnf")
      install_packages_with_dnf "$@"
      ;;
    "zypper")
      install_packages_with_zypper "$@"
      ;;
    "pacman")
      install_packages_with_pacman "$@"
      ;;
    "apk")
      install_packages_with_apk "$@"
      ;;
      "eopkg")
      install_packages_with_eopkg "$@"
      ;;
      "emerge")
      install_packages_with_emerge "$@"
      ;;
      "xbps-install")
      install_packages_with_xbps "$@"
      ;;
      "pkg")
      install_packages_with_pkg "$@"
      ;;
    *)
      echo "Unsupported package manager. Exiting..."
      exit 1
      ;;
  esac
fi

echo "Package installation script done."