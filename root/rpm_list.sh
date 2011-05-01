#!/bin/bash

rpm -qa                           | sort     > /root/rpm_list
rpm -qa --qf "%{group} %{name}\n" | sort     > /root/rpm_group
rpm -qa --qf "%{size} %{name}\n"  | sort -nr > /root/rpm_size
rpm -qa --last                               > /root/rpm_last
