#!/usr/bin/env python3
"""Keep the smoke command's exit status and emit one JUnit integration result."""
from pathlib import Path
import subprocess
import sys
import time
import xml.etree.ElementTree as ET

output = Path(sys.argv[1])
start = time.monotonic()
result = subprocess.run(sys.argv[2:])
duration = str(time.monotonic() - start)
failed = result.returncode != 0
suite = ET.Element('testsuite', name='Git-sourced CocoaPods', tests='1', failures='1' if failed else '0', time=duration)
case = ET.SubElement(suite, 'testcase', classname='Installation', name='PurchasesRuntimeSmoke', time=duration)
if failed:
    ET.SubElement(case, 'failure', message=f'Smoke command exited {result.returncode}').text = 'See the job output for the native bridge failure.'
output.parent.mkdir(parents=True, exist_ok=True)
ET.ElementTree(suite).write(output, encoding='unicode')
raise SystemExit(1 if failed else 0)
