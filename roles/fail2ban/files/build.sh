#!/bin/bash

set -ex

docker build --iidfile iid .

TMP_CONTAINER=$(docker create $(cat iid))

docker cp "${TMP_CONTAINER}:/home/rpmbuild/rpmbuild/RPMS/noarch/fail2ban-server-0.10.4-1.el7.noarch.rpm" .
docker cp "${TMP_CONTAINER}:/home/rpmbuild/rpmbuild/RPMS/noarch/fail2ban-systemd-0.10.4-1.el7.noarch.rpm" .
docker cp "${TMP_CONTAINER}:/home/rpmbuild/rpmbuild/RPMS/noarch/fail2ban-firewalld-0.10.4-1.el7.noarch.rpm" .

docker rm "${TMP_CONTAINER}"
rm iid
