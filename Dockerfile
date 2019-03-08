FROM opensuse/tumbleweed
MAINTAINER Jimmy Berry <jberry@suse.com>
LABEL akjsdhfiuv1zb8o07v2398u1=oihonpqbiuve

ADD valgrind-3.14.0-4.2.x86_64.rpm /
RUN rpm -i /valgrind-3.14.0-4.2.x86_64.rpm
RUN uname -a

RUN zypper -nv in glibc || :
RUN zypper -nv in libcurl4 || :
ADD libzypp-17.11.2-0.x86_64.rpm /
RUN rpm --nodeps -e libzypp
RUN rpm -i /libzypp-17.11.2-0.x86_64.rpm
RUN rm -rf /tmp/* /var/tmp/* /var/cache/* /var/log/*
#RUN valgrind --exit-on-first-error=yes --error-exitcode=42 zypper -n -vvv ref -f
RUN bash -c "ZYPP_MEDIA_CURL_DEBUG=1 ZYPP_LOGFILE=/tmp/zypplog valgrind --exit-on-first-error=yes --error-exitcode=42 zypper -n -vvv ref -f || ( cat /tmp/zypplog; exit 1 )"

RUN zypper -nv in zypper || :
RUN rm -rf /tmp/* /var/tmp/* /var/cache/* /var/log/* 
RUN bash -c "ZYPP_MEDIA_CURL_DEBUG=1 ZYPP_LOGFILE=/tmp/zypplog valgrind --exit-on-first-error=yes --error-exitcode=42 zypper -n -vvv ref -f || ( cat /tmp/zypplog; exit 1 )"
