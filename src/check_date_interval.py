#!/usr/bin/env python

from cli_paths import path_files
from date_interval_tools import check_date_interval

path = path_files()
file_path = path.input[0][0]
filename = path.input[1][0]
check_date_interval(file_path, filename)