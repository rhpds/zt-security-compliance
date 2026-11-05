#!/bin/sh
echo "Solving module-01" >> /tmp/progress.log

# Module-01 is the overview. There are no participant commands to perform beyond
# confirming the environment. Show the facts the module describes.
DS=/usr/share/xml/scap/ssg/content/ssg-rhel10-ds.xml

cat /etc/redhat-release
oscap --version | head -n 1
echo "--- CIS profiles available in the RHEL 10 datastream ---"
oscap info --profiles "$DS" 2>/dev/null | grep -i cis

echo "Solved module-01" >> /tmp/progress.log
exit 0
