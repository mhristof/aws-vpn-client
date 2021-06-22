MAKEFLAGS += --warn-undefined-variables --jobs=$(shell nproc)
SHELL := /bin/bash
.SHELLFLAGS := -eu -o pipefail -c
.DEFAULT_GOAL := help
.ONESHELL:

.PHONY: help
help: ## Show this help.
	@grep '.*:.*##' Makefile | grep -v grep  | sort | sed 's/:.* ##/:/g' | column -t -s:

setup:
	apt-get install -y wget patch gcc libssl-dev net-tools liblzo2-dev libpam0g-dev automake

.PHONY: openvpn
openvpn: ./openvpn-2.4.9/src/openvpn/openvpn

./openvpn-2.4.9/bin/openvpn: ./openvpn-2.4.9/Makefile
	cd openvpn-2.4.9 && make

./openvpn-2.4.9/Makefile: ./openvpn-2.4.9/configure.ac.orig
	cd openvpn-2.4.9 && ./configure

openvpn-2.4.9/configure.ac.orig: openvpn-2.4.9
	cd openvpn-2.4.9 && patch -p1 < ../openvpn-v2.4.9-aws.patch --backup

openvpn-2.4.9: openvpn-2.4.9.tar.gz
	tar xvf openvpn-2.4.9.tar.gz

openvpn-2.4.9.tar.gz:
	wget https://swupdate.openvpn.org/community/releases/openvpn-2.4.9.tar.gz

clean:
	rm -r openvpn-2.4.9.tar.gz openvpn-2.4.9 
