FROM centos:7

RUN yum install -y rpmdevtools yum-utils redhat-rpm-config epel-release
RUN yum-builddep -y fail2ban
RUN useradd -Um rpmbuild

USER rpmbuild
WORKDIR /home/rpmbuild
RUN rpmdev-setuptree
RUN yumdownloader --source fail2ban
RUN rpm -Uvh fail2ban-*.src.rpm
RUN sed -i 's/^Version: .*$/Version: 0.10.4/g' rpmbuild/SPECS/fail2ban.spec

RUN spectool -g -R rpmbuild/SPECS/fail2ban.spec

# Disable patch 3 - it's included in 0.10.4
RUN sed -i 's/%patch3/#%patch3/g' rpmbuild/SPECS/fail2ban.spec

# Fix service file patch
RUN sed -i 's/fail2ban.service/fail2ban.service.in/g' rpmbuild/SOURCES/fail2ban-partof.patch
RUN sed -i 's/iptables.service firewalld.service/iptables.service firewalld.service ip6tables.service ipset.service/g' rpmbuild/SOURCES/fail2ban-partof.patch
RUN sed -i 's/Type=forking/Type=simple/g' rpmbuild/SOURCES/fail2ban-partof.patch

RUN sed -i 's!files/fail2ban.service!build/fail2ban.service!g' rpmbuild/SPECS/fail2ban.spec
RUN sed -i 's!%{_mandir}/man1/fail2ban-server\.1\*!%{_mandir}/man1/fail2ban-server.1*\n%{_mandir}/man1/fail2ban-python.1*!g' rpmbuild/SPECS/fail2ban.spec

RUN rpmbuild -ba --nocheck rpmbuild/SPECS/fail2ban.spec
